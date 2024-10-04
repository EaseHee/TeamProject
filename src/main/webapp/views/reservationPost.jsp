<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약 등록</title>
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
    <jsp:useBean id="memDao" class="bean.MemberDAO" />
<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="reservationPostProc.jsp">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">예약자 명</span>
                                    <select name="customer_name" class="form-control">
                                    <% 
                						List<String> customerNames = cusDao.getAllCustomerNames();

               							for (String customerName : customerNames) {
            						%>
                							<option value="<%= customerName %>"><%= customerName %></option>
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
	
											for (String serviceName : serviceNames) {
										%>
											<option value="<%=serviceName%>"><%=serviceName%></option>
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
    								<input type="date" id="reservation_date" class="form-control" name="reservation_date" onclick="this.showPicker()">
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
                                    <span class="input-group-text" id="basic-addon1">예약 시간</span>
                                    <!--  
                                    <input type="time" class="form-control" name="reservation_time">
                                    -->
									<select name="reservation_time" class="form-control">
										<option value="09:00">09:00</option>
										<option value="09:30">09:30</option>
										<option value="10:00">10:00</option>
										<option value="10:30">10:30</option>
										<option value="11:00">11:00</option>
										<option value="11:30">11:30</option>
										<option value="12:00">12:00</option>
										<option value="12:30">12:30</option>
										<option value="13:00">13:00</option>
										<option value="13:30">13:30</option>
										<option value="14:00">14:00</option>
										<option value="14:30">14:30</option>
										<option value="15:00">15:00</option>
										<option value="15:30">15:30</option>
										<option value="16:00">16:00</option>
										<option value="16:30">16:30</option>
										<option value="17:00">17:00</option>
										<option value="17:30">17:30</option>
										<option value="18:00">18:00</option>
										<option value="18:30">18:30</option>
										<option value="19:00">19:00</option>
										<option value="19:30">19:30</option>
										<option value="20:00">20:00</option>
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
	
											for (String memberName : memberNames) {
										%>
											<option value="<%=memberName%>"><%=memberName%></option>
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
                                    <input type="text" class="form-control" name="reservation_comm" placeholder="  특이 사항을 입력해 주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">         
                                <button type="button" onclick="location.href='reservation.jsp'">목록</button>
                                <button type="submit" onclick="alert('등록되었습니다.')">등록</button>
                            </div>
                        </div>
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</html>
</body>
</html>