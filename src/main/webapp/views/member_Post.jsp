<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>직원 등록</title>
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
		a {
		    color: inherit;  /* 부모 요소의 텍스트 색상을 따르도록 설정 */
		    text-decoration: none;  /* 밑줄 없애기 */
		}		
		a:visited {
		    color: inherit;
		}		
		a:hover {
		    color: inherit;
		}		
		a:active {
		    color: inherit;
		}
		.list-group-item.detail{
			font-size: small;
		}
		.bi-plus-square {
			display: inline-block;
			transform: translateY(2px);
		}
		.bi-person-fill{
			display: inline-block;
			transform: translateY(6px);
			margin-right: 5px;
		}
		.bi-bell-fill{
			display: inline-block;
			transform: translateY(3px);
			margin-right: 5px;
		}
		.bi-box-arrow-right{
			display: inline-block;
			transform: translateY(3px);
		}
		button {
            background-color: rgb(42, 105, 241);
            color: white;
            border: none;
            border-radius: 5px;
            height: 25px;
            width: 50px;
            cursor: pointer;
        }
        .input-group-text{
        	display: inline-block; 
        	width: 10%;
        } 
	</style>
</head>

<body>
	<jsp:useBean id="memberDao" class="bean.MemberDAO" />
    <jsp:useBean id="memberDto" class="bean.MemberDTO"/>
    
    
         <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp">LOGO</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>

                        <li class="sidebar-item ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>HOME</span>
                            </a>
                        </li>

                        <li class="sidebar-item has-sub">
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
                        <li class="sidebar-item active has-sub">
                            <a href="#" class='sidebar-link'>
                            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16"><path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/></svg>                               
                                <span>MEMBER</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="member.jsp">직원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="member.jsp">기타</a>
                                </li>
                            </ul>
                        </li>
 
                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-megaphone-fill"></i>
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
                            <h3>직원 등록</h3>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb"
                                class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
	                                    <i class="bi bi-person-fill" style="font-size:x-large; color: green;" ></i>
	                       	 			<i class="bi bi-bell-fill" style="font-size:larger; line-height: 10px; color: green;" ></i>
                                    	<a href="login.jsp"><span class="badges badge bg-light-danger">로그아웃</span>&nbsp;<i class="bi bi-box-arrow-right " ></i></a>
                                   	</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <hr style="height: 5px;">
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="member_PostProc.jsp">
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
									<input type="text" class="form-control" name="member_id" placeholder="  사번을 입력해 주세요" required="required" />
								</div>
							</div>
							<br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">직원 명</span> 
									<input type="text" class="form-control" name="member_name" placeholder="  이름을 입력해 주세요" required="required" />
								</div>
							</div>
							<br> <br> <br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12"> 
									<span class="input-group-text" id="basic-addon1">직원 직책</span> 
									<select name="member_job" class="form-control">
											<option value="원장">원장</option>
											<option value="부원장">부원장</option>
											<option value="실장">실장</option>
											<option value="인턴">인턴</option>
											<option value="디자이너">디자이너</option>
											<option value="파트타임">파트타임</option>
									</select>
								</div>
							</div>
							<br> <br> <br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">입사일</span> 
									<input type="date" class="form-control" name="member_date" required="required" />
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">전화 번호</span>
                                    <input type="text" class="form-control" name="member_tel" placeholder="  010-0000-0000형식으로 입력해주세요." required="required" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                                <button type="submit" onclick="등록되었습니다.">등록</button>
                                <button type="button" onclick="location.href='member.jsp'">목록</button>
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
                                by <a href="#main">거니네조</a>
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