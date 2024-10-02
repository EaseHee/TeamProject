<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약 상세</title>
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
	<jsp:useBean id="serDao" class="bean.ServiceDAO"/>
    <jsp:useBean id="cusDao" class="bean.CustomerDAO"/>
    <jsp:useBean id="resDao" class="bean.ReservationDAO"/>
    <jsp:useBean id="resDto" class="bean.ReservationDTO"/>
    <jsp:useBean id="memDao" class="bean.MemberDAO" />
    
    <%
    	int reservation_no = Integer.parseInt(request.getParameter("reservation_no"));
    	resDto = resDao.getReservationDTO(reservation_no);   	
    %>
<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="reservationPostProc.jsp">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">예약자 명</span>
									<input type="text" class="form-control" value="<%= resDto.getCustomer_name()%>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">서비스 명</span> 
									<input type="text" class="form-control" value="<%= resDto.getService_name()%>" readonly="readonly">
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">예약 날짜</span>
                                    <input type="text" class="form-control" value="<%= resDto.getReservation_date()%>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">예약 시간</span>
                                    <input type="text" class="form-control" value="<%= resDto.getReservation_time().substring(0, 5)%>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">직원 명</span>
                                    <input type="text" class="form-control" value="<%= resDto.getMember_name() %>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">특이 사항</span>
                                    <input type="text" class="form-control" value="<%=resDto.getReservation_comm() != null ? resDto.getReservation_comm() : ""%>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                                <button type="button" onclick="location.href='reservationUpdate.jsp?reservation_no=<%= resDto.getReservation_no() %>'">수정</button>
                                <button type="button" onclick="confirmDelete('<%=resDto.getReservation_no() %>')">삭제</button>
                                <button type="button" onclick="location.href='reservation.jsp'">목록</button>
                            </div>
                        </div>
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
<script>
        function confirmDelete(reservation_no) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                location.href = 'reservationDelete.jsp?reservation_no=' + encodeURIComponent(reservation_no);
            }
        }
    </script>
</body>
</html>