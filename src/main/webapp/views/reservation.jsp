<%@page import="bean.ReservationDAO"%>
<%@page import="java.util.List"%>
<%@page import="bean.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RESERVATION</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
</head>

<body>
    <jsp:useBean id="dao" class="bean.ReservationDAO"/>
    <jsp:useBean id="dto" class="bean.ReservationDTO"/>
    <%
        request.setCharacterEncoding("utf-8");
    	
		//페이징에 필요한 변수들
		int totalRecord = 0; //총 글의 개수
		int numPerPage = 10; //한 페이지 당 보여질 글의 개수
		int totalPage = 0; //총 페이지 수
		int nowPage = 0; // 현재 선택된 페이지
		int beginPerPage = 0; // 페이지별 시작 번호
		int pagePerBlock = 5; // 블럭 당 페이지 수
		int totalBlock = 0; //총 블럭 수
		int nowBlock = 0; //현재 블럭
		
    
		// 검색 후 페이지로 돌아갔을 때 가지고갈 요소들
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		ArrayList<ReservationDTO> list = new ArrayList<>();
		       
        System.out.println("keyField: " + keyField);
        System.out.println("keyWord: " + keyWord);
        
     	// 날짜 조회 설정
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // 날짜 조회 결과
        ArrayList<ReservationDTO> dateList = (ArrayList)dao.getReservationDateSearch(startDate, endDate);
        
        // 날짜 조회 결과에 따른 총 예약 수
        totalRecord = dateList.size();
        totalPage = (int)Math.ceil((double)totalRecord / numPerPage);

        if (request.getParameter("nowPage") != null)
            nowPage = Integer.parseInt(request.getParameter("nowPage"));

        beginPerPage = nowPage * numPerPage;

        // 페이지 수 및 블럭 수 계산
        totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);

        if (request.getParameter("nowBlock") != null)
            nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
		
     	// 현재 페이지에 해당하는 데이터만 담는 리스트 생성
        ArrayList<ReservationDTO> currentPageList = new ArrayList<>();
        for (int i = beginPerPage; i < beginPerPage + numPerPage && i < totalRecord; i++) {
            currentPageList.add(dateList.get(i));
        }
     	
    %>
    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="#"><img src="assets/images/logo/logo.png" alt="Logo">LOGO</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>
                        <li class="sidebar-item"><a href="dashboard.jsp" class='sidebar-link'><i class="bi bi-grid-fill"></i> <span>HOME</span></a></li>
                        <li class="sidebar-item has-sub"><a href="#" class='sidebar-link'><i class="bi bi-stack"></i> <span>CUSTOMER</span></a>
                            <ul class="submenu">
                                <li class="submenu-item"><a href="customer.jsp">회원 관리</a></li>
                                <li class="submenu-item"><a href="customer.jsp">기타</a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item active has-sub"><a href="#" class='sidebar-link'><i class="bi bi-collection-fill"></i> <span>RESERVATION</span></a>
                            <ul class="submenu">
                                <li class="submenu-item active"><a href="reservation.jsp">예약 관리</a></li>
                                <li class="submenu-item"><a href="reservation.jsp">기타</a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item has-sub"><a href="#" class='sidebar-link'><i class="bi bi-grid-1x2-fill"></i> <span>SERVICE</span></a>
                            <ul class="submenu">
                                <li class="submenu-item"><a href="service.jsp">서비스 관리</a></li>
                                <li class="submenu-item"><a href="service.jsp">기타</a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item has-sub"><a href="#" class='sidebar-link'><i class="bi bi-hexagon-fill"></i> <span>PRODUCT</span></a>
                            <ul class="submenu">
                                <li class="submenu-item"><a href="product.jsp">상품 관리</a></li>
                                <li class="submenu-item"><a href="product.jsp">기타</a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item has-sub"><a href="#" class='sidebar-link'><i class="bi bi-pen-fill"></i> <span>NOTICE</span></a>
                            <ul class="submenu">
                                <li class="submenu-item"><a href="notice_list.jsp">공지 사항</a></li>
                                <li class="submenu-item"><a href="notice_list.jsp">기타</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <button class="sidebar-toggler btn x">
                    <i data-feather="x"></i>
                </button>
            </div>
        </div>
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none"> <i class="bi bi-justify fs-3"></i></a>
            </header>

            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3><a href="reservation.jsp">예약 관리</a></h3>
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
				<div class="row form-group">
					<form method="get" action="reservation.jsp" class="col-4 d-flex">
  	  					<input type="date" class="form-control" id="startDate" name="startDate" value="<%= startDate != null ? startDate : "" %>">&nbsp;&nbsp;~&nbsp;&nbsp;
   						<input type="date" class="form-control" id="endDate" name="endDate" value="<%= endDate != null ? endDate : "" %>">
   						<input type="submit" class="btn btn-outline-success" value="조회">
					</form>
					<form class="col-4 d-flex"></form>
					<form method="get" action="reservation.jsp" class="col-4 d-flex justify-content-end align-items-end">
    <input type="hidden" name="keyField" value="<%= (keyField != null) ? keyField : "customer_name" %>"> 
    <input type="text" name="keyWord" placeholder="검색" class="form-control" value="<%= keyWord != null ? keyWord : "" %>">
    <input type="submit" class="btn btn-outline-success" value="조회">
</form>

				</div>
				<section class="section">
                    <div class="buttons d-flex justify-content-end align-items-end">
                        <a href="reservationPost.jsp" class="btn btn-outline-success" style="margin-right:0px">등록</a>
                    </div>
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0" id="table">
                                            <thead>
                                                <tr>
                                                    <th>예약번호</th>
                                                    <th>예약품목</th>
                                                    <th>예약날짜</th>
                                                    <th>예약시간</th>
                                                    <th>예약자명</th>
                                                    <th>특이사항</th>
                                                </tr>
                                            </thead>
											<tbody>
												<%
													// currentPageList를 기반으로 예약 목록 출력
													for (ReservationDTO reservationDTO : currentPageList) {
												%>
												<tr>
													<td><%=reservationDTO.getReservation_no()%></td>
													<td><%=reservationDTO.getService_name() != null ? reservationDTO.getService_name() : ""%></td>
													<td><%=reservationDTO.getReservation_date() != null ? reservationDTO.getReservation_date() : ""%></td>
													<td><%=reservationDTO.getReservation_time() != null ? reservationDTO.getReservation_time() : ""%></td>
													<td><a href="reservationRead.jsp?reservation_no=<%=reservationDTO.getReservation_no()%>"><%=reservationDTO.getCustomer_name() != null ? reservationDTO.getCustomer_name() : ""%></a></td>
													<td><%=reservationDTO.getReservation_comm() != null ? reservationDTO.getReservation_comm() : ""%></td>
												</tr>
												<%
    												}
    											%>
											</tbody>
										</table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="buttons d-flex justify-content-end align-items-end">
                        <button onclick="downloadExcel();" class="btn btn-outline-warning" style="margin-right:0px">엑셀 다운로드</button>
                    </div>
					<div class="col-12 d-flex justify-content-center align-items-center">
						<nav aria-label="Page navigation example">
							<ul class="pagination pagination-primary">
								<!-- 왼쪽 화살표 이동 기능 -->
								<%
									if (nowBlock == 0) {
								%>
										<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true"> 
										<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a></li>
								<%
									} else {
								%>
										<li class="page-item"><a class="page-link" href="reservation.jsp?nowPage=<%=((nowBlock - 1) * pagePerBlock)%>&nowBlock=<%=nowBlock - 1%>&startDate=<%=startDate != null ? startDate : ""%>&endDate=<%=endDate != null ? endDate : ""%>">
										<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
										</a></li>
								<%
									}
								%>

								<!-- 페이지 반복 -->
								<%
									for (int i = 0; i < pagePerBlock; i++) {
										int currentPage = (nowBlock * pagePerBlock) + i;
										if (currentPage >= totalPage)
											break;
								%>
										<li class="page-item <%=currentPage == nowPage ? "active" : ""%>">
										<a class="page-link" href="reservation.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>&startDate=<%=startDate != null ? startDate : ""%>&endDate=<%=endDate != null ? endDate : ""%>">
											<%=currentPage + 1%></a></li>
								<%
									}
								%>

								<!-- 오른쪽 화살표 이동 기능 -->
								<%
									if (nowBlock >= totalBlock - 1) {
								%>
										<li class="page-item disabled"><a class="page-link" href="#"> <span aria-hidden="true">
										<i class="bi bi-chevron-right"></i></span></a></li>
								<%
									} else {
								%>
										<li class="page-item"><a class="page-link" href="reservation.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock%>&nowBlock=<%=nowBlock + 1%>&startDate=<%=startDate != null ? startDate : ""%>&endDate=<%=endDate != null ? endDate : ""%>">
										<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
										</a></li>
								<% } %>
							</ul>
						</nav>
					</div>
				</section>
                <footer>
                    <div class="footer clearfix mb-0 text-muted">
                        <div class="float-start">
                            <p>2024 &copy; ACORN</p>
                        </div>
                        <div class="float-end">
                            <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a href="#">거니네조</a></p>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
        <script>
            function downloadExcel() {
                var table = document.getElementById("table");
                var wb = XLSX.utils.table_to_book(table, { sheet: "예약 관리" });
                XLSX.writeFile(wb, '예약_관리.xlsx');
            }
        </script>
    </div>
</body>
</html>
