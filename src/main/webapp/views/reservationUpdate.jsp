<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약 수정</title>
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
	<jsp:useBean id="serDao" class="bean.ServiceDAO" />
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
                    <form method="post" id="" accept-charset="UTF-8" action="reservationUpdateProc.jsp">
                    <input type="hidden" name="reservation_no" value="<%=resDto.getReservation_no() %>" />
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">예약자 명</span>
                                    <select name="customer_name" class="form-control">
                                    <% 
                						List<String> customerNames = cusDao.getAllCustomerNames();
                                    	String selectedCustomerName = resDto.getCustomer_name();

               							for (String customerName : customerNames) {
            						%>
                							<option value="<%= customerName %>" <%= customerName.equals(selectedCustomerName) ? "selected" : "" %>>
                							<%= customerName %>
                							</option>
            						<% 
            						    }
          							 %>
          							 </select>
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">서비스 명</span> 
									<select name="service_name" class="form-control">
										<%
											List<String> serviceNames = serDao.getAllServiceNames();
											String selectedServiceName = resDto.getService_name();
	
											for (String serviceName : serviceNames) {
										%>
											<option value="<%=serviceName%>" <%= serviceName.equals(selectedServiceName) ? "selected" : "" %>>
											<%=serviceName%>
											</option>
										<%
											}
										%>
									</select>
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
    								<span class="input-group-text" id="basic-addon1">예약 날짜</span>
    								<input type="date" id="reservation_date" class="form-control" name="reservation_date" value="<%= resDto.getReservation_date() %>" onclick="this.showPicker()">
								</div>
								<script>
									//예약 날짜 선택 시, 오늘 이전 날짜 선택 불가능
   	 								document.addEventListener("DOMContentLoaded", function() {
        								var now_utc = Date.now(); // 현재 시간을 UTC로
        								var timeOff = new Date().getTimezoneOffset() * 60000; // UTC와의 차이를 밀리초로
        								var today = new Date(now_utc - timeOff).toISOString().split("T")[0]; // ISO 형식에서 날짜 부분만 추출
        								document.getElementById('reservation_date').setAttribute('min', today); // min 속성에 오늘 날짜 설정
    								});
   	 								
								</script>
                            </div>
                            <br><br><br>
				<div class="col-lg-12 mb-12">
					<div class="input-group mb-12">
						<span class="input-group-text" id="basic-addon1">예약 시간</span> <select
							name="reservation_time" class="form-control">
							<%
							String selectedTime = resDto.getReservation_time().substring(0, 5); // 시:분 포맷으로 자르기
							%>
							<option value="09:00" <%=selectedTime.equals("09:00") ? "selected" : ""%>>09:00</option>
							<option value="09:30" <%=selectedTime.equals("09:30") ? "selected" : ""%>>09:30</option>
							<option value="10:00" <%=selectedTime.equals("10:00") ? "selected" : ""%>>10:00</option>
							<option value="10:30" <%=selectedTime.equals("10:30") ? "selected" : ""%>>10:30</option>
							<option value="11:00" <%=selectedTime.equals("11:00") ? "selected" : ""%>>11:00</option>
							<option value="11:30" <%=selectedTime.equals("11:30") ? "selected" : ""%>>11:30</option>
							<option value="12:00" <%=selectedTime.equals("12:00") ? "selected" : ""%>>12:00</option>
							<option value="12:30" <%=selectedTime.equals("12:30") ? "selected" : ""%>>12:30</option>
							<option value="13:00" <%=selectedTime.equals("13:00") ? "selected" : ""%>>13:00</option>
							<option value="13:30" <%=selectedTime.equals("13:30") ? "selected" : ""%>>13:30</option>
							<option value="14:00" <%=selectedTime.equals("14:00") ? "selected" : ""%>>14:00</option>
							<option value="14:30" <%=selectedTime.equals("14:30") ? "selected" : ""%>>14:30</option>
							<option value="15:00" <%=selectedTime.equals("15:00") ? "selected" : ""%>>15:00</option>
							<option value="15:30" <%=selectedTime.equals("15:30") ? "selected" : ""%>>15:30</option>
							<option value="16:00" <%=selectedTime.equals("16:00") ? "selected" : ""%>>16:00</option>
							<option value="16:30" <%=selectedTime.equals("16:30") ? "selected" : ""%>>16:30</option>
							<option value="17:00" <%=selectedTime.equals("17:00") ? "selected" : ""%>>17:00</option>
							<option value="17:30" <%=selectedTime.equals("17:30") ? "selected" : ""%>>17:30</option>
							<option value="18:00" <%=selectedTime.equals("18:00") ? "selected" : ""%>>18:00</option>
							<option value="18:30" <%=selectedTime.equals("18:30") ? "selected" : ""%>>18:30</option>
							<option value="19:00" <%=selectedTime.equals("19:00") ? "selected" : ""%>>19:00</option>
							<option value="19:30" <%=selectedTime.equals("19:30") ? "selected" : ""%>>19:30</option>
							<option value="20:00" <%=selectedTime.equals("20:00") ? "selected" : ""%>>20:00</option>
						</select>
					</div>
				</div>
				<br><br><br>
                            <div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">직원 명</span> 
									<select name="member_name" class="form-control">
										<%
											List<String> memberNames = memDao.getAllMemberNames();
											String selectedMemberName = resDto.getMember_name();
	
											for (String memberName : memberNames) {
										%>
											<option value="<%=memberName%>" <%= memberName.equals(selectedMemberName) ? "selected" : "" %>>
											<%=memberName%>
											</option>
										<%
											}
										%>
									</select>
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">특이 사항</span>
                                    <input type="text" class="form-control" name="reservation_comm" value="<%=resDto.getReservation_comm() != null ? resDto.getReservation_comm() : ""%>">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                            	<button type="button" onclick="location.href='reservation.jsp'">목록</button>
                                <button type="submit" onclick="alert('수정되었습니다.')">수정</button>
                            </div>
                        </div>
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>

</body>
</html>