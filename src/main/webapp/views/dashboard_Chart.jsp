<%@page import="bean.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<script src="assets/js/pages/chartMonthRevenue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="module">
    /* 
        1. 페이지 로드 (class ServiceChart 생성자 호출) 
        2. _initElement () : indexMonth = 0 으로 그래프 출력
        3. _setEventHandler() : '<', '>' 버튼 클릭 시 indexMonth 값 변경 후 실행 함수 호출 _ "Ajax"
        4. _fetchAndShowChart() : DashboardServlet에 command 변수 전달 & 차트 실행 함수 호출
        5. 
    */

</script>
<div class="card" id="chart">
    <div style="text-align: end; margin:auto">
        <!-- Ajax 비동기 처리 구현할 것 -->
        <span id="prevMonth" class="icons material-symbols-rounded" tabindex="0">chevron_left</span>
        <span id="nextMonth" class="icons material-symbols-rounded" tabindex="0">chevron_right</span>
    </div>
    <div id="service"></div>
</div>
