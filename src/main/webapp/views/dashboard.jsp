<%@page import="bean.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 화면</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="/TeamProject/views/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/vendors/iconly/bold.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/vendors/apexcharts/apexcharts.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/app.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/calendar.css">
	<link rel="stylesheet" href="/TeamProject/views/assets/css/dashboardReservation.css" >
    <link rel="shortcut icon" href="/TeamProject/views/assets/images/favicon.svg" type="image/x-icon">
</head>

<body>
    <jsp:useBean id="dashDAO" class="bean.DashboardDAO"></jsp:useBean>
    <%
		ArrayList<DashboardDTO> list0 = (ArrayList<DashboardDTO>) dashDAO.getNotice();		
		ArrayList<DashboardDTO> list1 = (ArrayList<DashboardDTO>) dashDAO.getProduct();
		int numPerPage = 5; 	//한 페이지 당 보여질 글의 개수		
		int totalRecord = 0; 	//총 글의 개수
		int totalPage = 0; 		//총 페이지 수
		int nowPage = 0; 		//현재 페이지
		int beginPerPage = 0; 	//페이지별 시작번호
		int pagePerBlock = 3;	//블럭 당 페이지 수
		int totalBlock = 0; 	//총 블럭 수
		int nowBlock = 0;		//현재 블럭
		totalRecord = list1.size();
		totalPage = (totalRecord + numPerPage - 1) / numPerPage;
		
		if(request.getParameter("nowPage") != null )
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
		
		beginPerPage = nowPage*numPerPage;
		totalBlock = (totalPage + pagePerBlock - 1)/pagePerBlock;
		//totalBlock = (int)Math.ceil((double)totalPage / numPerBlock);
		
		if(request.getParameter("nowBlock") != null )
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
		beginPerPage = nowPage*numPerPage;
    %>

    <div id="app">
		<jsp:include page="/views/header.jsp" ></jsp:include>
                <section id="basic-list-group">
                    <div class="row match-height">
                        <div class="col-lg-3 col-md-12">
	                        <div class="card">
	                            <ul class="list-group">
	                                <li class="list-group-item active text-center">공지&nbsp;<a class="icon-link icon-link-hover" style="--bs-icon-link-transform: translate3d(0, -.125rem, 0); color:white;"
										href="notice_list.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" /><path	d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4" /></svg></a>
									</li>
	                               	<%
										for(int i=0; i<list0.size(); i++){											
											DashboardDTO board0 = list0.get(i);
									%>									
										<li class="list-group-item text-bold-500 detail">
											<a  href="notice_view.jsp?notice_no=<%=board0.getNotice_no()%>"> <%=board0.getNotice_title()%></a>
										</li>
									<%
										}
									%>                                           
	                            </ul>
	                        </div>
                        </div>

						<!-- 월별 매출 통계 시작  [관련 파일]: "/assets/js/pages/chartMonthRevenue.js" -->
                        <div class="col-lg-9 col-md-12">
							<div class="card h-80" >
								<ul class="list-group">
									<li class="list-group-item active text-center">
										<div id="chart-title"></div>
									</li>
									<li class="list-group-item">
										<div id="revenue"></div>
									</li>
								</ul>
                            </div>
                        </div>
						<!-- 월별 매출 통계 종료 -->
                        
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
									<%	//대시보드에 재고 3개 이하 상품 노출
										for(int i = beginPerPage; i < beginPerPage + numPerPage; i++){
											if(i==totalRecord) break;
											DashboardDTO board1 = list1.get(i);
									%>
										<tr>
											<td class="text-bold-500"><%=board1.getProduct_name()%></td>
											<td class="text-bold-500"><%=board1.getProduct_ea()%>개</td>
										</tr>
									<%
										}
									%>

										<tr>
											<td align="center" colspan="2" >
												<ul class="pagination pagination-primary d-flex justify-content-center align-items-center" style="margin-bottom: 0">
													<li class="page-item <%= (nowBlock==0) ? "disabled" : " "%>">
														<a class="page-link" href="dashboard.jsp?nowPage=<%=(nowBlock-1)*pagePerBlock%>&nowBlock=<%=nowBlock - 1 %>">
															<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
														</a>
													</li>
												<%
													if(nowBlock != totalBlock-1){
														for(int i=0; i < pagePerBlock; i++){
												%>
													<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
														<a class="page-link" href="dashboard.jsp?nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
													</li>
												<%	
														}
													}else{
														if(totalPage%pagePerBlock != 0){
															for(int i=0; i < totalPage%pagePerBlock; i++){
												%>
													<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
														<a class="page-link" href="dashboard.jsp?nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
													</li>
												<%
															}
														}else{
															for(int i=0; i < pagePerBlock; i++){
												%>
													<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
														<a class="page-link" href="dashboard.jsp?nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
													</li>
												<%																	
															}
														}														
													}
												%>
													<li class="page-item <%= (nowBlock==totalBlock-1) ? "disabled" : " "%>">
														<a class="page-link" href="dashboard.jsp?nowPage=<%=(nowBlock+1)*pagePerBlock%>&nowBlock=<%=nowBlock + 1 %>">
															<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
														</a>
													</li>
												</ul>
											</td>
										</tr>
										
								</table>
							</div>	                        
                        </div>
                        <!-- 캘린더 -->
                        <div class="col-lg-5 col-md-12 d-flex justify-content-center align-items-center">
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
                        
                        <!-- 예약현황 카드 -->
                        <div class="col-lg-4 col-md-12">                            
	                        <div class="card" id="current-reservation">
	                            <ul class="list-group">
	                                <li class="list-group-item active text-center"><span></span>월 <span></span>일 예약현황&nbsp;<a class="icon-link icon-link-hover" style="--bs-icon-link-transform: translate3d(0, -.125rem, 0); color:white;"
										href="reservation.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z" /><path	d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4" /></svg></a></li>
	                            </ul>
              					<table class="table table-bordered mb-0">
						<%-- <%
										for(int i = beginPerPage2; i < beginPerPage2 + numPerPage; i++){
											if(i==totalRecord2) break;
											DashboardDTO board2 = list2.get(i);
									%>
										<tr>
											<td class="text-bold-500"><%=board2.getReservation_time()%></td>
											<td class="text-bold-500"><%=board2.getService_name()%></td>
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
										</tr>  --%>	
								</table>
	                        </div>
                        </div>
                	</div>
                        
                </section>
			<jsp:include page="/views/footer.jsp"></jsp:include>

</body>

</html>