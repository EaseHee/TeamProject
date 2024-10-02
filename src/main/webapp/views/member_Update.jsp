<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>직원 수정</title>
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
    <%--jsp:useBean id="branachDao" class="bean.BranchDAO" /--%> 
    <!-- 지점 테이블 만들면 불러와야해 -->
	<jsp:useBean id="memberDao" class="bean.MemberDAO"/>
    <jsp:useBean id="memberDto" class="bean.MemberDTO"/>
    
    <%
    	String member_id = request.getParameter("member_id");
    	memberDto = memberDao.getMemberDTO(member_id);   	
    %>
<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="member_UpdateProc.jsp">
                    <input type="hidden" name="member_id" value="<%=memberDto.getMember_id() %>" />
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">지점 코드</span>
									<input type="text" class="form-control" value="B001" readonly="readonly" />
									<!-- 지점 테이블 생성 필요 branch -->
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">직원 사번</span>
                                    <input type="text" class="form-control" name="member_id" value="<%= memberDto.getMember_id()%>" readonly="readonly"/>
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">직원 명</span>
                                    <input type="text" class="form-control" name="member_name" value="<%= memberDto.getMember_name()%>" />
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">직원 직책</span>
									
										<select name="member_job" class="form-control">
											<option value="원장"
												<%="원장".equals(memberDto.getMember_job()) ? "selected" : ""%>>원장</option>
											<option value="부원장"
												<%="부원장".equals(memberDto.getMember_job()) ? "selected" : " "%>>부원장</option>
											<option value="실장"
												<%="실장".equals(memberDto.getMember_job()) ? "selected" : ""%>>실장</option>
											<option value="디자이너"
												<%="디자이너".equals(memberDto.getMember_job()) ? "selected" : ""%>>디자이너</option>
											<option value="인턴"
												<%="인턴".equals(memberDto.getMember_job()) ? "selected" : ""%>>인턴</option>
											<option value="파트 타임"
												<%="파트 타임".equals(memberDto.getMember_job()) ? "selected" : ""%>>파트 타임</option>
										</select>
								
								</div>
							</div>
							<br> <br> <br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">입사일</span> 
									<input type="date" class="form-control" name="member_date" value="<%=memberDto.getMember_date()%>" readonly="readonly"> 
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">전화 번호</span>
                                    <input type="text" class="form-control" name="member_tel" value="<%= memberDto.getMember_tel()%>">
                                </div>
                            </div>
                            <br><br><br>
                            
                            <div class="button-container">
                            <button type="button" onclick="location.href='member.jsp'">목록</button>
                                <button type="submit" onclick="수정되었습니다.">등록</button>
                                
                            </div>
                        </div>
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>