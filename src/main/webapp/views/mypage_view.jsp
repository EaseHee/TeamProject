<%@page import="bean.MypageDAO"%>
<%@ page import="bean.MypageDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MYPAGE</title>
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
<%
    // URL에서 branchcode 가져오기
    String branchCode = request.getParameter("branchCode");

    // branchcode가 유효한지 확인
    if (branchCode == null || branchCode.isEmpty()) {
        out.println("지점 코드가 없습니다.");
    } else {
        // branchcode를 사용하여 데이터베이스에서 관리자 정보를 조회
        MypageDAO dao = new MypageDAO();
        MypageDTO manager = dao.getManagerInfo(branchCode);

        // manager 정보가 null인지 확인
        if (manager == null) {
            out.println("관리자 정보를 가져오지 못했습니다.");
        } else {
%>
	<div id="app">
		<jsp:include page="/views/header.jsp" ></jsp:include>
				<!-- MYPAGE 시작 -->

            <section class="section">
                <form action="mypage_update.jsp" method="get">
                    <div class="container">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-4 mb-sm-5">
                                <div class="card card-style1 border-0">
                                    <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
                                        <div class="row align-items-center">
                                            <div class="col-lg-5 mb-4 mb-lg-0">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="315">
                                            </div>
                                            <div class="col-lg-7 px-xl-10">
                                                <ul class="list-unstyled mb-1-9">
                                                    <li class="input-group mb-2 mb-xl-3 display-28">
                                                        <span class="input-group-text" id="basic-addon1">지점 코드</span>
                                                        <input type="text" class="form-control" name="branchCode" 
                                                        value="<%= manager.getBranch_code() %>" readonly="readonly" />
                                                    </li>
                                                    <li class="input-group mb-2 mb-xl-3 display-28">
                                                        <span class="input-group-text">이 름</span>
                                                        <input type="text" class="form-control" name="name" 
                                                        value="<%= manager.getManager_name() %>" readonly="readonly"/>
                                                    </li>
                                                    <li class="input-group mb-2 mb-xl-3 display-28">
                                                        <span class="input-group-text">전화 번호</span>
                                                        <input type="text" class="form-control" name="tel" 
                                                        value="<%= manager.getManager_tel() %>" readonly="readonly"/>
                                                    </li>
                                                    <li class="input-group mb-2 mb-xl-3 display-28">
                                                        <span class="input-group-text">이메일</span>
                                                        <input type="email" class="form-control" name="mail" 
                                                        value="<%= manager.getManager_mail() %>" readonly="readonly"/>
                                                    </li>
                                                </ul>
                                            </div>
                                            <!-- 버튼 -->
                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                <button type="submit">수정하기</button>
                                            </div>
                                            <!-- 종료 -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </section>
<% 
        } 
    } 
%>
<!-- MYPAGE 종료 -->
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>