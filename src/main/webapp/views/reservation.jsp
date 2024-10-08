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
    <link rel="stylesheet" href="assets/css/page.css">

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

	// 기간 조회 값이 없으면 startDate는 오늘 , endDate는 startDate+30일로 설정
	if (startDate == null) {
		startDate = today;
	}
	if (endDate == null) {
		endDate = thirtyDaysLater;
	}

	// 데이터 리스트 초기화
	ArrayList<ReservationDTO> resultList = new ArrayList<>();

	// 날짜 조회 및 검색 조회 로직
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
		resultList = (ArrayList<ReservationDTO>) dao.getReservationDTOList(keyField, keyWord, null, null);
	}

	
	totalRecord = resultList.size(); // 총 예약 수
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage); //총 페이지 수
	
	//현재 선택된 page가 null이 아닐 경우의 nowPage값을 int값으로 변환하여 저장
	if (request.getParameter("nowPage") != null)
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	else
		nowPage = 0; // 기본값 설정

	beginPerPage = nowPage * numPerPage; // 페이지별 시작번호 계산

	// 페이지 수 및 블럭 수 계산
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);

	//현재 선택된 block이 null이 아닐 경우의 nowBlock값을 int값으로 변환하여 저장
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
					<form method="get" action="reservation.jsp" class="col-12 d-flex justify-content-end align-items-end"  onsubmit="return validateDates()">
						<input type="date" class="form-control" id="startDate" name="startDate" value="<%= startDate %>" onclick="this.showPicker()">&nbsp;&nbsp;~&nbsp;&nbsp;
						<input type="date" class="form-control" id="endDate" name="endDate" value="<%= endDate %>" onclick="this.showPicker()">
						<!-- input type="submit" name="start" class="btn btn-outline-success" value="조회"-->
						&nbsp;&nbsp;&nbsp;&nbsp;<div style="width:2000px;"></div>
						 
						<input type="hidden" value="<%=startDate %>" /> 
						<input type="hidden" value="<%=endDate %>" /> 
						<select name="keyField" class="choices form-select" style="width: 150px; display: block;">
							<option value="service_name">예약품목</option>
							<option value="customer_name">예약자명</option>
							<option value="member_name">직원명</option>
						</select> 
						<input type="text" name="keyWord" placeholder="검색어를 입력해주세요" class="form-control" value="<%= keyWord != null ? keyWord : "" %>"> 
							<input type="submit" name="end" class="btn btn-outline-success" value="조회">
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
                                                    <th class="text-center" width="10%">직원명</th>
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
													<td class="text-center"><%=reservationDTO.getReservation_time() != null ? reservationDTO.getReservation_time().substring(0, 5) : ""%></td>
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
                       <button onclick="downloadExcel();" class="btn btn-outline-warning btn-excel">엑셀 다운로드</button>
                   </div>
					<div class="col-12 d-flex justify-content-center align-items-center">
						<nav aria-label="Page navigation example">
							<ul class="pagination pagination-primary">
								<!-- 왼쪽 화살표 이동 기능 -->
								<%
    								if (nowBlock == 0) { 
								%>		
										<!-- 현재 Block이 0이면(첫번째 블럭) 왼쪽 화살표 클릭 불가능 -->
    									<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true"> 
    									<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a></li>
								<%
    								} else {
								%>
    									<li class="page-item">
        								<a class="page-link" href="reservation.jsp?nowPage=<%=((nowBlock - 1) * pagePerBlock)%>&nowBlock=<%=nowBlock - 1%>&startDate=<%=startDate != null ? startDate : ""%>&endDate=<%=endDate != null ? endDate : ""%>&keyField=<%=keyField != null ? keyField : ""%>&keyWord=<%=keyWord != null ? keyWord : ""%>">
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
        									if (currentPage >= totalPage) //현재 페이지가 총 페이지수보다 크면 나타나지 않도록함
            									break;
								%>
    									<li class="page-item <%=currentPage == nowPage ? "active" : ""%>">
       									<a class="page-link" href="reservation.jsp?nowPage=<%=currentPage%>&nowBlock=<%=nowBlock%>&startDate=<%=startDate != null ? startDate : ""%>&endDate=<%=endDate != null ? endDate : ""%>&keyField=<%=keyField != null ? keyField : ""%>&keyWord=<%=keyWord != null ? keyWord : ""%>">
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
										<!-- 현재 Block이 마지막 블럭이면 클릭 불가능 -->
    									<li class="page-item disabled"><a class="page-link" href="#"> <span aria-hidden="true">
    									<i class="bi bi-chevron-right"></i></span></a></li>
								<%
    								} else {
								%>
    									<li class="page-item">
        								<a class="page-link" href="reservation.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock%>&nowBlock=<%=nowBlock + 1%>&startDate=<%=startDate != null ? startDate : ""%>&endDate=<%=endDate != null ? endDate : ""%>&keyField=<%=keyField != null ? keyField : ""%>&keyWord=<%=keyWord != null ? keyWord : ""%>">
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
		<script>
    		function downloadExcel() {
        		// JSP에서 자바 객체 데이터를 자바스크립트 배열로 변환
       			 var reservationData = [
            	<%// DAO 메서드를 호출하여 예약 정보를 가져옴
					List<ReservationDTO> reservations = dao.getReservationDTOList(keyField, keyWord, startDate, endDate);
					for (ReservationDTO reservation : reservations) {
				%>
           			 {
                		reservation_no : '<%=reservation.getReservation_no()%>',
               			service_name: '<%=reservation.getService_name()%>',
                		reservation_date : '<%=reservation.getReservation_date()%>',
                		reservation_time : '<%=reservation.getReservation_time()%>',
                		customer_name : '<%=reservation.getCustomer_name()%>',
                		member_name: '<%=reservation.getMember_name()%>',
                		reservation_comm : '<%=reservation.getReservation_comm()%>'
            		},
            	<%}%>
        		];

        		var wb = XLSX.utils.book_new(); // 새로운 엑셀 파일 생성
        		var ws_data = [['예약 번호', '예약 품목', '예약 날짜', '예약 시간', '예약자 명', '직원 명', '특이 사항']]; // 엑셀 헤더

        		// 예약 데이터를 엑셀에 추가
        		reservationData.forEach(function(reservation) {
            	ws_data.push([
                reservation.reservation_no,
                reservation.service_name,
                reservation.reservation_date,
                reservation.reservation_time,
                reservation.customer_name,
                reservation.member_name,
                reservation.reservation_comm
            	]);
        	});

        		var ws = XLSX.utils.aoa_to_sheet(ws_data); // 데이터를 시트로 변환
        		XLSX.utils.book_append_sheet(wb, ws, '예약_관리'); // 시트를 엑셀 파일에 추가

        		// 엑셀 파일 다운로드
        		XLSX.writeFile(wb, '예약_관리.xlsx');
    		}
		</script>

		<script>
			function validateDates() {
				const startDate = document.getElementById('startDate').value;
				const endDate = document.getElementById('endDate').value;

					if (startDate && endDate) {
						if (new Date(startDate) > new Date(endDate)) {
							alert("경고: 시작 날짜가 종료 날짜보다 이후입니다.");
							return false; // 폼 제출을 막음
						}
					}
					return true; // 폼 제출 허용
				}
		</script>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				// 로컬 스토리지에서 날짜 값을 가져와서 설정
				const startDateInput = document.getElementById("startDate");
				const endDateInput = document.getElementById("endDate");

				if (localStorage.getItem("startDate")) {
					startDateInput.value = localStorage.getItem("startDate");
				}
				if (localStorage.getItem("endDate")) {
					endDateInput.value = localStorage.getItem("endDate");
				}

				// 날짜가 변경될 때마다 로컬 스토리지에 저장
				startDateInput.addEventListener("change", function() {
					localStorage.setItem("startDate", startDateInput.value);
				});
				endDateInput.addEventListener("change", function() {
					localStorage.setItem("endDate", endDateInput.value);
				});
			});
		</script>
	</div>
</body>
</html>
