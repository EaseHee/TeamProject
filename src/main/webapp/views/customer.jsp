<%@page import="bean.*"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원 관리</title>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="assets/css/bootstrap.css">
	<link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	<link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
	<link rel="stylesheet" href="assets/css/app.css">
	<link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
	<link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">
</head>
	<script>
		function check() {
			if(document.search.keyWord.value == "") {
				document.search.keyWord.focus();
				return;
			}
			
			document.search.submit();
		}
	</script>
<body>
	<jsp:useBean id="customerDAO" class="bean.CustomerDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.CustomerDTO"></jsp:useBean>

	<%
	    request.setCharacterEncoding("UTF-8");
	
	    // 이름 등급 날짜 조회
	    String keyField = request.getParameter("keyField");
	    String filterValue = request.getParameter("filterValue");
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	
	    // 페이징 변수
	    int totalcnt = 0;     //총 글의 개수
		int numPerPage = 10;  //한 페이지당 보여질 글의 개수
		int totalPage = 0;    //총 페이지 수
		int nowPage = 0;      //현재 선택된 페이지
		int beginPerPage = 0; //페이지별 시작번호
		int pagePerBlock = 2; //블럭당 페이지 수
		int totalBlock = 0;   //총 블럭 수
		int nowBlock = 0;     //현재 블럭
	
	    ArrayList<CustomerDTO> list = null;
	
	    // 날짜 필터링 적용
	    if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
	        list = (ArrayList<CustomerDTO>) customerDAO.getCustomerByregdate(startDate, endDate);
	    } else {
	        list = (ArrayList<CustomerDTO>) customerDAO.getCustomerDTOList(keyField, filterValue);
	    }
	
	    // 전체 고객 수 구하기
	    totalcnt = list.size();
	
	    // 페이지 수 계산
	    totalPage = (int) Math.ceil((double) totalcnt / numPerPage);
	    if (request.getParameter("nowPage") != null) {
	        nowPage = Integer.parseInt(request.getParameter("nowPage"));
	    }
	    beginPerPage = nowPage * numPerPage;
	    totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	    if (request.getParameter("nowBlock") != null) {
	        nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	    }
	%>


	<div id="app">
		<jsp:include page="/views/header.jsp"></jsp:include>
		<div class="row form-group">
			<form method="post" action="customer.jsp" class="col-4 d-flex">
				<input type="date" onclick="this.showPicker()" class="form-control"
					id="startDate" name="startDate">&nbsp;&nbsp;~&nbsp;&nbsp; <input
					type="date" onclick="this.showPicker()" class="form-control"
					id="endDate" name="endDate"> <input type="submit"
					class="btn btn-outline-success" value="조회">
			</form>
			<form class="col-4"></form>
			<form method="post" action="customer.jsp"
				class="col-4 d-flex justify-content-end align-items-end search-filter">
				<select name="keyField" class="choices form-select"
					style="width: 100px; display: inline-block;">
					<option value="customer_name">이름</option>
					<option value="customer_rank">등급</option>
				</select> <input type="text" name="filterValue" id="filterValue"
					placeholder="검색" class="form-control"
					value="<%= filterValue != null ? filterValue : "" %>"> <input
					type="submit" class="btn btn-outline-success" value="조회">
			</form>
		</div>

		<section class="section">
			<div class="buttons d-flex justify-content-end align-items-end">
				<a href="customerAdd.jsp" class="btn btn-outline-success"
					style="margin-right: 0px">등록</a>
			</div>
			<div class="row" id="table-hover-row">
				<div class="col-12">
					<div class="card">
						<div class="card-content">
							<div class="table-responsive">
								<table class="table table-hover mb-0" id="customerTable">
									<thead>
										<tr>
											<th width="5%" class="text-center">ID</th>
											<th width="10%" class="text-center">이름</th>
											<th width="5%" class="text-center">성별</th>
											<th width="15%" class="text-center">연락처</th>
											<th width="15%" class="text-center">e-mail</th>
											<th width="10%" class="text-center">회원 등록일</th>
											<th width="10%" class="text-center">회원등급</th>
											<th width="30%" class="text-center">특이사항</th>
										</tr>
									</thead>
									<tbody>
										<%
															for(int i=beginPerPage; i < beginPerPage + numPerPage && i < totalcnt; i++){
																board = list.get(i);
													%>
										<tr>
											<td class="text-bold-500 text-center"><%=board.getCustomer_id() %></td>
											<td class="text-bold-500 text-center"><a
												href="customerRead.jsp?customer_id=<%= board.getCustomer_id() %>"><%= board.getCustomer_name() %></a>
											<td class="text-bold-500 text-center"><%=board.getCustomer_gender() %></td>
											<td class="text-bold-500 text-center"><%=board.getCustomer_tel() %></td>
											<td class="text-bold-500 text-center"><%=board.getCustomer_mail() %></td>
											<td class="text-bold-500 text-center"><%=board.getCustomer_reg() %></td>
											<td class="text-bold-500 text-center"><%=board.getCustomer_rank() %></td>
											<td class="text-bold-500 text-center"><%=board.getCustomer_note() != null ? board.getCustomer_note() : "" %></td>
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
				<button onclick="downloadExcel();" class="btn btn-outline-warning"
					style="margin-right: 0px;">엑셀 다운로드</button>
			</div>
			<div class="col-12 d-flex justify-content-center align-items-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination pagination-primary">
						<!-- 왼쪽 화살표 이동 기능 -->
						<% if(nowPage == 0) { %>
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true"> <span aria-hidden="true"><i
									class="bi bi-chevron-left"></i></span></a></li>
						<% } else {%>
						<li class="page-item"><a class="page-link"
							href="customer.jsp?nowPage=<%=((nowBlock - 1) * pagePerBlock)%>&nowBlock=<%=nowBlock - 1%>">
								<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
						</a></li>
						<% } %>

						<!-- 페이지 반복 -->
						<%
										for (int i = 0; i < pagePerBlock; i++) {
											int currentPage = (nowBlock * pagePerBlock) + i;
											if (currentPage >= totalPage)
												break;
									%>
						<li class="page-item <%=currentPage == nowPage ? "active" : ""%>">
							<a class="page-link"
							href="customer.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>">
								<%=currentPage + 1%></a>
						</li>
						<%
										}
									%>

						<!-- 오른쪽 화살표 이동 기능 -->
						<% if(nowBlock >= totalBlock-1) { %>
						<li class="page-item disabled"><a class="page-link" href="#">
								<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
						</a></li>
						<% } else {%>

						<li class="page-item"><a class="page-link"
							href="customer.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock%>&nowBlock=<%=nowBlock + 1%>">
								<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
						</a></li>
						<% } %>
					</ul>
				</nav>
			</div>
		</section>
		<jsp:include page="/views/footer.jsp"></jsp:include>
		<script>
			function downloadExcel() {
				var table = document.getElementById("customerTable");
				var wb = XLSX.utils.table_to_book(table, { sheet: "회원 관리" });
				XLSX.writeFile(wb, '회원_관리.xlsx');
			}
		</script>
	</div>
</body>
</html>
