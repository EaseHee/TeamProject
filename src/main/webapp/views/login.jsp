<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TeamProject/views/assets/css/bootstrap.css">
<link rel="stylesheet" href="/TeamProject/views/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="/TeamProject/views/assets/css/app.css">
<link rel="stylesheet" href="/TeamProject/views/assets/css/pages/auth.css">

</head>
<body>
	<!-- 쿠키값으로 id 정보 받아오기 -->
	<%
		String cookie = "";
		Cookie[] cookies = request.getCookies(); //쿠키생성
		if(cookies !=null&& cookies.length > 0)
		for (int i = 0; i < cookies.length; i++){
			if (cookies[i].getName().equals("branchCode")) { // 내가 원하는 쿠키명 찾아서 값 저장
				cookie = cookies[i].getValue();}}
	%>
	<div id="auth">
		<div class="row h-100">
			<div class="col-lg-5 col-12">
				<div id="auth-left">
					<div class="auth-logo">
						<a href="#">
							<!-- <img src="assets/images/logo/logo.png" alt="Logo"> -->LOGO
						</a>
					</div>
					<h1 class="auth-title">로그인</h1>
					<form action="/TeamProject/login" method="post">
						<input type="hidden" name="command" value="DASHBOARD" />
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="지점코드" name="code" id="branchCode" value="<%=cookie%>">
								<!-- 쿠키에 저장된 아이디가 있다면 cookie 값이 입력창 내부에 기본값으로 입력됨 -->
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="password" class="form-control form-control-xl"
								placeholder="비밀번호" name="pw" id="password">
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>
						<div class="form-check form-check-lg d-flex align-items-end">
							<input class="form-check-input me-2" type="checkbox" name="checkbox" checked="checked" id="flexCheckDefault"> 
								<label class="form-check-label text-gray-600" for="flexCheckDefault">아이디 저장 </label>
						</div>
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">로그인</button>
					</form>
					<div class="text-center mt-5 text-lg fs-4">
						 <p class="text-gray-600">
							<a href="signup.jsp" class="font-bold">회원가입</a>
						</p>
						<!-- 비밀번호 찾기 개발 예정 주석 처리
						<p>
							<a class="font-bold" href="#">비밀번호를 잊으셨나요?</a> 
						</p>
						-->
					</div>
				</div>
			</div>
			<div class="col-lg-7 d-none d-lg-block">
				<div id="auth-right"></div>
			</div>
		</div>
	</div>
</body>
</html>