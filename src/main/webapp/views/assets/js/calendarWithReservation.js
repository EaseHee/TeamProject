/*
	개발자 지정 HTML 요소의 속성값들을 정의 및 관리.
	js : camel case, html-attr : dash case
*/
let customAttributeMap = {
	nowPage: "now-page", // 현재 페이지 번호를 기록하기 위한 속성. 
	pageNum: "page-num", // 페이지 바의 각 아이콘에 페이지 번호를 부여하기 위한 속성. 
};

/*
	이미 정의된 속성값들을 모음. 
	지금 현재는 불필요한 변수이나, 나중에 필요할 수도 있어 일단 남김.
*/
let fixedAttributeValueMap = {
	pageBar : {
		pageItem: "page-item", // 페이지 아이템임을 나타내는 속성. 
		pageLink: "page-link", 
	},
	active: "active",
	arrow: {
		left: "chevron_left",
		right: "chevron_right"
	},
};

/**
 * 캘린더와 예약현황 카드 연계 로직을 위한 클래스. 
 * 
 * 기능 및 작업들
 * 1. 사용자가 달력 내 특정 날짜 칸 클릭 시 예약현황 내용이 바뀌도록 우선 활성화된 
 * 모든 날짜 칸에 addeventListener("click", ...) 이벤트 부착. 
 * 2. 현재 사용자가 클릭한 날짜의 월, 연도 데이터를 추출하기 위해 해당 요소를 DOM으로 가져옴.
 * 이는 해당 날짜에 존재하는 모든 예약현황 데이터들을 DB로부터 가져오기 위함. 
 * 3. 예약현황 요소에 사용자가 달력에서 클릭한 칸에 해당하는 날짜와 그 날짜에 해당하는 
 * 데이터들을 집어넣을 수 있도록 예약현황 요소를 DOM으로 가져와 조작. 
 * 4. DB 데이터를 서버에 요청 시 페이지 깜빡임 현상을 없애기 위해 AJAX (fetch) 기술로 
 * 데이터를 가져오는 작업. 
 * 5. 특정 날의 예약현황 데이터가 많을 경우의 페이징 기능 추가. 
 */
class CalendarAndReservation {
	
	/**
	 * "예약현황" table 요소를 다루기 위한 중첩 클래스.
	 */
	ManipulateReservationTable = class {
		constructor(reservationTableElement) {
			this.reservationTableElement = reservationTableElement;
			this._initVarsForPaging();

			this.jsonToolObj;

			this.columnNums = 4;
		}

		/**
		 * json 데이터를 다루는 툴 객체 초기화.
		 * @param {JsonObjTool} jsonToolObj 
		 */
		setJsonToolObj(jsonToolObj) {
			this.jsonToolObj = jsonToolObj;
		}

		/**
		 * 페이징 기능을 위한 변수 초기화.
		 */
		_initVarsForPaging() {
			this.numRecordsPerPage = 5; // 한 페이지에 보여줄 데이터 개수. 이미 여기서 정하면 변치 않는다. 

			this.currentPageNum = 1; // 현재 페이지 번호. 
			this.totalPages = 1;  // 전체 페이지 수. 
			this.startRecordNum = 1; // 한 페이지의 시작 번호. 
			this.endRecordNum = 1; // 한 페이지의 끝 번호. 
		}

		/**
		 * json 데이터를 받아 페이징 관련 변수들을 할당. 
		 */
		_setVarsForPaging() {
			// 현재 선택된 페이지 번호 정보 저장을 위해 이를 예약현황 카드의 table 태그의 속성으로 저장해둠. 
			this.currentPageNum = parseInt(
				this.reservationTableElement
					.getAttribute(customAttributeMap.nowPage)
			);
			this.totalPages = Math.ceil(this.jsonToolObj.getPropertyLength() / this.numRecordsPerPage);
			this.startRecordNum = 1 + (this.currentPageNum - 1) * this.numRecordsPerPage;
			this.endRecordNum = this.currentPageNum * this.numRecordsPerPage; 
		}
		
		/**
		 * 만약 선택된 날짜에 예약현황 데이터가 없을 경우 화면에 어떻게 표시할지를 결정하는 메서드.
		 */
		noReservationTableInnerHTML() {
			this.reservationTableElement.innerHTML = `
				<tr>
					<td class="text-bold-500" colspan="${this.columnNums}">예약현황이 없습니다.</td>
				</tr>`;
		}
			
		/**
	     * 예약현황 데이터를 모두 없앤다. 
		 */
	    clearReservationTableInnerHTML() {
			this.reservationTableElement.innerHTML = `<tr>
				<th>예약 시간</th>
				<th>서비스명</th>
				<th>고객명</th>
				<th>직원명</th>
			</tr>`;
		}

		/**
		 * fetch로 받아온 데이터를 토대로 예약현황 카드 목록 구성.
		 */
		constructReservationTable() {
			let data = this.jsonToolObj.getJsonData();
			if (this.jsonToolObj.isEmptyJsonObj()) {
				// json 형태 객체 내부에 데이터가 없을 경우 처리 로직.
				this.noReservationTableInnerHTML();
				return;
			}
			
			// 새 데이터들이 출력되기 위해 기존 예약현황 테이블을 초기화.
			this.clearReservationTableInnerHTML();

			this._setVarsForPaging();

			// this._setVarsForPaging()을 통해 정해진 "현재 페이지"의 데이터만 목록에 출력. 
			/* ex)
				<tr>
					<td class="text-bold-500">15:00</td>
					<td class="text-bold-500">파마</td>
				</tr>
			*/
			for (let i = this.startRecordNum; i <= this.endRecordNum; i++) {
				if (this.jsonToolObj.getPropertyLength() < i) break; 
				
				let tr = document.createElement("tr");
				
				for (let j = 0; j < data[i].length; j++) {
					let td = document.createElement("td");
					td.classList.add("text-bold-500");
					td.style = "text-align: center;";
					
					let textNode = document.createTextNode(data[i][j]);
					
					td.appendChild(textNode);
					tr.appendChild(td);
				}
				
				this.reservationTableElement.querySelector("tbody").appendChild(tr);
			}

			this._constructPageVar();
		}

		/**
		 * 예약현황 목록 아래에 페이지 바를 만든다. 
		 * 
		 * 기본 코드 구조 예시
		 * <tr>
				<td align="center" colspan="2" class="calendar-wrapper">
					<span id="prev" class="icons material-symbols-rounded" style="display: inline-block; transform: translateY(3px);">
						chevron_left
					</span>
					<span ...>...</span>  // 페이지 번호 요소. 페이지 개수만큼!
					<span id="next" class="icons material-symbols-rounded " style="display: inline-block; transform: translateY(3px);">
						chevron_right
					</span>
				</td>
			</tr>
		 */
		_constructPageVar() {
			let tr = document.createElement("tr");
			let td = document.createElement("td");
			
			// 데이터 필드 수를 대입하여 페이지 바가 양 옆으로 크게 나오도록 한다. 
			td.setAttribute("colspan", `${this.columnNums}`);
			
			td.classList.add("calendar-wrapper");

			/**
			 * 페이지 버튼 요소 생성 함수
			 * 
			 * @param {string} arrowText 
			 * @returns 
			 */
			function arrowButtonFactory(arrowText) {
				const liElement = document.createElement("li");
				liElement.classList.add(fixedAttributeValueMap.pageBar.pageItem);
				liElement.classList.add(fixedAttributeValueMap.pageBar.pageLink);
				liElement.classList.add("arrow");  // 해당 요소가 화살표 요소임을 인식.
				liElement.classList.add(arrowText);  // 왼쪽 또는 오른쪽 화살표인지 인식용.

				const spanElement = document.createElement("span");
				spanElement.setAttribute("aria-hidden", "true");

				const iElement = document.createElement("i");
				iElement.classList.add("bi");
				iElement.classList.add(`bi-${arrowText}`);
				iElement.classList.add("material-symbols-rounded");
				iElement.textContent = arrowText;

				spanElement.appendChild(iElement);
				liElement.appendChild(spanElement);

				return liElement;
			}

			/**
			 * 페이지 버튼에 할당할 이벤트 핸들러 함수.
			 * @param {*} event 
			 */
			function clickEventHandler(event) {
				let trNowPageNum = parseInt(
					this.reservationTableElement.getAttribute(customAttributeMap.nowPage)
				);

				if (event.currentTarget.classList.contains(fixedAttributeValueMap.arrow.left) && trNowPageNum > 1) {
					--trNowPageNum;
				} else if (event.currentTarget.classList.contains(fixedAttributeValueMap.arrow.right) && trNowPageNum < this.totalPages) {
					++trNowPageNum;
				}

				// 페이지 이동이 되도록 table의 now-page 속성의 값을 변경. 
				this.reservationTableElement.setAttribute(
					customAttributeMap.nowPage, 
					trNowPageNum
				);

				this.constructReservationTable();
			}

			const arrows = {
				"left" : arrowButtonFactory(fixedAttributeValueMap.arrow.left),
				"right": arrowButtonFactory(fixedAttributeValueMap.arrow.right)
			};

			arrows.left.addEventListener("click", clickEventHandler.bind(this));
			arrows.right.addEventListener("click", clickEventHandler.bind(this));

			// 페이지 바를 구성하는 요소 생성 및 구축. 
			const ulParentElement = document.createElement("ul");
			const classListToAdd = [
				"pagination", 
				"pagination-primary", 
				"d-flex",
				"justify-content-center",
				"align-items-center"
			];
			classListToAdd.forEach(attr => {
				ulParentElement.classList.add(attr);
			});

			ulParentElement.setAttribute("style", "margin-bottom: 0");

			// < ... > (페이지 바 구성)요소 넣기
			ulParentElement.appendChild(arrows.left);

			
			// 총 페이지 수 만큼 각 페이지들을 의미하는 기호를 출력. 
			for (let i = 0; i < this.totalPages; i++) {
				// 페이지 모양 통일안
				const liPageNumElement = document.createElement("li");
				liPageNumElement.classList.add(fixedAttributeValueMap.pageBar.pageItem);
				liPageNumElement.classList.add(fixedAttributeValueMap.pageBar.pageLink);
				liPageNumElement.textContent = i + 1;

				ulParentElement.appendChild(liPageNumElement);
			}

			ulParentElement.appendChild(arrows.right);

			// 화살표가 아닌 페이지 번호 요소들에 대한 이벤트 핸들러 설정.
			function pageNumHandler(event) {
				/*
				// 현재 이 코드가 제대로 작동되지 않음. 
				// 모든 페이지 번호 요소들의 active 속성 삭제. 
				ulParentElement.querySelectorAll("li:not(.arrow)").forEach(liEle => {
					console.log(liEle);
					liEle.classList.remove(fixedAttributeValueMap.active);
				});

				// 활성화 관련 설정. 
				console.log("currentTarget?");
				console.log(event.currentTarget);
				console.log(event.currentTarget.parentElement);
				event.currentTarget.classList.add("active"); */

				this.reservationTableElement.setAttribute(
					customAttributeMap.nowPage, 
					event.currentTarget.textContent
				);

				this.constructReservationTable();
			}

			// 화살표가 아닌 페이지 번호 요소들에 대한 이벤트 핸들러 설정. 
			const liPageNums = ulParentElement.querySelectorAll("li:not(.arrow)");
			for (const liPageNumElement of liPageNums) {
				liPageNumElement.addEventListener("click", pageNumHandler.bind(this));
			}
			// < ... > 요소 넣기 끝

			td.appendChild(ulParentElement);
			tr.appendChild(td);
			this.reservationTableElement.querySelector("tbody").appendChild(tr);

		}
		
	}
	
	/**
	 * json 데이터를 다루기 위한 중첩 클래스.
	 */
	JsonObjTool = class {
		jsonData;
		
		/**
		 * json 형태 객체({}) 내부에 프로퍼티가 하나도 없는지 확인하는 메서드. 
	     * @returns - boolean.  객체 내 프로퍼티가 하나도 없으면 true, 하나라도 있으면 false
		 */
		isEmptyJsonObj() {
			return (Reflect.ownKeys(this.jsonData).length == 0) ? true : false;
		}
		
		/**
		 * json 객체 내 프로퍼티의 개수 반환. 
		 */
		getPropertyLength() {

			try {
				return Reflect.ownKeys(this.jsonData).length;
			} catch (TypeError) {
				return 0;
			}
		}
		
		/**
		 * fetch로 전송받은 json 형태 데이터를 저장. 
		 */
		setJsonData(jsonObj) {
			this.jsonData = jsonObj;
		}
		
		/**
		 * 이 객체에 설정한 fetch로 전송받은 json 형태 데이터를 반환.
		 */
		getJsonData() {
			return this.jsonData;
		}
	}
	
	constructor() {
		// 사용자가 선택한 달력 내 칸에 해당하는 연도, 월, 일.
		this.selectedYear, this.selectedMonth, this.selectedDayNum;
		// 사용자가 달력에서 선택한 칸에 해당하는 날짜를 yyyy-mm-dd 형태로 저장.
		this.selectedDate;
		
		// 영어로 표기된 월 이름을 숫자로 변환하기 위한 일종의 테이블.
		this.monthTable = {
			"January": 1,
			"February": 2, 
			"March": 3, 
			"April": 4, 
			"May": 5, 
			"June": 6, 
			"July": 7,
			"August": 8, 
			"September": 9, 
			"October": 10, 
			"November": 11, 
			"December": 12
		};
		
		this.todayDateObj = new Date();
		this.todayDate = [
			this.todayDateObj.getFullYear(),
			this.todayDateObj.getMonth() + 1,
			this.todayDateObj.getDate()
		].join("-");
		
		this.jsonTool = new this.JsonObjTool();
		
		this._initElement();
		this._init();
		this._setEventHandlers();
	}
	
	/**
	 * 필요한 HTML 요소들을 가져와 초기화한다. 
	 */
	_initElement() {
		// 달력 오른쪽에 있는 "예약 현황" 카드 요소.
		this.currentReservation = document.querySelector("#current-reservation");
		
		// "예약 현황" 카드의 월, 연도 표시용 요소.
		[this.resDisplayMonth, this.resDisplayDate] = this.currentReservation
			.querySelectorAll("li:first-child span");
		
		// "예약 현황" 카드를 구성하는 table 요소
		this.reservationTable = this.currentReservation
			.querySelector("table[class='table table-bordered mb-0'");
		this.reservationTableTool = new this.ManipulateReservationTable(
			this.reservationTable
		);

		// 예약현황 <table> 요소에 현재 페이지 번호 정보 남김. 
		this.reservationTable.setAttribute(customAttributeMap.nowPage, "1");
		
		// 사용자가 보고 있는 달에 해당하는 달력 칸 요소들.
		this.activeCells = document.querySelectorAll(".days > li:not(.inactive)");
		this.calendarUl = document.querySelector(".days");
		
		// 처음 대시보드 페이지를 열었을 때 달력에 보이는 월, 연도 표시용 요소들을 가져옴.
		[this.selectedMonth, this.selectedYear] = document
			.querySelector(".current-date").textContent.split(" ");
	}
	
	/**
	 * 사용자가 처음 대시보드에 왔을 때 필요한 작업들을 처리. 
	 */
	_init() {
		// 예약현황 카드 상단에 오늘 날짜가 뜨도록 함.
		this.resDisplayMonth.textContent = this.todayDateObj.getMonth() + 1;
		this.resDisplayDate.textContent = this.todayDateObj.getDate();
		
		// 오늘 날짜에 대한 예약현황 데이터를 가져와 목록으로 표시.
		this._fetchAndShowReservation();
	}
	
	_setEventHandlers() {
		
		// 캘린더 내 활성화되어 있는 모든 날짜에 클릭 시 처리할 작업들에 대해,
		// 각 날짜 칸에 일일이 이벤트 핸들러를 부여하지 않고 
		// 이벤트 위임을 이용하여 부모 요소인 캘린더 자체에 이벤트 핸들러 부여함. 
		this.calendarUl.addEventListener("click", event => {
			if (event.target.tagName !== "LI") return;
			
			// 사용자가 달력에서 선택한 칸에 해당하는 날짜 정보들을 취합.
			this.selectedDayNum = event.target.textContent;
			[this.selectedMonth, this.selectedYear] = document
				.querySelector(".current-date").textContent.split(" ");
			this.selectedMonth = this.monthTable[this.selectedMonth];
			
			// 사용자가 달력에서 선택한 날짜의 월, 연도를 "예약 현황" 카드에 표시. 
			this.resDisplayMonth.textContent = this.selectedMonth;
			this.resDisplayDate.textContent = this.selectedDayNum;
			
			// DB에 전송하기 위한 yyyy-mm-dd 형태의 문자열 데이터 구성. 
			this.selectedDate = [
				this.selectedYear, 
				this.selectedMonth, 
				this.selectedDayNum
			].join("-");
			
			this._fetchAndShowReservation();
		});
	}
	
	/**
	 * 사용자가 달력에서 선택한 칸에 해당하는 yyyy-mm-dd 형태의 날짜를 DB에 전송 후, 
	 * 그 날짜에 해당하는 예약 시간 및 예약 서비스명 데이터를 가져와 "예약현황" 카드 테이블에 
	 * 출력한다. 
	 */
	_fetchAndShowReservation() {
		let dateToInput = (this.selectedDate == undefined)? this.todayDate : this.selectedDate;
		 
		fetch(`/TeamProject/dashboard?command=CALENDAR_RESERVATION&date=${dateToInput}`)
			.then(response => response.json())
			.then(data => {
				this.jsonTool.setJsonData(data);
				this.reservationTableTool.setJsonToolObj(this.jsonTool);
				this.reservationTable.setAttribute(customAttributeMap.nowPage, "1"); // 현재 페이지를 항상 1로 초기화.
				this.reservationTableTool.constructReservationTable();
			});
	}
	
}
//console.log("new hi2"); // For test

new CalendarAndReservation();

