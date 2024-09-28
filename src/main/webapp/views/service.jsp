<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*, java.util.Set, java.util.HashSet"%>
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
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</head>
<body>
	<div id="app">
		<div id="sidebar" class="active">
			<div class="sidebar-wrapper active">
				<div class="sidebar-header">
					<div class="d-flex justify-content-between">
						<div class="logo">
							<a href="#"> <img src="assets/images/logo/logo.png"
								alt="Logo" srcset="">LOGO
							</a>
						</div>
						<div class="toggler">
							<a href="#" class="sidebar-hide d-xl-none d-block"><i
								class="bi bi-x bi-middle"></i></a>
						</div>
					</div>
				</div>
				<div class="sidebar-menu">
					<ul class="menu">
						<li class="sidebar-title">Menu</li>

						<li class="sidebar-item "><a href="dashboard.jsp"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>HOME</span>
						</a></li>

						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-stack"></i> <span>CUSTOMER</span>
						</a>
							<ul class="submenu ">
								<li class="submenu-item "><a href="customer.jsp">회원 관리</a></li>
								<li class="submenu-item "><a href="customer.jsp">기타</a></li>
							</ul></li>

						<li class="sidebar-item has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-collection-fill"></i> <span>RESERVATION</span>
						</a>
							<ul class="submenu ">
								<li class="submenu-item"><a href="reservation.jsp">예약
										관리</a></li>
								<li class="submenu-item "><a href="reservation.jsp">기타</a></li>
							</ul></li>

						<li class="sidebar-item active has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-grid-1x2-fill"></i> <span>SERVICE</span>
						</a>
							<ul class="submenu ">
								<li class="submenu-item "><a href="service.jsp">서비스 관리</a></li>
								<li class="submenu-item "><a href="service.jsp">기타</a></li>
							</ul></li>

						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-hexagon-fill"></i> <span>PRODUCT</span>
						</a>
							<ul class="submenu ">
								<li class="submenu-item "><a href="product.jsp">상품 관리</a></li>
								<li class="submenu-item "><a href="product.jsp">기타</a></li>
							</ul></li>

						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-pen-fill"></i> <span>NOTICE</span>
						</a>
							<ul class="submenu ">
								<li class="submenu-item "><a href="notice_list.jsp">공지
										사항</a></li>
								<li class="submenu-item "><a href="notice_list.jsp">기타</a></li>
							</ul></li>
					</ul>
				</div>
				<button class="sidebar-toggler btn x">
					<i data-feather="x"></i>
				</button>
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
									<li class="breadcrumb-item"><a href="login.jsp">로그아웃</a></li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<% request.setCharacterEncoding("utf-8"); %>
				<jsp:useBean id="serDao" class="bean.ServiceDAO" />

				<%
        int currentPage = 1;  // 기본 페이지
        int recordsPerPage = 10;  // 페이지당 표시할 레코드 수

        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }

        // 전체 서비스 개수를 가져와 총 페이지 수를 계산
        int totalRecords = serDao.getTotalServiceCount();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // 페이징 처리된 서비스 목록 가져오기
        Set<ServiceDTO> serviceSet;
        String searchName = request.getParameter("searchName");

        if (searchName != null && !searchName.trim().isEmpty()) { 
            serviceSet = serDao.getServicesByName(searchName);
        } else {
            serviceSet = serDao.getServicesWithPaging(currentPage, recordsPerPage);
        }

        request.setAttribute("serviceSet", serviceSet);
    %>
				<hr style="height: 5px;">
				<div class="row form-group">
					<!-- 왼쪽 폼 -->
					<div class="col-4 d-flex justify-content-start align-items-center">
						<form method="get" action="#" class="d-flex">
							<input type="text" name="searchName" placeholder="품목명으로 조회"
								class="form-control" style="margin-right: 10px;"> <input
								type="submit" class="btn btn-outline-success" value="조회">
						</form>
					</div>
					<!-- 나머지 두 칸은 비워둠 -->
					<div class="col-8"></div>
				</div>
				<div class="buttons d-flex justify-content-end align-items-end">
					<a onclick="location.href='servicepost.jsp'" class="btn btn-outline-success" style="margin-right: 0px;">등록</a>
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
												<th>품목코드</th>
												<th>서비스명</th>
												<th>판매 가격</th>
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
											<td><%= service.getService_code() %></td>
											<td><a
												href="servicedetail.jsp?code=<%= service.getService_code() %>"><%= service.getService_name() %></a></td>
											<td><%= service.getService_price() %></td>
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

				<!-- 페이징 컨트롤 -->
				<div class="col-12 d-flex justify-content-center align-items-center">
					<nav aria-label="Page navigation example">
						<%
                if (currentPage > 1) {
            %>
						<a href="sales.jsp?page=<%= currentPage - 1 %>"
							class="pagination-btn">&lt;</a>
						<%
                } else {
            %>
						<span class="pagination-btn disabled">&lt;</span>
						<%
                }

                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
            %>
						<button class="pagination-btn active"><%= i %></button>
						<%
                    } else {
            %>
						<a href="sales.jsp?page=<%= i %>" class="pagination-btn"><%= i %></a>
						<%
                    }
                }

                if (currentPage < totalPages) {
            %>
						<a href="sales.jsp?page=<%= currentPage + 1 %>"
							class="pagination-btn">&gt;</a>
						<%
                } else {
            %>
						<span class="pagination-btn disabled">&gt;</span>
						<%
                }
            %>
					
				</div>
				</nav>
			</div>
			</section>
			<footer>
				<div class="footer clearfix mb-0 text-muted">
					<div class="float-start">
						<p>2024 &copy; ACORN</p>
					</div>
					<div class="float-end">
						<p>
							<span class="text-danger"><i class="bi bi-heart"></i></span> by <a
								href="#">거니네조</a>
						</p>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script src="assets/js/bootstrap.bundle.min.js"></script>
	<script src="assets/js/main.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
	<script>
            function downloadExcel() {
                var table = document.getElementById("salesTable");
                var wb = XLSX.utils.table_to_book(table, { sheet: "판매_관리" });
                XLSX.writeFile(wb, '판매_관리.xlsx');
            }
        </script>
	</div>
</body>
</html>