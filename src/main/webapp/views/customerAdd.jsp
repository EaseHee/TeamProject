<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/bootstrap.css">
<link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="assets/css/app.css">
<link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
	
	<style>
		button {
            background-color: rgb(42, 105, 241);
            color: white;
            border: none;
            border-radius: 5px;
            height: 25px;
            width: 50px;
            cursor: pointer;
        }
	</style>


</head>
<body>
<div id="sidebar" class="active">
        <div class="sidebar-wrapper active">
            <div class="sidebar-header">
                <div class="d-flex justify-content-between">
                    <div class="logo">
                        <a href="#">LOGO</a>
                    </div>
                    <div class="toggler">
                        <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                    </div>
                </div>
            </div>
            <div class="sidebar-menu">
                <ul class="menu">
                    <li class="sidebar-title">Menu</li>

                    <li class="sidebar-item active ">
                        <a href="dashboard.jsp" class='sidebar-link'>
                            <i class="bi bi-grid-fill"></i>
                            <span>HOME</span>
                        </a>
                    </li>

                    <li class="sidebar-item  has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-stack"></i>
                            <span>CUSTOMER</span>
                        </a>
                        <ul class="submenu ">
                            <li class="submenu-item ">
                                <a href="customer.jsp">회원 관리</a>
                            </li>
                            <li class="submenu-item ">
                                <a href="customer.jsp">기타</a>
                            </li>                                
                        </ul>
                    </li>

                    <li class="sidebar-item  has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-collection-fill"></i>
                            <span>RESERVATION</span>
                        </a>
                        <ul class="submenu ">
                            <li class="submenu-item ">
                                <a href="reservation.jsp">예약 관리</a>
                            </li>
                            <li class="submenu-item ">
                                <a href="reservation.jsp">기타</a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-item  has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>SERVICE</span>
                        </a>
                        <ul class="submenu ">
                            <li class="submenu-item ">
                                <a href="service.jsp">서비스 관리</a>
                            </li>
                            <li class="submenu-item ">
                                <a href="service.jsp">기타</a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-item  has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-hexagon-fill"></i>
                            <span>PRODUCT</span>
                        </a>
                        <ul class="submenu ">
                            <li class="submenu-item ">
                                <a href="product.jsp">상품 관리</a>
                            </li>
                            <li class="submenu-item ">
                                <a href="product.jsp">기타</a>
                            </li>
                         </ul>
                    </li>

                    <li class="sidebar-item  has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-pen-fill"></i>
                            <span>NOTICE</span>
                        </a>
                        <ul class="submenu ">
                            <li class="submenu-item ">
                                <a href="notice_list.jsp">공지 사항</a>
                            </li>
                            <li class="submenu-item ">
                                <a href="notice_list.jsp">기타</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
        </div>
    </div>
    
    <div id="app">		
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none"> <i
                    class="bi bi-justify fs-3"></i>
                </a>
            </header>
            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>회원 등록</h3>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb"
                                class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="login.jsp">로그아웃</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <hr style="height: 5px;">
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="customerAddProc.jsp">

        <div>
            <label>회원 ID</label>
            <br><input type="text" class="form" name="customer_id" placeholder="아이디를 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>회원 이름</label>
            <br><input type="text" class="form" name="customer_name" placeholder="이름을 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>성별</label>
            <div class="search-filter">
                <select class="form" name="customer_gender">
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                </select>
            </div>
        </div>
        <br>
        <div>
            <label>회원 연락처</label>
            <br><input type="text" class="form" name="customer_tel" placeholder="연락처를 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>회원 이메일</label>
            <br><input type="text" class="form" name="customer_mail" placeholder="이메일을 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>회원 등록일</label>
            <br>
            <input type="date" class="form" name="customer_reg" id="regdate">
            <script>
         		// 현재 날짜를 YYYY-MM-DD 형식으로 가져옴
            	var today = new Date().toISOString().split('T')[0];
         		// input 태그에 최소값(min)을 현재 날짜로 설정
           		document.getElementById('regdate').setAttribute('min', today);
            	// 기본 값도 오늘 날짜로 설정
            	document.getElementById('regdate').valueAsDate = new Date();
        </script>
        </div>
        <br>
        <div>
            <label>회원 등급</label>
            <br>
            <select class="form" name="customer_rank">
                <option value="GOLD">GOLD</option>
                <option value="SILVER">SILVER</option>
                <option value="BRONZE">BRONZE</option>
            </select>
        </div>
        <br>
        <div>
            <label>회원 특이사항</label>
            <br><input type="text" class="form" name="customer_note" placeholder="특이사항을 입력해 주세요.">
        </div>
        <br>
        <div class="button-container">
            <button type="submit" onclick="alert('등록되었습니다.')">등록</button>
            &nbsp;&nbsp;
            <button type="button" onclick="location.href='customer.jsp'">목록</button>
        </div>
    </form>
</div>
</body>
</html>
