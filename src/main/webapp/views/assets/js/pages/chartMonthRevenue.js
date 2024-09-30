// // dashboard.jsp _ 월별 서비스 매출 현황 출력용 설정 변경

let barOptions;

let setOptions = (services, revenues) => {
 barOptions = {
   series: [
     {
       name: "Revenue", // 해당 막대의 데이터 속성
       data: revenues, // y축 데이터
     }
   ],
   chart: {
     type: "bar",
   },
   plotOptions: {
     bar: {
       horizontal: false,
       columnWidth: "55%",
       endingShape: "rounded",
     },
   },
   dataLabels: {
     enabled: true, // 데이터 포인트에 레이블 출력 여부 결정
   },
   stroke: {
     show: true, // bar의 테두리(border) 표시 여부 
     width: 2,
     colors: ["transparent"], // 테두리는 보이지 않게? 그럼 왜 true로 했지???
   },
   xaxis: {
     categories: services, // x축 데이터 (문자열 전달)
   },
   yaxis: {
     title: {
       text: "(단위 : 만원)",
     },
   },
   fill: {
     opacity: 1,
   },
   tooltip: {
     y: {
       formatter: function(val) {
         return val + " 만원";
       },
     },
   },
 };
}
// 외부 호출용 함수
let getServiceRevenueChart = (services, revenues) => {
 // 그래프 옵션 설정
 setOptions(services, revenues);
 // 그래프 출력 메서드 호출
 new ApexCharts(document.querySelector("#bar"), barOptions).render();
}
