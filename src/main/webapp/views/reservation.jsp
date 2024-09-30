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
        <style>
		a {
		    text-decoration: none;  /* 밑줄 없애기 */
		}
		.list-group-item.detail{
			font-size: small;
		}
		.bi-plus-square {
			display: inline-block;
			transform: translateY(2px);
		}
		.bi-person-fill{
			display: inline-block;
			transform: translateY(6px);
			margin-right: 5px;
		}
		.bi-bell-fill{
			display: inline-block;
			transform: translateY(3px);
			margin-right: 5px;
		}
		.bi-box-arrow-right{
			display: inline-block;
			transform: translateY(3px);
		}
	</style>
</head>

<body>
    <jsp:useBean id="dao" class="bean.ReservationDAO"/>
    <jsp:useBean id="dto" class="bean.ReservationDTO"/>

	<%
	request.setCharacterEncoding("utf-8");
	// 페이징에 필요한 변수들
	int totalRecord = 0; // 총 글의 개수
	int numPerPage = 10; // 한 페이지 당 보여질 글의 개수
	int totalPage = 0; // 총 페이지 수
	int nowPage = 0; // 현재 선택된 페이지
	int beginPerPage = 0; // 페이지별 시작 번호
	int pagePerBlock = 5; // 블럭 당 페이지 수
	int totalBlock = 0; // 총 블럭 수
	int nowBlock = 0; // 현재 블럭

	// 검색 후 페이지로 돌아갔을 때 가지고갈 요소들
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	ArrayList<ReservationDTO> list = new ArrayList<>();

	// 현재 날짜와 30일 후 날짜 계산
    java.util.Calendar cal = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    
    String today = sdf.format(cal.getTime()); // 오늘 날짜
    cal.add(java.util.Calendar.DATE, 30); // 30일 후
    String thirtyDaysLater = sdf.format(cal.getTime());

    // 날짜 조회 설정
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    // startDate와 endDate가 없으면 기본값으로 설정
    if (startDate == null || startDate.isEmpty()) {
        startDate = today;
    }
    if (endDate == null || endDate.isEmpty()) {
        endDate = thirtyDaysLater;
    }

    // 데이터 리스트 초기화
    ArrayList<ReservationDTO> resultList = new ArrayList<>();

 	// 날짜 조회 및 검색 조회 로직
    if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
        // 날짜 조회
        resultList = (ArrayList<ReservationDTO>) dao.getReservationDateSearch(startDate, endDate);
    } else if (keyWord != null && !keyWord.isEmpty() && keyField != null && !keyField.isEmpty()) {
        // 검색 조회
        resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(keyField, keyWord);
    } else {
        // 전체 리스트 조회
        resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(keyField, keyWord); // 전체 조회 메서드 사용
    }

	// 총 예약 수
	totalRecord = resultList.size();
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);

	if (request.getParameter("nowPage") != null)
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	else
		nowPage = 0; // 기본값 설정

	beginPerPage = nowPage * numPerPage;

	// 페이지 수 및 블럭 수 계산
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);

	if (request.getParameter("nowBlock") != null)
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	else
		nowBlock = 0; // 기본값 설정

	// 현재 페이지에 해당하는 데이터만 담는 리스트 생성
	ArrayList<ReservationDTO> currentPageList = new ArrayList<>();
	for (int i = beginPerPage; i < beginPerPage + numPerPage && i < totalRecord; i++) {
		currentPageList.add(resultList.get(i));
	}
	%>

	<div id="app">
         <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp">LOGO</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>

                        <li class="sidebar-item ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>HOME</span>
                            </a>
                        </li>

                        <li class="sidebar-item has-sub">
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

                        <li class="sidebar-item active has-sub">
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
                            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16"><path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/></svg>                               
                                <span>MEMBER</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="member.jsp">직원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="member.jsp">기타</a>
                                </li>
                            </ul>
                        </li>
 
                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-megaphone-fill"></i>
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
                                    <li class="breadcrumb-item">
	                                    <i class="bi bi-person-fill text-primary" style="font-size:x-large; " ></i>
	                       	 			<i class="bi bi-bell-fill text-primary" style="font-size:larger; line-height: 10px;" ></i>
                                    	<a href="login.jsp"><span class="badges badge bg-primary">로그아웃<i class="bi bi-box-arrow-right " ></i></span></a>
                                   	</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <hr style="height: 5px;">

                <div class="row form-group">
                    <form method="post" action="#" class="col-4 d-flex">
                        <input type="date" class="form-control" id="startDate" name="startDate">&nbsp;&nbsp;~&nbsp;&nbsp;
                        <input type="date" class="form-control" id="endDate" name="endDate">
                        <input type="button" class="btn btn-outline-success" value="조회">
                    </form>
                    <form method="post" action="reservation.jsp" class="col-4 d-flex justify-content-end align-items-end">
                        <input type="hidden" name="keyField" value="cus_name">
                        <input type="text" name="keyWord" placeholder="검색" class="form-control">
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
                                                    <th class="text-center" width="10%">예약번호</th>
                                                    <th class="text-center" width="20%">예약품목</th>
                                                    <th class="text-center" width="10%">예약날짜</th>
                                                    <th class="text-center" width="10%">예약시간</th>
                                                    <th class="text-center" width="10%">예약자명</th>
                                                    <th class="text-center" width="40%">특이사항</th>
                                                </tr>
                                            </thead>
											<tbody>
												<%
													// currentPageList를 기반으로 예약 목록 출력
													for (ReservationDTO reservationDTO : currentPageList) {
												%>
												<tr>
													<td class="text-center"><%=reservationDTO.getReservation_no()%></td>
													<td class="text-center"><%=reservationDTO.getService_name() != null ? reservationDTO.getService_name() : ""%></td>
													<td class="text-center"><%=reservationDTO.getReservation_date() != null ? reservationDTO.getReservation_date() : ""%></td>
													<td class="text-center"><%=reservationDTO.getReservation_time() != null ? reservationDTO.getReservation_time() : ""%></td>
													<td class="text-center"><a href="reservationRead.jsp?reservation_no=<%=reservationDTO.getReservation_no()%>"><%=reservationDTO.getCustomer_name() != null ? reservationDTO.getCustomer_name() : ""%></a></td>
													<td class="text-center"><%=reservationDTO.getReservation_comm() != null ? reservationDTO.getReservation_comm() : ""%></td>
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
				<br><br><br>
                <footer>
                    <div class="footer clearfix mb-0 text-muted">
                        <div class="float-start">
                            <p>2024 &copy; ACORN</p>
                        </div>
                        <div class="float-end">
                            <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a href="#main">거니네조</a></p>
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
