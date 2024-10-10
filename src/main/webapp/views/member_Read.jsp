<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>직원 상세</title>
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
    <jsp:useBean id="memberDao" class="bean.MemberDAO"/>
    <jsp:useBean id="memberDto" class="bean.MemberDTO"/>
    
    <%
    	String member_id = request.getParameter("member_id");
    	memberDto = memberDao.getMemberDTO(member_id);   	
    %>
<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="reservationPostProc.jsp">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">지점 코드</span>
									<input type="text" class="form-control" value="B001" readonly="readonly">
									<!-- 지점 테이블 생성 필요 branch -->
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">사번</span> 
									<input type="text" class="form-control" value="<%= memberDto.getMember_id()%>"  readonly="readonly" />
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">이름</span>
                                    <input type="text" class="form-control" value="<%= memberDto.getMember_name()%>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>							
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">직책</span>
                                    <input type="text" class="form-control" value="<%= memberDto.getMember_job()%>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1"> 입사일 </span>
                                    <input type="date" class="form-control" value="<%= memberDto.getMember_date()%>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1"> 연락처 </span>
                                    <input type="text" class="form-control" value="<%= memberDto.getMember_tel()%>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                            <button type="button" onclick="location.href='member.jsp'">목록</button>
                                <button type="button" onclick="location.href='member_Update.jsp?member_id=<%= memberDto.getMember_id() %>'">수정</button>
                                <button type="button" onclick="confirmDelete('<%= memberDto.getMember_id() %>')">삭제</button>
                                
                            </div>
                        </div>
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
    <script>
    //삭제 할 때 alert 창 뜨도록
        function confirmDelete(member_id) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                location.href = 'member_Delete.jsp?member_id=' + encodeURIComponent(member_id);
            }
        }
    </script>

</body>
</html>