<%@page import="bean.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<script src="assets/js/pages/chartMonthRevenue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="module">
    /* 
        1. DAO 객체 생성, DB 데이터 조회
            setService() : DB 데이터 조회 및 저장
        2. 
    */

    let index = 0;
    if (request.getParameter("indexMonth") != null) {
        index = Integer.parseInt(request.getParameter("indexMonth"));
    }
    document.getElementById("prevMonth").addEventListener("click", (e) => {
        index += 1;
    });
    document.getElementById("nextMonth").addEventListener("click", (e) => {
        index -= 1;
    });

    axios ({
        url : "http://localhost:8080/TeamProject/dashboard",
        method : "post",
        data : {
            command : "CHART_SERVICE",
            indexMonth : index
        }
    })
    .then(response => {
// test
console.log("dashboard_Chard.jsp");
console.log(response.data.service, response.data.revenue);
        // JSONObject 객체를 반환하여 service, revenue 변수를 전달하여 함수 호출
        getServiceRevenueChart(response.data.service, response.data.revenue);
        // *** axios에서는 자체적으로 data라는 속성을 사용하고 있기 때문에 별도의 매개변수를 설정해야 한다. ***
        // *** 데이터에 접근할 때 .data 객체를 거쳐서 접근한다. ***
    })
</script>
<jsp:useBean id="dashDAO" class="bean.DashboardDAO" />

<div class="card">
    <div style="text-align: end; margin:auto">
        <!-- Ajax 비동기 처리 구현할 것 -->
        <a href="dashboard.jsp?indexMonth=${indexMonth +1}"><span id="prevMonth" class="icons material-symbols-rounded">chevron_left</span></a>
        <a href="dashboard.jsp?indexMonth=${indexMonth -1}"><span id="nextMonth" class="icons material-symbols-rounded">chevron_right</span></a>
    </div>
    <div id="bar"></div>
</div>
