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
 */
class CalendarAndReservation {
	constructor() {
		// 사용자가 선택한 달력 내 칸에 해당하는 연도, 월, 일.
		this.selectedYear, this.selectedMonth, this.selectedDayNum;
		// 사용자가 달력에서 선택한 칸에 해당하는 날짜를 yyyy-mm-dd 형태로 저장.
		this.selectedDate;
		
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
		this.resDisplayMonth.textContent = this.todayDateObj.getMonth() + 1;
		this.resDisplayDate.textContent = this.todayDateObj.getDate();
		this._fetchAndShowReservation();
	}
	
	_setEventHandlers() {
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
				// for test === 
				/*
				console.log('hi from fetch response');
				console.log("response data: ");
				console.log(data);
				console.log(data.length);
				*/
				// for test code end ===
				
				// 가져온 데이터들을 토대로 목록 구성. 
				for (let key in data) {
					console.log(key + " : " + data);
					let tr = document.createElement("tr");
					let td = document.createElement("td");
					td.setAttribute("class", "text-bold-500");
					for (let i = 0; i < 2; i++) {
						let textNode = document.createTextNode(data[key][i]);
						td.appendChild(textNode);
					}
					
					tr.appendChild(td);
				}
			});
	}
	
}
//console.log('hi'); // For test

new CalendarAndReservation();

