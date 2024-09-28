<%@page import="bean.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DashBoard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="assets/css/calendar.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/iconly/bold.css">
    <link rel="stylesheet" href="assets/vendors/apexcharts/apexcharts.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">

	<style>
		td {
			white-space: nowrap; /* 텍스트 줄바꿈 방지 */
			overflow: hidden; /* 넘치는 텍스트 숨기기 */
			text-overflow: ellipsis; /* 넘치는 부분 '...'으로 표시 */
			max-width: 150px; /* 최대 너비 설정 */
		}
	</style>
</head>

<body>
    <jsp:useBean id="dashDAO" class="bean.DashboardDAO"></jsp:useBean>
    <%
		request.setCharacterEncoding("utf-8");
		int numPerPage = 5; 	//한 페이지 당 보여질 글의 개수
		
		int totalRecord1 = 0; 	//총 글의 개수
		int totalPage1 = 0; 		//총 페이지 수
		int nowPage1 = 0; 		//현재 페이지
		int beginPerPage1 = 0; 	//페이지별 시작번호
		ArrayList<DashboardDTO> list1 = (ArrayList<DashboardDTO>) dashDAO.getProduct();
		totalRecord1 = list1.size();
		totalPage1 = (totalRecord1 + numPerPage - 1) / numPerPage;
		if(request.getParameter("nowPage1") != null ){
			nowPage1 = Integer.parseInt(request.getParameter("nowPage1"));
			if(nowPage1 == -1){
				if(totalPage1 > 0){
					nowPage1 = totalPage1 - 1;
				}
				else nowPage1 = 0;
			}
			if(nowPage1 == totalPage1){
				nowPage1 = 0;
			}											
		}		
		beginPerPage1 = nowPage1*numPerPage;
		
		int totalRecord2 = 0; 	//총 글의 개수
		int totalPage2 = 0; 		//총 페이지 수
		int nowPage2 = 0; 		//현재 페이지
		int beginPerPage2 = 0; 	//페이지별 시작번호
		ArrayList<DashboardDTO> list2 = (ArrayList<DashboardDTO>) dashDAO.getReservation();
		totalRecord2 = list2.size();
		totalPage2 = (totalRecord2 + numPerPage - 1) / numPerPage;
		if(request.getParameter("nowPage2") != null ){
			nowPage2 = Integer.parseInt(request.getParameter("nowPage2"));
			if(nowPage2 == -1){
				if(totalPage2 > 0){
					nowPage2 = totalPage2 - 1;
				}
				else nowPage2 = 0;
			}
			if(nowPage2 == totalPage2){
				nowPage2 = 0;
			}											
		}		
		beginPerPage2 = nowPage2*numPerPage;
    %>

    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="#">LOGO</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>

                        <li class="sidebar-item active ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>HOME</span>
                            </a>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>CUSTOMER</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="customer.jsp">회원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="customer.jsp">기타</a>
                                </li>                                
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-collection-fill"></i>
                                <span>RESERVATION</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="reservation.jsp">예약 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="reservation.jsp">기타</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>SERVICE</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="service.jsp">서비스 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="service.jsp">기타</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>PRODUCT</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="product.jsp">상품 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="product.jsp">기타</a>
                                </li>
                             </ul>
                        </li>
 
                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-pen-fill"></i>
                                <span>NOTICE</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="notice_list.jsp">공지 사항</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="notice_list.jsp">기타</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
            </div>
        </div>
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>DASH BOARD</h3>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="login.jsp">로그아웃</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <hr style="height: 5px;">
                <section id="basic-list-group">
                    <div class="row match-height">
                        <div class="col-lg-3 col-md-12">                            
	                        <div class="card">
	                            <ul class="list-group">
	                                <li class="list-group-item active text-center">공지&nbsp;<a class="icon-link icon-link-hover" style="--bs-icon-link-transform: translate3d(0, -.125rem, 0); color:white;"
										href="notice_list.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" /><path	d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4" /></svg></a></li>
	                                <li class="list-group-item">시스템 사용법</li>
	                                <li class="list-group-item">업데이트 안내</li>
	                                <li class="list-group-item">사용법</li>
	                                <li class="list-group-item">공지 오류해결</li>                                            
	                            </ul>
	                        </div>
                        </div>

                        
                        <div class="col-lg-9 col-md-12">
                            <div class="card">
                                <div id="bar"></div>
							</div>
                        </div>

                        <jsp:setProperty name="dashDAO" property="service" value="0"/>
                        <%
                            request.setCharacterEncoding("utf-8");
                            String services = dashDAO.getServices();
                            String revenues = dashDAO.getRevenues();
                        %>
                        <!-- 외부 JS 파일에 데이터 전달 -->
                        <script src="assets/js/pages/ui-apexchart.js"></script>
                        <script>
                            console.log('<%= services %>');
                            console.log('<%= revenues %>');
                            let services = JSON.parse('<%= services %>');
                            let revenues = JSON.parse('<%= revenues %>');
                            console.log(services + revenues);
                            getServiceRevenueChart(services, revenues);
                        </script> 

                        
                    </div>
                </section>
                <section class="list-group-button-badge">
                	<div class="row match-height">
                        <div class="col-lg-3 col-md-12">
                   	        <div class="card">
	                            <ul class="list-group">
	                                <li class="list-group-item active text-center">재고수량&nbsp;<a class="icon-link icon-link-hover" style="--bs-icon-link-transform: translate3d(0, -.125rem, 0); color:white;"
										href="product.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" /><path	d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4" /></svg></a></li>
	                            </ul>
								<table class="table table-bordered mb-0">
									<%
										for(int i = beginPerPage1; i < beginPerPage1 + numPerPage; i++){
											if(i==totalRecord1) break;
											DashboardDTO board1 = list1.get(i);
									%>
										<tr>
											<td class="text-bold-500"><%=board1.getPd_name()%></td>
											<td class="text-bold-500"><%=board1.getPd_ea()%>개</td>
										</tr>
									<%
										}
									%>
										<tr>
											<td align="center" colspan="2" class="calendar-wrapper">
												<a href="dashboard.jsp?nowPage1=<%=nowPage1 - 1%>&nowPage2=<%=nowPage2%>"><span id="prev" class="icons material-symbols-rounded">chevron_left</span></a>
											<%												
												for(int i=0; i < totalPage1; i++){
											%>
												<i class="bi bi-dot"></i>
											<%
												}
											%>
												<a href="dashboard.jsp?nowPage1=<%=nowPage1 + 1%>&nowPage2=<%=nowPage2%>"><span id="next" class="icons material-symbols-rounded">chevron_right</span></a>

											</td>
										</tr>
								</table>
							</div>	                        
                        </div>
                        <div class="col-lg-6 col-md-12 d-flex justify-content-center align-items-center">							
								<div class="calendar-wrapper">
									<header>
										<p class="current-date"></p>
										<div class="icons">
											<span id="prev" class="material-symbols-rounded">chevron_left</span>
											<span id="next" class="material-symbols-rounded">chevron_right</span>
										</div>
									</header>
									<div class="calendar">
										<ul class="weeks">
											<li>Sun</li>
											<li>Mon</li>
											<li>Tue</li>
											<li>Wed</li>
											<li>Thu</li>
											<li>Fri</li>
											<li>Sat</li>
										</ul>
									<ul class="days"></ul>
									</div>
								</div>							
                        </div>
                        <jsp:useBean id="ld" class="bean.DateDTO" scope="page"></jsp:useBean>
                        <div class="col-lg-3 col-md-12">                            
	                        <div class="card">
	                            <ul class="list-group">
	                                <li class="list-group-item active text-center"><jsp:getProperty property="month" name="ld"/>월 <jsp:getProperty property="day" name="ld"/>일 예약현황&nbsp;<a class="icon-link icon-link-hover" style="--bs-icon-link-transform: translate3d(0, -.125rem, 0); color:white;"
										href="reservation.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" /><path	d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4" /></svg></a></li>
	                            </ul>                                        
              					<table class="table table-bordered mb-0">
									<%
										for(int i = beginPerPage2; i < beginPerPage2 + numPerPage; i++){
											if(i==totalRecord2) break;
											DashboardDTO board2 = list2.get(i);
									%>
										<tr>
											<td class="text-bold-500"><%=board2.getRes_time()%></td>
											<td class="text-bold-500"><%=board2.getSer_name()%></td>
										</tr>
									<%
										}
									%>
										<tr>
											<td align="center" colspan="2" class="calendar-wrapper">
												<a href="dashboard.jsp?nowPage1=<%=nowPage1%>&nowPage2=<%=nowPage2 - 1%>"><span id="prev" class="icons material-symbols-rounded">chevron_left</span></a>
											<%												
												for(int i=0; i < totalPage2; i++){
											%>
												<i class="bi bi-dot"></i>
											<%
												}
											%>
												<a href="dashboard.jsp?nowPage1=<%=nowPage1%>&nowPage2=<%=nowPage2 + 1%>"><span id="next" class="icons material-symbols-rounded">chevron_right</span></a>

											</td>
										</tr>
								</table>
	                        </div>
                        </div>
                	</div>
                        
                </section>
            <footer>
                <div class="footer clearfix mb-0 text-muted">
                    <div class="float-start">
                        <p>2024 &copy; ACORN</p>
                    </div>
                    <div class="float-end">
                        <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a
                                href="#">거니네조</a>
                        </p>                                
                    </div>
                </div>
            </footer>
	        </div>
	    </div>
    </div>
<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendors/apexcharts/apexcharts.js"></script>
<script src="assets/js/pages/dashboard.js"></script>
<!-- <script src="assets/js/pages/ui-apexchart.js"></script> --><!-- 그래프 ui 설정 변경 js 파일 _ 축별 설정 및 데이터 전달 시 해당 파일 참조 -->
<script src="assets/js/main.js"></script>
<script src="assets/js/calendar.js" defer></script>
</body>

</html>