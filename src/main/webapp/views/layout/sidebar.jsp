<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
	<jsp:include page="link.jsp"/>
</head>

<body>
    <!-- 사이드바 시작 -->
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

            <!-- 사이드바 메뉴 시작 -->
            <div class="sidebar-menu">
                <ul class="menu">
                    <li class="sidebar-title">Menu</li>
                    <li class="sidebar-item active">
                        <a href="../dashboard.jsp" class='sidebar-link'>
                            <i class="bi bi-grid-fill"></i>
                            <span>HOME</span>
                        </a>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-stack"></i>
                            <span>CUSTOMER</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="../customer.jsp">회원 관리</a></li>
                            <li class="submenu-item"><a href="../customer.jsp">기타</a></li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-collection-fill"></i>
                            <span>RESERVATION</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="../reservation.jsp">예약 관리</a></li>
                            <li class="submenu-item"><a href="../reservation.jsp">기타</a></li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>SERVICE</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="../service.jsp">서비스 관리</a></li>
                            <li class="submenu-item"><a href="../service.jsp">기타</a></li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-hexagon-fill"></i>
                            <span>PRODUCT</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="../product.jsp">상품 관리</a></li>
                            <li class="submenu-item"><a href="../product.jsp">기타</a></li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class='sidebar-link'>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16">
                                <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c-.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/>
                            </svg>
                            <span>MEMBER</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="../member.jsp">직원 관리</a></li>
                            <li class="submenu-item"><a href="../member.jsp">기타</a></li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class='sidebar-link'>
                            <i class="bi bi-pen-fill"></i>
                            <span>NOTICE</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="../notice_list.jsp">공지 사항</a></li>
                            <li class="submenu-item"><a href="../notice_list.jsp">기타</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- 사이드바 메뉴 끝 -->
            <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
        </div>
    </div>
    <!-- 사이드바 끝 -->
    <jsp:include page="script.jsp"/>
</body>
</html>