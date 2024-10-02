<%@page import="java.util.Collections"%>
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
<title>Notice List</title>
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
<script>
	function check() {
		if (document.search.keyWord.value == "") {
			document.search.keyWord.focus();
			return;
		}

		document.search.submit();
	}
</script>
<body>
	<jsp:useBean id="noticeDAO" class="bean.NoticeDAO"></jsp:useBean>
	<jsp:useBean id="noticeDTO" class="bean.NoticeDTO"></jsp:useBean>

	<%
	//한글로 받을 수 있기 때문에
	request.setCharacterEncoding("UTF-8");

	//검색어 받기
	String keyWord = request.getParameter("keyWord");

	//페이징에 필요한 변수
	int totalcnt = 0;		// 총 글의 개수
	int totalchecked = 0;	// 중요 공지사항 개수
	int numPerPage = 10;		// 한 페이지당 보여질 모든 글의 개수
	int normalPerPage = 0;	// 한 페이지당 보여질 일반 공지사항의 개수
	int totalPage = 0;		// 총 페이지 수
	int nowPage = 0;		// 현재 선택된 페이지
	int beginPerPage = 0;	// 페이지별 시작번호(중요!) EX) 1,11,21
	int pagePerBlock = 2;	// 블럭당 페이지 수
	int totalBlock = 0;		// 총 블럭 수
	int nowBlock = 0;		// 현재 블럭

	// 일반 공지사항과 중요 공지사항 리스트 따로 선언
	ArrayList<NoticeDTO> list = (ArrayList<NoticeDTO>) noticeDAO.getNormalNoticeList(keyWord);
	ArrayList<NoticeDTO> checkedList = (ArrayList<NoticeDTO>) noticeDAO.getCheckedNoticeList(keyWord);

	totalcnt = list.size() + checkedList.size(); // 총 글의 개수 = 일반공지 + 중요공지
	totalchecked = checkedList.size(); // 중요 공지사항 개수 지정
	normalPerPage = numPerPage - totalchecked; // 페이지당 일반공지 수 계산
	totalPage = (int) Math.ceil((double) (totalcnt - totalchecked) / normalPerPage); // 페이지 개수 구하기

	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	// 페이지당 시작번호
	beginPerPage = nowPage * normalPerPage;

	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // 페이지블럭 개수 구하기

	if (request.getParameter("nowBlock") != null) {
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	%>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
				<div class="row form-group justify-content-end">
					<form method="post" action="notice_list.jsp" class="col-4 d-flex align-items-end" accept-charset="UTF-8">
						<input type="text" name="keyWord" placeholder="공지글 조회" class="form-control ">
						<input type="submit" class="btn btn-outline-success" onclick="check()" value="조회">
					</form>
				</div>
				<section class="section">
					<div class="row" id="table-hover-row">
						<div class="col-12">
							<div class="card">
								<div class="card-content">
									<div class="table-responsive">
										<table class="table table-hover mb-0">
											<thead>
												<tr>
													<th class="text-center" width="10%" >번호</th>
													<th class="text-center" width="75%">제목</th>
													<th class="text-center" width="15%">작성일</th>
												</tr>
											</thead>
											<tbody>
												<%
													if (list.isEmpty()){
												%>
														<tr>
															<td class="text-bold-500 text-center" colspan="3">조회된 결과가 없습니다.</td>
														</tr>
												<%
													} else {
														for (NoticeDTO checkedNoticeDTO: checkedList){
												%>
														<tr>
															<td class="text-center text-bold-500"><i class="bi bi-pin-angle-fill"></i></td>
															<td class="text-bold-500">
																<a href="notice_view.jsp?notice_no=<%=checkedNoticeDTO.getNotice_no()%>"> <%=checkedNoticeDTO.getNotice_title()%></a>
															</td>
															<td class="text-center text-bold-500"><%=checkedNoticeDTO.getNotice_reg()%></td>
														</tr>
												<%
														}
												%>
												<%
														for (int i = beginPerPage; i < beginPerPage + numPerPage - checkedList.size() && i < list.size(); i++) {
															noticeDTO = list.get(i);
												%>
														<tr>
															<td class="text-center text-bold-500"><%=noticeDTO.getNotice_no()%></td>
															<td class="text-bold-500">
																<a href="notice_view.jsp?notice_no=<%=noticeDTO.getNotice_no()%>"><%=noticeDTO.getNotice_title()%></a>
															</td>
															<td class="text-center text-bold-500"><%=noticeDTO.getNotice_reg()%></td>
														</tr>
												<%
														}
													}
												%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 d-flex justify-content-center align-items-center">
						<nav aria-label="Page navigation example">
							<ul class="pagination pagination-primary">
								<!-- 왼쪽 화살표 이동 기능 -->
								<%
									if (nowBlock == 0) {
								%>
										<li class="page-item disabled">
											<a class="page-link" href="#" tabindex="-1" aria-disabled="true"> 
												<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
											</a>
										</li>
								<%
									} else {
								%>
										<li class="page-item">
											<a class="page-link" href="notice_list.jsp?nowPage=<%=(nowBlock - 1) * pagePerBlock + pagePerBlock - 1%>&nowBlock=<%=nowBlock - 1%>">
												<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
											</a>
										</li>
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
											<a class="page-link" href="notice_list.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>">
												<%=currentPage + 1%>
											</a>
										</li>
								<%
									}
								%>

								<!-- 오른쪽 화살표 이동 기능 -->
								<%
									if (nowBlock >= totalBlock - 1) {
								%>
										<li class="page-item disabled">
											<a class="page-link" href="#">
												<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
											</a>
										</li>
								<%
									} else {
								%>
										<li class="page-item">
											<a class="page-link" href="notice_list.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock%>&nowBlock=<%=nowBlock + 1%>">
												<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
											</a>
										</li>
								<%
									}
								%>
							</ul>
						</nav>
					</div>
				</section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>