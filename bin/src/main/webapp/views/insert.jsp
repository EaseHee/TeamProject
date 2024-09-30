<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>INSERT</title>
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
                            <h3>등록</h3>
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
                    <form method="post" id="">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">품목 코드</span>
                                    <input type="text" class="form-control" name="b_ser_code" placeholder="  품목 코드를 입력해 주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">서비스 명</span>
                                    <input type="text" class="form-control" name="b_ser_code" placeholder="  등록하실 서비스를 입력해주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">판매 가격</span>
                                    <input type="text" class="form-control" name="b_ser_code" placeholder="  가격을 입력해 주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                                <button type="submit" onclick="등록되었습니다.">등록</button>
                                <button type="button" onclick="location.href='sales.jsp'">목록</button>
                            </div>
                        </div>
                    </form>
                </section>
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