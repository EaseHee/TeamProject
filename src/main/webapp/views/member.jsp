<%@page import="java.util.List"%>
<%@page import="bean.*"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>직원 관리</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">

</head>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
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
	<jsp:useBean id="memberDAO" class="bean.MemberDAO"></jsp:useBean>
	<jsp:useBean id="memberDTO" class="bean.MemberDTO"></jsp:useBean>
	
	<%
		//한글로 받을 수 있기 때문에
		request.setCharacterEncoding("UTF-8");
	
		//검색어 받기
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		String filterValue = request.getParameter("filterValue");
		
		//페이징에 필요한 변수
		int totalcnt = 0;     //총 글의 개수
		int numPerPage = 10;  //한 페이지당 보여질 글의 개수
		int totalPage = 0;    //총 페이지 수
		int nowPage = 0;      //현재 선택된 페이지
		int beginPerPage = 0; //페이지별 시작번호(중요!) EX) 1,11,21
		int pagePerBlock = 5; //블럭당 페이지 수
		int totalBlock = 0;   //총 블럭 수
		int nowBlock = 0;     //현재 블럭
		
		ArrayList<MemberDTO> list = (ArrayList<MemberDTO>)memberDAO.getMemberList(keyField, filterValue);
		//ArrayList<CustomerDTO> list = (ArrayList<CustomerDTO>) dao.getCustomerDTOList(keyField, filterValue);
		
		totalcnt = list.size();
				
		totalPage = (int)Math.ceil((double)totalcnt / numPerPage); // 페이지 개수 구하기

        if(request.getParameter("nowPage") != null) {
            nowPage = Integer.parseInt(request.getParameter("nowPage"));
        }

        // 페이지당 시작번호
        beginPerPage = nowPage * numPerPage;

        totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);

        if(request.getParameter("nowBlock") != null) {
            nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
        }
	%>

	<div id="app">
		<jsp:include page="/views/header.jsp"></jsp:include>
		<div class="row form-group">

			<form method="post" action="member.jsp" class="col-5 d-flex align-items-end search-filter">
				<select name="keyField" class="choices form-select" style="width: 150px; display: block;">
					<option value="member_name">이름</option>
					<option value="member_job">직책</option>
				</select> 
				<input type="text" name="filterValue" id="filterValue" placeholder="검색어를 입력해주세요" class="form-control"
					value="<%=filterValue != null ? filterValue : ""%>">
				<input type="submit" class="btn btn-outline-success" value="조회">
			</form>
			<form class="col-4 d-flex"></form>
			<form class="col-3 d-flex justify-content-end align-items-end">
				<a href="member_Post.jsp" class="btn btn-outline-success" style="margin-right: 0px;">등록</a>
			</form>
		</div>
		<section class="section">
			<div class="row" id="table-hover-row">
				<div class="col-12">
					<div class="card">
						<div class="card-content">
							<div class="table-responsive">
								<table class="table table-hover mb-0" id="memberTable">
									<thead>
										<tr>
											<th class="text-center" width="25">사번</th>
											<th class="text-center" width="25">이름</th>
											<th class="text-center" width="25">직책</th>
											<th class="text-center" width="25">연락처</th>
										</tr>
									</thead>
									<tbody>

										<%
										for (int i = beginPerPage; i < beginPerPage + numPerPage && i < totalcnt; i++) {
											memberDTO = list.get(i);
										%>

										<tr>
											<td class="text-bold-500 text-center"><%=memberDTO.getMember_id()%></a></td>
											<td class="text-bold-500 text-center"><a href="member_Read.jsp?member_id=<%=memberDTO.getMember_id()%>"><%=memberDTO.getMember_name()%></a></td>
											<td class="text-bold-500 text-center"><%=memberDTO.getMember_job()%></td>
											<td class="text-bold-500 text-center"><%=memberDTO.getMember_tel()%></td>
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
				<button onclick="downloadExcel();"
					class="btn-excel btn btn-outline-warning ">엑셀 다운로드</button>
			</div>
			<div class="col-12 d-flex justify-content-center align-items-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination pagination-primary">
						<!-- 왼쪽 화살표 이동 기능 -->
						<%
						if (nowBlock == 0) {
						%>
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true"> <span aria-hidden="true"><i
									class="bi bi-chevron-left"></i></span></a></li>
						<%
						} else {
						%>
						<li class="page-item"><a class="page-link"
							href="reservation.jsp?nowPage=<%=((nowBlock - 1) * pagePerBlock)%>&nowBlock=<%=nowBlock - 1%>">
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
							<a class="page-link"
							href="member.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>">
								<%=currentPage + 1%></a>
						</li>
						<%
						}
						%>

						<!-- 오른쪽 화살표 이동 기능 -->
						<%
						if (nowBlock >= totalBlock - 1) {
						%>
						<li class="page-item disabled"><a class="page-link" href="#">
								<span aria-hidden="true"> <i class="bi bi-chevron-right"></i></span>
						</a></li>
						<%
						} else {
						%>
						<li class="page-item"><a class="page-link"
							href="member.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock%>&nowBlock=<%=nowBlock + 1%>">
								<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
						</a></li>
						<%
						}
						%>
					</ul>
				</nav>
			</div>
		</section>
		<jsp:include page="/views/footer.jsp"></jsp:include>
		<script>
	function downloadExcel() {
		var memberData = [//자바 객체 데이터를 jsp 배열로 변환
		<%//memberDao에서 getMemberList 메서드를 호출>모든 멤버 데이터를 가져옴
			List<MemberDTO> members = memberDAO.getMemberList(keyField, keyWord);
			for (MemberDTO member : members) {%>{
                member_id : '<%=member.getMember_id()%>',
                member_name : '<%=member.getMember_name()%>',
                member_job : '<%=member.getMember_job()%>',
                member_tel : '<%=member.getMember_tel()%>'
            },
        <%}%>
		];

		var wb = XLSX.utils.book_new(); //엑셀 파일 생성 함수
		var ws_data = [['직원 사번', '직원 명', '직원 직책', '직원 연락처']]; // 엑셀 행 
    
		// 데이터를 행별로 추가
		serviceData.forEach(function(service) {
			ws_data.push([member.member_id, member.member_name, member.member_job, member.member_tel]);
		});

		var ws = XLSX.utils.aoa_to_sheet(ws_data); // ws_data 배열을 엑셀 시트로 변환
		XLSX.utils.book_append_sheet(wb, ws, '직원_관리');//엑셀에 변환한 시트를 추가하는 함수
    
		// 엑셀 파일 저장
		XLSX.writeFile(wb, '서비스_관리.xlsx');
		}    
    </script>
</body>

</html>