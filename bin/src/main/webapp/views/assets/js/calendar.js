/* 날짜(일) */
const daysTag = document.querySelector(".days"),
/* 이번 달, 연도  */
currentDate = document.querySelector(".current-date"),
/* 월별 이동 아이콘 배열 */
prevNextIcon = document.querySelectorAll(".icons span");

/* 날짜 저장 */
let date = new Date(),
currYear = date.getFullYear(),
currMonth = date.getMonth();

/* 월별 이름 배열에 저장 */
const months = ["January", "February", "March", "April", "May", "June", "July",
                 "August", "September", "October", "November", "December"];
                 
/* 캘린더 날짜 출력 */
const renderCalendar = () => {
    /* 월별 첫 날, 마지막 날, 마지막 날의 요일, 이전 달의 마지막 날 */
    let firstDayofMonth = new Date(currYear, currMonth, 1).getDay(), 
    lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate(), //  30 | 31일
    lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(), // 일요일 : 0 ~ 토요일 : 6
    lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate(); 
    /* 날짜(숫자) 입력 li 태그 */
    let liTag = "";

    /* 달력에 표시되는 지난 달 날짜 _ 비활성화 */
    for (let i = firstDayofMonth; i > 0; i--) { 
        liTag += `<li class="inactive">${lastDateofLastMonth - i + 1}</li>`;
    }
    /* 이번 달의 일수 출력 _ 활성화  */
    for (let i = 1; i <= lastDateofMonth; i++) { 
        // 오늘 날짜 활성화
        let isToday = i === date.getDate() && currMonth === new Date().getMonth() 
                     && currYear === new Date().getFullYear() ? "active" : "";
        liTag += `<li class="${isToday}">${i}</li>`;
    }
    /* 달력에 표시되는 다음 달 날짜 _ 비활성화 */
    for (let i = lastDayofMonth; i < 6; i++) { 
        liTag += `<li class="inactive">${i - lastDayofMonth + 1}</li>`
    }
    /* 캘린더 헤더 _ 현재 월, 연도 */
    currentDate.innerText = `${months[currMonth]} ${currYear}`;
    daysTag.innerHTML = liTag;
	
	/* 각 날짜(li 태그)를 클릭했을 때 active 클래스를 변경하는 이벤트 리스너 추가 */
	const allDays = daysTag.querySelectorAll("li:not(.inactive)");
	allDays.forEach(day => {
	    day.addEventListener("click", () => {
	        // 모든 li에서 active 클래스 제거
	        allDays.forEach(d => d.classList.remove("active"));
	        // 클릭한 날짜에 active 클래스 추가
	        day.classList.add("active");
	    });
	});
}
renderCalendar();

/* 월별 이동 아이콘 클릭 이벤트 추가 */
prevNextIcon.forEach(icon => {
    icon.addEventListener("click", () => {
        // 아이콘 클릭 시 이번 달(currMonth _ 출력 데이터) 값 증가 혹은 감소
        currMonth += (icon.id === "prev" ? - 1 : + 1);

        /* 날짜 인스턴스 생성 */
        /* 조건식 : 이번 달의 값이 0(=1월)보다 작거나 11(=12월)보다 클 경우 */
        if(currMonth < 0 || currMonth > 11) { 
            // 새로운 날짜 인스턴스 생성
            date = new Date(currYear, currMonth, new Date().getDate());
            currYear = date.getFullYear(); 
            currMonth = date.getMonth(); 
        /* 조건식 : 이번 달의 값이 0~11 내에 있을 경우  */    
        } else {
            date = new Date(); 
        }
        /* 날짜 출력 함수 호출 */
        renderCalendar(); 
    });
});


