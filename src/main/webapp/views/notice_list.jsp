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
<title>공지사항</title>
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
	int numPerPage = 10;	// 한 페이지당 보여질 모든 글의 개수
	int normalPerPage = 0;	// 한 페이지당 보여질 일반 공지사항의 개수
	int totalPage = 0;		// 총 페이지 수
	int nowPage = 0;		// 현재 선택된 페이지
	int beginPerPage = 0;	// 페이지별 시작번호(중요!) EX) 1,11,21
	int pagePerBlock = 5;	// 블럭당 페이지 수
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

	beginPerPage = nowPage * normalPerPage; // 페이지당 시작번호

	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // 페이지블럭 개수 구하기

	if (request.getParameter("nowBlock") != null) {
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	%>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
				<div class="row form-group justify-content-start">
					<form method="post" action="notice_list.jsp" class="col-4 d-flex align-items-end" accept-charset="UTF-8">
						<input type="text" name="keyWord" placeholder="제목으로 조회" class="form-control ">
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
												<%	// 입력한 검색어와 일치하는 결과가 없으면
													if (list.isEmpty()){
												%>		<!-- 결과가 없다고 출력 -->
														<tr>
															<td class="text-bold-500 text-center" colspan="3">조회된 결과가 없습니다.</td>
														</tr>
												<%
													} else { // 검색어를 입력하지 않고 조회버튼을 누르면
														for (NoticeDTO checkedNoticeDTO: checkedList){
												%>		<!-- 중요 공지를 모두 출력 -->
														<tr>
															<td class="text-center text-bold-500"><i class="bi bi-pin-angle-fill"></i></td>
															<td class="text-bold-500">
																<a href="notice_view.jsp?notice_no=<%=checkedNoticeDTO.getNotice_no()%>"> <%=checkedNoticeDTO.getNotice_title()%></a>
															</td>
															<td class="text-center text-bold-500"><%=checkedNoticeDTO.getNotice_reg()%></td>
														</tr>
												<%			// 검색어를 입력하지 않으면 페이지당 공지 수에서 중요 공지 수를 뺀 만큼 페이지마다 일반 공지 출력
														}	// 검색어를 입력하면 검색어와 일치하는 모든 공지 출력
														for (int i = beginPerPage; i < beginPerPage + normalPerPage && i < list.size(); i++) {
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
								<!-- 이전 블럭 이동 기능 -->
								<%	// 현재 페이지블럭 인덱스가 0일경우
									if (nowBlock == 0) {
								%>		<!-- 이전 블럭으로 이동 버튼 비활성화 -->
										<li class="page-item disabled">
											<a class="page-link" href="#" tabindex="-1" aria-disabled="true"> 
												<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
											</a>
										</li>
								<%	// 현재 페이지블럭 인덱스가 0보다 클 경우
									} else {
								%>		<!-- 이전 블럭으로 이동 버튼 활성화 -->
										<li class="page-item">
											<a class="page-link" href="notice_list.jsp?nowPage=<%=(nowBlock - 1) * pagePerBlock%>&nowBlock=<%=nowBlock - 1%>">
												<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
											</a>
										</li>
								<%
									}
								%>

								<!-- 페이지 반복 -->
								<%	// 총 페이지수 이전까지, 블럭 당 페이지수 만큼 페이지 구분을 하여 현재 페이지에 할당
									for (int i = 0; i < pagePerBlock; i++) {
										int currentPage = (nowBlock * pagePerBlock) + i;
										if (currentPage >= totalPage)
											break;
								%>		<!-- 현재 페이지와 일치하는 페이지번호 버튼 active -->
										<li class="page-item <%=currentPage == nowPage ? "active" : ""%>">
											<a class="page-link" href="notice_list.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>">
												<%=currentPage + 1%> <!-- 페이지 반복 -->
											</a>
										</li>
								<%
									}
								%>

								<!-- 다음 블럭 이동 기능 -->
								<%	// 현재 페이지블럭 번호가 마지막 이상일 경우
									if (nowBlock >= totalBlock - 1) {
								%>		<!-- 다음 블럭으로 이동 버튼 비활성화 -->
										<li class="page-item disabled">
											<a class="page-link" href="#">
												<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
											</a>
										</li>
								<%	// 현재 페이지블럭 번호가 마지막 미만일 경우
									} else {
								%>		<!-- 다음 블럭으로 이동 버튼 활성화 -->
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