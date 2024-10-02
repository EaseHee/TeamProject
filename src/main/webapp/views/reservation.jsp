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
    <title>예약 관리</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">

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
 	/*
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
*/

if (keyWord != null && !keyWord.isEmpty() && keyField != null && !keyField.isEmpty()) {
    // 검색 조회 (기간도 포함되어 있을 경우)
    if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
        // 기간 및 검색 조회
        resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(keyField, keyWord, startDate, endDate);
    } else {
        // 검색 조회 (기간 없이)
        resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(keyField, keyWord, null, null);
    }
} else if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
    // 기간 조회 (검색 없이)
    resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(null, null, startDate, endDate);
} else {
    // 전체 리스트 조회
    resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(null, null, null, null);
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
<jsp:include page="/views/header.jsp" ></jsp:include>

				<div class="row form-group">
					<form method="get" action="reservation.jsp" class="col-4 d-flex">
    					<input type="date" class="form-control" id="startDate" name="startDate" value="<%= startDate %>">&nbsp;&nbsp;~&nbsp;&nbsp;
    					<input type="date" class="form-control" id="endDate" name="endDate" value="<%= endDate %>">
   						 <input type="submit" class="btn btn-outline-success" value="조회">
					</form>
					<form class="col-4 d-flex"></form>
					<form method="get" action="reservation.jsp" class="col-4 d-flex justify-content-end align-items-end">
    					<input type="hidden" name="keyField" value="<%= (keyField != null) ? keyField : "customer_name" %>"> 
    					<input type="text" name="keyWord" placeholder="예약자명 검색" class="form-control" value="<%= keyWord != null ? keyWord : "" %>">
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
                                                    <th class="text-center" width="15%">예약날짜</th>
                                                    <th class="text-center" width="15%">예약시간</th>
                                                    <th class="text-center" width="10%">예약자명</th>
                                                    <th class="text-center" width="10%">디자이너</th>
                                                    <th class="text-center" width="30%">특이사항</th>
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
													<td class="text-center"><%=reservationDTO.getMember_name() != null ? reservationDTO.getMember_name() : ""%></td>
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
<jsp:include page="/views/footer.jsp"></jsp:include>
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
