<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*, java.util.Set, java.util.HashSet"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>판매 관리</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/bootstrap.css">
<link rel="stylesheet"
	href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="assets/css/app.css">
<link rel="shortcut icon" href="assets/images/favicon.svg"
	type="image/x-icon">
	<style>
		a {
		    color: inherit;  /* 부모 요소의 텍스트 색상을 따르도록 설정 */
		    text-decoration: none;  /* 밑줄 없애기 */
		}		
		a:visited {
		    color: inherit;
		}		
		a:hover {
		    color: inherit;
		}		
		a:active {
		    color: inherit;
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</head>
<body>
    <% request.setCharacterEncoding("utf-8"); %>
    <jsp:useBean id="serDao" class="bean.ServiceDAO" />
<%
    request.setCharacterEncoding("UTF-8");

    int numPerPage = 10;   // 한 페이지당 보여줄 게시물 수
    int pagePerBlock = 5;  // 한 블록당 보여줄 페이지 수

    int nowPage = 1;  // 기본 페이지는 1부터 시작
    int nowBlock = 0; 

    // nowPage 값 가져오기 (없으면 기본값 1)
    if (request.getParameter("nowPage") != null) {
        nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }

    // nowBlock 값 가져오기 (없으면 기본값 0)
    if (request.getParameter("nowBlock") != null) {
        nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
    }

    Set<ServiceDTO> serviceSet;
    String searchName = request.getParameter("searchName");
    int totalRecord = 0;

    // 검색어가 있는 경우 결과의 총 레코드 수 가져오기
    if (searchName != null && !searchName.trim().isEmpty()) {
        serviceSet = serDao.getServicesByName(searchName);
        totalRecord = serviceSet.size();  // 검색된 결과의 총 개수를 사용
    } else {
        totalRecord = serDao.getTotalServiceCount();  // 전체 레코드 수
        serviceSet = serDao.getServicesWithPaging(nowPage, numPerPage);
    }

    // 페이지 및 블록 관련 계산
    int totalPage = (int) Math.ceil((double) totalRecord / numPerPage);  // 총 페이지 수 계산
    int totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // 총 블록 수 계산

    // 현재 페이지 시작 게시물 번호 계산
    int beginPerPage = (nowPage - 1) * numPerPage;  
    if (beginPerPage < 0) {
        beginPerPage = 0;  // 시작 값 음수가 되지 않도록 보정
    }

    request.setAttribute("serviceSet", serviceSet);
%>

	<div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp">로고</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">메뉴</li>

                        <li class="sidebar-item ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>홈</span>
                            </a>
                        </li>

                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>고객</span>
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

                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-collection-fill"></i>
                                <span>예약</span>
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

                        <li class="sidebar-item active has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>서비스</span>
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

                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>상품</span>
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
                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16"><path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/></svg>                               
                                <span>직원</span>
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
 
                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-megaphone-fill"></i>
                                <span>공지</span>
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
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>

			<div class="page-heading">
				<div class="page-title">
					<div class="row">
						<div class="col-12 col-md-6 order-md-1 order-last">
							<h3>서비스 관리</h3>
						</div>
						<div class="col-12 col-md-6 order-md-2 order-first">
							<nav aria-label="breadcrumb"
								class="breadcrumb-header float-start float-lg-end">
								<ol class="breadcrumb">
									<li class="breadcrumb-item">
	                                    <i class="bi bi-person-fill text-primary" style="font-size:x-large; " ></i>
	                       	 			<i class="bi bi-bell-fill text-primary" style="font-size:larger; line-height: 10px;" ></i>
                                    	<a href="login.jsp"><span class="badges badge bg-primary">로그아웃&nbsp;<i class="bi bi-box-arrow-right " ></i></span></a>
                                   	</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>

				<hr style="height: 5px;">		
				<div class="row form-group">
					<!-- 왼쪽 폼 -->
						<form method="get" action="#" class="col-4 d-flex">
							<input type="text" name="searchName" value="${param.searchName}" placeholder="품목명으로 조회" class="form-control"> 
								<input type="submit" class="btn btn-outline-success" value="조회">
						</form>
						
						
						<form class="col-4 d-flex"></form>
						<form class="col-4 d-flex justify-content-end align-items-end">
							<a onclick="location.href='servicepost.jsp'" class="btn btn-outline-success" style="margin-right: 0px;">등록</a>
						</form>
					<!-- 나머지 두 칸은 비워둠 -->
				</div>

				<div class="container">
					<section class="section">
				</div>
				<div class="row" id="table-hover-row">
					<div class="col-12">
						<div class="card">
							<div class="card-content">
								<div class="table-responsive">
									<table class="table table-hover mb-0" id="salesTable">
										<thead>
											<tr>
												<th class="text-center" width="30%">품목코드</th>
												<th class="text-center" width="40%">서비스명</th>
												<th class="text-center" width="30%">판매 가격</th>
											</tr>
										</thead>
										<%
                    if (serviceSet.isEmpty()) {
                %>
										<tr>
											<td colspan="3">조회된 결과가 없습니다.</td>
										</tr>
										<%
                    } else {
                        for (ServiceDTO service : serviceSet) {
                %>
										<tr>
											<td class="text-center"><%= service.getService_code() %></td>
											<td class="text-center"><a
												href="servicedetail.jsp?code=<%= service.getService_code() %>"><%= service.getService_name() %></a></td>
											<td class="text-center" ><fmt:formatNumber value='<%= service.getService_price() %>'/></td>
										</tr>
										<%
                        }
                    }
                %>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="buttons d-flex justify-content-end align-items-end">
					<button onclick=" downloadExcel();" class="btn btn-outline-warning"
						style="margin-right: 0px;">엑셀 다운로드</button>
				</div>

				<div class="col-12 d-flex justify-content-center align-items-center">
  
							
<!-- 페이징 UI -->
<ul class="pagination pagination-primary">
    <% if (nowBlock > 0) { %>
        <li class="page-item">
            <a class="page-link" href="service.jsp?nowPage=<%=(nowBlock-1)*pagePerBlock+1%>&nowBlock=<%=nowBlock - 1 %>">
                <span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
            </a>
        </li>
    <% } else { %>
        <li class="page-item disabled">
            <a class="page-link" href="#">
                <span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
            </a>
        </li>
    <% } %>

    <% 
        for (int i = 0; i < pagePerBlock && nowBlock * pagePerBlock + i < totalPage; i++) { 
            int pageIndex = nowBlock * pagePerBlock + i + 1;
    %>
        <li class="page-item <%= (pageIndex == nowPage) ? "active" : "" %>">
            <a class="page-link" href="service.jsp?nowPage=<%=pageIndex%>&nowBlock=<%=nowBlock%>"><%= pageIndex %></a>
        </li>
    <% } %>

    <% if (nowBlock < totalBlock - 1) { %>
        <li class="page-item">
            <a class="page-link" href="service.jsp?nowPage=<%=(nowBlock+1)*pagePerBlock+1%>&nowBlock=<%=nowBlock + 1 %>">
                <span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
            </a>
        </li>
    <% } else { %>
        <li class="page-item disabled">
            <a class="page-link" href="#">
                <span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
            </a>
        </li>
    <% } %>
</ul>
						</div>
			</section>
			<br><br><br>
			<footer>
				<div class="footer clearfix mb-0 text-muted">
					<div class="float-start">
						<p>2024 &copy; ACORN</p>
					</div>
					<div class="float-end">
						<p>
							<span class="text-danger"><i class="bi bi-heart"></i></span> by <a
								href="#main">거니네조</a>
						</p>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script src="assets/js/bootstrap.bundle.min.js"></script>
	<script src="assets/js/main.js"></script>
<script>
    function downloadExcel() {
        var serviceData = [//자바 객체 데이터를 jsp 배열로 변환
            <% 
            //serDao에서 getAllServices() 메서드를 호출>모든 서비스를 가져옴
                Set<ServiceDTO> services = serDao.getAllServices();
                for (ServiceDTO service : services) {
                    %>{
                    service_code: '<%= service.getService_code() %>',
                    service_name: '<%= service.getService_name() %>',
                    service_price: <%= service.getService_price() %>
                },
            <% } %>
        ];

        var wb = XLSX.utils.book_new(); //엑셀 파일 생성 함수
        var ws_data = [['서비스 코드', '서비스 이름', '서비스 가격']]; // 엑셀 행 
        
        // 데이터를 행별로 추가
        serviceData.forEach(function(service) {
            ws_data.push([service.service_code, service.service_name, service.service_price]);
        });

        var ws = XLSX.utils.aoa_to_sheet(ws_data); // ws_data 배열을 엑셀 시트로 변환
        XLSX.utils.book_append_sheet(wb, ws, '서비스_관리');//엑셀에 변환한 시트를 추가하는 함수
        
        // 엑셀 파일 저장
        XLSX.writeFile(wb, '서비스_관리.xlsx');
    }
</script>


	</div>
</body>
</html>