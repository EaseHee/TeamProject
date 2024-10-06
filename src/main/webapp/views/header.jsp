 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp">로고</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">메뉴</li>

                        <li id="dashboard-li" class="sidebar-item  ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>홈</span>
                            </a>
                        </li>

                        <li id="customer-li" class="sidebar-item ">
                            <a href="customer.jsp" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>고객 관리</span>
                            </a>
                        </li>

                        <li id="reservation-li" class="sidebar-item ">
                            <a href="reservation.jsp" class='sidebar-link'>
                                <i class="bi bi-collection-fill"></i>
                                <span>예약 관리</span>
                            </a>
                        </li>

                        <li id="service-li" class="sidebar-item ">
                            <a href="service.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>서비스 관리</span>
                            </a>
                        </li>

                        <li id="product-li" class="sidebar-item ">
                            <a href="product.jsp" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>상품 관리</span>
                            </a>
                        </li>
                        <li id="member-li" class="sidebar-item ">
                            <a href="member.jsp" class='sidebar-link'>
                            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16"><path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/></svg>                               
                                <span>직원 관리</span>
                            </a>
                        </li>
 
                        <li id="notice-li" class="sidebar-item ">
                            <a href="notice_list.jsp" class='sidebar-link'>
                                <i class="bi bi-megaphone-fill"></i>
                                <span>공지사항</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
            </div>
        </div>
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3 id="header-text"></h3>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
	                                    <!-- 마이페이지 버튼 -->
										<form action="mypage_view.jsp" method="get" style="display: inline; margin: 0;">
											    <input type="hidden" name="branchCode" value="${branchCode}">
											    <b><%=branchName%>&nbsp;&nbsp;&nbsp;</b><button type="submit" style="background: none; border: none; padding: 0; width: 25px">
											        <i class="bi bi-person-fill text-primary" style="font-size:x-large;"></i>
											    </button>
											</form>

	                       	 			<i class="bi bi-bell-fill text-primary" style="font-size:larger; line-height: 10px;" ></i>
                                    	<a href="login.jsp"><span class="badges badge bg-primary">로그아웃&nbsp;<i class="bi bi-box-arrow-right " ></i></span></a>
                                   	</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <hr style="height: 5px;">
                
