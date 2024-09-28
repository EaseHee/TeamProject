<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SignUp</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/app.css">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/pages/auth.css">
</head>

<body>
    <div id="auth">
        <div class="row h-100">
            <div class="col-lg-6 col-12">
                <div id="auth-left">
                    <div class="auth-logo">
                        <a href="dashboard.jsp"><!-- <img src="assets/images/logo/logo.png" alt="Logo"> -->LOGO</a>
                    </div>
                    <h1 class="auth-title">회원가입</h1>
                    
                    <form action="/TeamProject/signup" method="post" id="signupForm">
                    	<input type="hidden" name="command" value="LOGIN"/>
               	        <div class="form-group position-relative has-icon-left md-4">
                            <input type="text" name="name" class="form-control form-control-xl" placeholder="이름" id="name">
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="text" name="birth" class="form-control form-control-xl" placeholder="생년월일 6자리" id="birth">
                            <div class="form-control-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cake2" viewBox="0 0 16 16"><path d="m3.494.013-.595.79A.747.747 0 0 0 3 1.814v2.683q-.224.051-.432.107c-.702.187-1.305.418-1.745.696C.408 5.56 0 5.954 0 6.5v7c0 .546.408.94.823 1.201.44.278 1.043.51 1.745.696C3.978 15.773 5.898 16 8 16s4.022-.227 5.432-.603c.701-.187 1.305-.418 1.745-.696.415-.261.823-.655.823-1.201v-7c0-.546-.408-.94-.823-1.201-.44-.278-1.043-.51-1.745-.696A12 12 0 0 0 13 4.496v-2.69a.747.747 0 0 0 .092-1.004l-.598-.79-.595.792A.747.747 0 0 0 12 1.813V4.3a22 22 0 0 0-2-.23V1.806a.747.747 0 0 0 .092-1.004l-.598-.79-.595.792A.747.747 0 0 0 9 1.813v2.204a29 29 0 0 0-2 0V1.806A.747.747 0 0 0 7.092.802l-.598-.79-.595.792A.747.747 0 0 0 6 1.813V4.07c-.71.05-1.383.129-2 .23V1.806A.747.747 0 0 0 4.092.802zm-.668 5.556L3 5.524v.967q.468.111 1 .201V5.315a21 21 0 0 1 2-.242v1.855q.488.036 1 .054V5.018a28 28 0 0 1 2 0v1.964q.512-.018 1-.054V5.073c.72.054 1.393.137 2 .242v1.377q.532-.09 1-.201v-.967l.175.045c.655.175 1.15.374 1.469.575.344.217.356.35.356.356s-.012.139-.356.356c-.319.2-.814.4-1.47.575C11.87 7.78 10.041 8 8 8c-2.04 0-3.87-.221-5.174-.569-.656-.175-1.151-.374-1.47-.575C1.012 6.639 1 6.506 1 6.5s.012-.139.356-.356c.319-.2.814-.4 1.47-.575M15 7.806v1.027l-.68.907a.94.94 0 0 1-1.17.276 1.94 1.94 0 0 0-2.236.363l-.348.348a1 1 0 0 1-1.307.092l-.06-.044a2 2 0 0 0-2.399 0l-.06.044a1 1 0 0 1-1.306-.092l-.35-.35a1.935 1.935 0 0 0-2.233-.362.935.935 0 0 1-1.168-.277L1 8.82V7.806c.42.232.956.428 1.568.591C3.978 8.773 5.898 9 8 9s4.022-.227 5.432-.603c.612-.163 1.149-.36 1.568-.591m0 2.679V13.5c0 .006-.012.139-.356.355-.319.202-.814.401-1.47.576C11.87 14.78 10.041 15 8 15c-2.04 0-3.87-.221-5.174-.569-.656-.175-1.151-.374-1.47-.575-.344-.217-.356-.35-.356-.356v-3.02a1.935 1.935 0 0 0 2.298.43.935.935 0 0 1 1.08.175l.348.349a2 2 0 0 0 2.615.185l.059-.044a1 1 0 0 1 1.2 0l.06.044a2 2 0 0 0 2.613-.185l.348-.348a.94.94 0 0 1 1.082-.175c.781.39 1.718.208 2.297-.426"/></svg>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="text" name="ph" class="form-control form-control-xl" placeholder="휴대전화" id="phone">
                            <div class="form-control-icon">
                        		<i class="bi bi-phone"></i>
                            </div>
                        </div>                    
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="text" name="mail" class="form-control form-control-xl" placeholder="이메일" id="email">
                            <div class="form-control-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="text" name="id" class="form-control form-control-xl" placeholder="아이디" id="userId">
                            <div class="form-control-icon">
                                <i class="bi bi-shield-exclamation"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="password" name="pw" class="form-control form-control-xl" placeholder="비밀번호" id="password">
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="password" name="pwcheck" class="form-control form-control-xl" placeholder="비밀번호 확인" id="confirm_password">
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <div class="form-check form-check-lg d-flex align-items-end">
                            <input class="form-check-input me-2" type="checkbox" name="terms" onclick="toggleCheckboxes(this)" value="" id="all_terms">
                            <label class="form-check-label text-gray-600" for="all_terms">
                                모든 약관에 동의합니다.
                            </label>
                        </div>
                        <div class="form-check form-check-lg d-flex align-items-end">
                            <input class="form-check-input me-2" type="checkbox" name="terms" value="" id="terms1">
                            <label class="form-check-label text-gray-600" for="terms1">
                                이용 약관에 동의합니다.[필수]
                            </label>
                        </div>
                        <div class="form-check form-check-lg d-flex align-items-end">
                            <input class="form-check-input me-2" type="checkbox" name="terms" value="" id="terms2">
                            <label class="form-check-label text-gray-600" for="terms2">
                                개인 정보 수집 및 이용에 동의합니다.[필수]
                            </label>
                        </div>
                        <div class="form-check form-check-lg d-flex align-items-end">
                            <input class="form-check-input me-2" type="checkbox" name="terms" value="" id="terms3">
                            <label class="form-check-label text-gray-600" for="terms3">
                                마케팅 활용 및 광고성 정보 수신에 동의합니다.[선택]
                            </label>
                        </div>
                    
                        <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="validateForm()">가입하기</button>
                    	<div id="error-message" style="color: red;"></div>
                    </form>
                    <div class="text-center mt-5 text-lg fs-4">
                        <p class='text-gray-600'>이미 계정이 있으신가요?<br> <a href="login.jsp"
                                class="font-bold">로그인</a></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 d-none d-lg-block">
                <div id="auth-right">
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script>
	<!-- 모든 약관 동의 체크 코드 -->
    function toggleCheckboxes(source) {
        const checkboxes = document.querySelectorAll('input[name="terms"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = source.checked;
        });
    }
    
    var password = document.getElementById("password");
    var confirm_password = document.getElementById("confirm_password");

    function validatePassword() {
        if (password.value !== confirm_password.value) {
            // 비밀번호가 일치하지 않으면 경고 메시지를 표시
            confirm_password.setCustomValidity("비밀번호가 일치하지 않습니다.");
        } else {
            // 비밀번호가 일치하면 경고 메시지를 지움
            confirm_password.setCustomValidity('');
        }
    }

    // 비밀번호 필드의 변경이 발생할 때마다 검증
    password.onchange = validatePassword;
    confirm_password.onkeyup = validatePassword;
    
 	// 이름 검증 함수
    function validateName() {
        var name = document.getElementById("name");
        var nameValue = name.value;
        
     	// 한글, 영문자만 허용, 길이 2~20자
        var namePattern = /^[a-zA-Z가-힣]{2,20}$/; 

        if (!namePattern.test(nameValue)) {
            name.setCustomValidity("이름은 한글 또는 영문자만 사용 가능합니다.");
        } else {
            name.setCustomValidity('');
        }
        
        // 경고 메시지 실시간 표시
        name.reportValidity();
    }

    // 이름 필드의 변경이 발생할 때마다 검증
    document.getElementById("name").addEventListener('input', validateName);
    
 	// 생년월일 검증 함수
    function validateBirth() {
        var birth = document.getElementById("birth");
        var birthValue = birth.value;

        // 생년월일이 숫자 6자리인지 확인
        var birthPattern = /^\d{6}$/;

        if (!birthPattern.test(birthValue)) {
            birth.setCustomValidity("생년월일은 숫자 6자리로 입력해주세요.");
        } else {
            birth.setCustomValidity(''); // 경고 메시지 제거
        }

        // 경고 메시지 실시간 표시
        birth.reportValidity();
    }

    // 생년월일 필드의 변경이 발생할 때마다 검증
    document.getElementById("birth").addEventListener('input', validateBirth);
    
 	// 휴대전화 검증 함수
    function validatePhone() {
        var phone = document.getElementById("phone");
        var phoneValue = phone.value;
        var phonePattern = /^\d{11}$/; // 11자리 숫자 패턴

        if (!phonePattern.test(phoneValue)) {
            phone.setCustomValidity("휴대전화는 11자리 숫자로 입력해주세요.");
        } else {
            phone.setCustomValidity('');
        }

        phone.reportValidity();
    }

    // 휴대전화 필드의 변경이 발생할 때마다 검증
    document.getElementById("phone").addEventListener('input', validatePhone);
	
 	// 이메일 검증 함수
    function validateEmail() {
        var email = document.getElementById("email");
        var emailValue = email.value;
        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 영문자와 숫자만 허용

        if (!emailPattern.test(emailValue)) {
            email.setCustomValidity("유효한 이메일 주소를 입력해주세요.");
        } else {
            email.setCustomValidity('');
        }

        email.reportValidity();
    }

    // 이메일 필드의 변경이 발생할 때마다 검증
    document.getElementById("email").addEventListener('input', validateEmail);

 	// 아이디 검증 함수 (영문자와 숫자만)
    function validateUserId() {
        var userId = document.getElementById("userId");
        var userIdValue = userId.value;
        var userIdPattern = /^[a-zA-Z0-9]+$/; // 영문자와 숫자만 허용

        if (!userIdPattern.test(userIdValue)) {
            userId.setCustomValidity("아이디는 영문자와 숫자로만 입력해주세요.");
        } else {
            userId.setCustomValidity('');
        }

        userId.reportValidity();
    }

    // 아이디 필드의 변경이 발생할 때마다 검증
    document.getElementById("userId").addEventListener('input', validateUserId);
    
    // 필수 약관 검증 및 미입력된 정보에 관한 유효성 검사
    function validateForm(event) {
        var terms1 = document.getElementById("terms1");
        var terms2 = document.getElementById("terms2");
        var isValid = true;

        // 각 항목 검증
        validateName();
        validateBirth();
        validatePhone();
        validateEmail();
        validateUserId();
        validatePassword();

        // 필수 체크박스가 체크되지 않으면 경고 메시지 추가
        if (!terms1.checked) {
            terms1.setCustomValidity("이용 약관에 동의해주세요.");
            terms1.reportValidity(); // 경고 메시지 표시
            isValid = false;
        } else {
            terms1.setCustomValidity(''); // 경고 메시지 제거
        }

        if (!terms2.checked) {
            terms2.setCustomValidity("개인 정보 수집 및 이용에 동의해주세요.");
            terms2.reportValidity(); // 경고 메시지 표시
            isValid = false;
        } else {
            terms2.setCustomValidity(''); // 경고 메시지 제거
        }

        // 유효성 검사가 실패한 경우 폼을 서브밋하지 않도록 이벤트 전파를 막음
        if (!isValid || !document.getElementById("name").checkValidity() ||
        	!document.getElementById("birth").checkValidity() || 
            !document.getElementById("phone").checkValidity() || 
            !document.getElementById("email").checkValidity() || 
            !document.getElementById("userId").checkValidity() || 
            !confirm_password.checkValidity()) {
            event.preventDefault();
        }
    }
</script>