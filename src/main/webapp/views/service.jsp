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
	<link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">

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

				<jsp:useBean id="serDao" class="bean.ServiceDAO" />
<jsp:include page="/views/header.jsp" ></jsp:include>
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
<jsp:include page="/views/footer.jsp"></jsp:include>

	<script>
            function downloadExcel() {
                var table = document.getElementById("salesTable");
                var wb = XLSX.utils.table_to_book(table, { sheet: "판매_관리" });
                XLSX.writeFile(wb, '판매_관리.xlsx');
            }
        </script>
</body>
</html>