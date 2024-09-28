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
                            <h3>마이페이지</h3>
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
				<br><br><br>
				<!-- MYPAGE 시작 -->
				<form action="mypage_updateProc.jsp">
					<section class="" background-color='#607080'>
				        <div class="container">
				            <div class="row">
				                <div class="col-lg-12 mb-4 mb-sm-5">
				                    <div class="card card-style1 border-0">
				                        <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
				                            <div class="row align-items-center">
				                                <div class="col-lg-6 mb-4 mb-lg-0">
				                                    <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="315">
				                                </div>
				                                <div class="col-lg-6 px-xl-10">
				                                    <ul class="list-unstyled mb-1-9">
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">지점코드 :</span>
				                                        	<input type="text" name="branchcode" value="A01" readonly="readonly">
				                                        </li>
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">이름 :</span>
				                                        	<input type="text" name="name" value="홍길동">
				                                        </li>
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">전화번호 :</span>
				                                        	<input type="text" name="tel" value="010-1111-2222">
				                                        </li>
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">이메일 :</span>
				                                        	<input type="email" name="email" value="www.example.com">
				                                        </li>
				                                    </ul>
				                                </div>
				                                <!-- 버튼 -->
				                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
											        <button class="btn btn-primary me-md-2" type="submit">수정완료</button>
											    </div>
												<!-- 버튼 종료 -->
				                            </div>
				                        </div>
				                    </div>       
				                </div>
				            </div>
				        </div>
				    </section>
			    </form>
                <!-- MYPAGE 종료 -->
                <br><br><br>
                <footer>
                    <div class="footer clearfix mb-0 text-muted">
                        <div class="float-start">
                            <p>2024 &copy; ACORN</p>
                        </div>
                        <div class="float-end">
                            <p>
                                <span class="text-danger"><i class="bi bi-heart"></i></span>
                                by <a href="#">거니네조</a>
                            </p>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </div>
<script	src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/main.js"></script></body>

</html>
</body>
</html>