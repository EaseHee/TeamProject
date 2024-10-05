<%@page import="bean.*"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
	
	<style>
		a {
		    color: inherit;  /* 부모 요소의 텍스트 색상을 따르도록 설정 */
		    text-decoration: none;  /* 밑줄 없애기 */
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
        .content {
        	background-color: rgb(255, 255, 255);
        	border: none;
        	border-radius: 10px;
        	padding: 50px;
        }
        .comment {
        	width: 100%;
        	border: none;
        	outline: none;
        	resize: none;
        }
        .img-profile {
        	width: 80px;
        	height: 80px;
        	background-color: rgb(37, 57, 111);
        	font-size: 12px;
        	color: white;
        	display: flex;
        	justify-content: center;
        	align-items: center;
        	border-radius: 50%;
        	margin-right: 16px;
        }
        .comment-div {
        	background-color: white;
        	border:solid;
        	border-width: 1px;
        	border-radius: 5px;
        	border-color: rgb(37, 57, 111);
        	overflow: hidden;
        }
	</style>
</head>
<body>
	<jsp:useBean id="noticeDAO" class="bean.NoticeDAO"></jsp:useBean>

    <div id="app">
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

                        <li class="sidebar-item ">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>홈</span>
                            </a>
                        </li>

                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>고객</span>
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
                                <span>예약</span>
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
                                <span>서비스</span>
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
                                <span>상품</span>
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
                        <li class="sidebar-item has-sub">
                            <a href="#" class='sidebar-link'>
                            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16"><path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/></svg>                               
                                <span>직원</span>
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
 
                        <li class="sidebar-item active has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-megaphone-fill"></i>
                                <span>공지</span>
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
                <button type="button" class="sidebar-toggler btn x"><i data-feather="x"></i></button>
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
	                            <h3>공지사항</h3>
	                        </div>
	                        <div class="col-12 col-md-6 order-md-2 order-first">
	                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item">
	                                    <i class="bi bi-person-fill text-primary" style="font-size:x-large; " ></i>
	                       	 			<i class="bi bi-bell-fill text-primary" style="font-size:larger; line-height: 10px;" ></i>
                                    	<a href="login.jsp"><span class="badges badge bg-primary">로그아웃&nbsp;<i class="bi bi-box-arrow-right " ></i></span></a>
                                   	</li>                              
	                                </ol>
	                            </nav>
	                        </div>
	                    </div>
	                </div>
	                <hr style="height: 5px;">
	                <section class="section">
	                <%	
	                	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
						NoticeDTO noticeDTO = noticeDAO.getNoticeDetail(notice_no);
	                %>
		                <div>
	                        <div class="mb-5">
	                        	<div class="mt-5">
	                        		<h4><%=noticeDTO.getNotice_title()%></h4>
	                        	</div>
	                        	<div class="d-flex justify-content-between">
	                        		<div><h6>&#35;<%=noticeDTO.getNotice_no()%></h6></div>
	                        		<div><%=noticeDTO.getNotice_reg()%></div>
	                        	</div>
	                            <div class="content"><%=noticeDTO.getNotice_content()%></div>
	                        </div>
		                    <div class="container mb-5 d-flex justify-content-center gap-2">
	                    		<%
		                    		NoticeDTO previousNotice = noticeDAO.getPreviousNotice(notice_no);
		                    		NoticeDTO nextNotice = noticeDAO.getNextNotice(notice_no);
	                    			
		                    	// 버튼 세 개가 보이되, 맨 첫 게시글이나 맨 마지막 게시글 페이지에서 이전/다음 페이지 버튼이 없어도 목록버튼 위치가 변하지 않도록 함
		                    		// 조회 가능한 공지사항 범위를 넘어선 글의 번호를 가져오면 null이 아니라 0이 반환됨. int의 기본값이라 그런 듯? 
		                    		if(previousNotice.getNotice_no() != 0){
		                    	%>		<!-- 이전 게시글이 있을 때에만 보이는 버튼 -->
				                    	<button type="button" onclick="location.href='notice_view.jsp?notice_no=<%=previousNotice.getNotice_no()%>'">이전</button>
		                    	<%
		                    		} else {
		                    	%>		<!-- 자리만 차지하고 있는 비활성화된 버튼 -->
		                    			<button type="button" disabled aria-disabled="true" style="visibility: hidden;">이전</button>
		                    	<%
		                    		}
		                    	%>
                    			<button onclick="location.href='notice_list.jsp'">목록</button>
                    			<%
									if(nextNotice.getNotice_no() != 0){
								%>		<!-- 다음 게시글이 있을 때에만 보이는 버튼 -->
										<button type="button" onclick="location.href='notice_view.jsp?notice_no=<%=nextNotice.getNotice_no()%>'">다음</button>
								<%
									} else {
								%>		<!-- 자리만 차지하고 있는 비활성화된 버튼 -->
										<button type="button" disabled aria-disabled="true" style="visibility: hidden;">다음</button>
								<%
									}
								%>
		                    </div>
		                </div>
		                <!-- 
		                <div class="comment-div mb-5">
	                    	<textarea class="comment" id="commentForm" rows="3" placeholder="매니저님들의 의견을 들려주세요!"></textarea>
	                    	<table class="w-100">
	                    		<tr>
	                    			<td style="background-color: rgb(245, 245, 245);">0/500</td>
	                    			<td style="width: 50px; padding: 0;">
	                    				<button onclick="writeComment()" style="border-radius: 0; background-color: rgb(230, 230, 230); height: 26px;">입력</button>
	                    			</td>
	                    		</tr>
	                    	</table>
	                    </div>
		                <div>
		               		<table>
		               			<tr>
		               				<td class="align-top">
		               					<div class="img-profile">프로필 사진</div>
		               				</td>
		               				<td class="w-100">
		               					<table class="w-100">
		               						<tr><td><b>매니저A</b> 2024.01.01 10:00</td></tr>
		               						<tr><td>매니저A의 댓글...</td></tr>
		               						<tr class="text-end">
		               							<td>
		               								<a href="#">삭제</a> 
		               								<a href="#">수정</a> 
		               								<a data-bs-toggle="collapse" href="#collapseReply1" aria-expanded="false" aria-controls="collapseReply1">답글</a>
		               							</td>
		               						</tr>
		               						<tr>
		               							<td>
		               								<form class="collapse mt-2" id="collapseReply1">
								                    	<textarea class="comment" rows="3" placeholder="매니저A에게 답글을 작성..."></textarea>
								                    	<table class="w-100">
								                    		<tr>
								                    			<td style="background-color: rgb(245, 245, 245);">0/500</td>
								                    			<td style="text-align: center; width: 50px; background-color: rgb(230, 230, 230); cursor: pointer;" onclick="location.href='#'">입력</td>
								                    		</tr>
								                    	</table>
								                    </form>
		               							</td>
		               						</tr>
		               					</table>
		               				</td>
		               			</tr>
		               		</table>
		               		<hr/>
		                </div>
		                <div style="margin-left: 80px;">
		               		<table>
		               			<tr>
		               				<td class="align-top">
		               					<div class="img-profile">본사 로고</div>
		               				</td>
		               				<td class="w-100">
		               					<table class="w-100">
		               						<tr><td><b style="color: rgb(37, 57, 111);">관리자</b> 2024.01.01 10:00</td></tr>
		               						<tr><td>관리자의 댓글...</td></tr>
		               						<tr class="text-end"><td><a data-bs-toggle="collapse" href="#collapseReply2" aria-expanded="false" aria-controls="collapseReply2">답글</a></td></tr>
		               						<tr>
		               							<td>
		               								<form class="collapse mt-2" id="collapseReply2">
								                    	<textarea class="comment" rows="3" placeholder="관리자에게 답글을 작성..."></textarea>
								                    	<table class="w-100">
								                    		<tr>
								                    			<td style="background-color: rgb(245, 245, 245);">0/500</td>
								                    			<td style="text-align: center; width: 50px; background-color: rgb(230, 230, 230); cursor: pointer;" onclick="location.href='#'">입력</td>
								                    		</tr>
								                    	</table>
								                    </form>
		               							</td>
		               						</tr>
		               					</table>
		               				</td>
		               			</tr>
		               		</table>
		               		<hr/>
		                </div>
		                <div style="margin-left: 80px;">
		               		<table>
		               			<tr>
		               				<td class="align-top">
		               					<div class="img-profile">프로필 사진</div>
		               				</td>
		               				<td class="w-100">
		               					<table class="w-100">
		               						<tr><td><b>매니저B</b> 2024.01.01 10:00</td></tr>
		               						<tr><td><b>@관리자</b> 매니저B의 댓글...</td></tr>
		               						<tr class="text-end"><td><a href="#">삭제</a> <a href="#">수정</a> <a data-bs-toggle="collapse" href="#collapseReply3" aria-expanded="false" aria-controls="collapseReply3">답글</a></td></tr>
		               						<tr>
		               							<td>
		               								<form class="collapse mt-2" id="collapseReply3">
								                    	<textarea class="comment" rows="3" placeholder="매니저B에게 답글을 작성..."></textarea>
								                    	<table class="w-100">
								                    		<tr>
								                    			<td style="background-color: rgb(245, 245, 245);">0/500</td>
								                    			<td style="text-align: center; width: 50px; background-color: rgb(230, 230, 230); cursor: pointer;" onclick="location.href='#'">입력</td>
								                    		</tr>
								                    	</table>
								                    </form>
		               							</td>
		               						</tr>
		               					</table>
		               				</td>
		               			</tr>
		               		</table>
		               		<hr/>
		                </div>
		                <div style="margin-left: 80px;">
		               		<table>
		               			<tr>
		               				<td class="align-top">
		               					<div class="img-profile">본사 로고</div>
		               				</td>
		               				<td class="w-100">
		               					<table class="w-100">
		               						<tr><td><b style="color: rgb(37, 57, 111);">관리자</b> 2024.01.01 10:00</td></tr>
		               						<tr><td><b>@매니저B</b> 관리자의 댓글...<br>관리자의 댓글...<br>관리자의 댓글...<br>관리자의 댓글...</td></tr>
		               						<tr class="text-end"><td><a data-bs-toggle="collapse" href="#collapseReply4" aria-expanded="false" aria-controls="collapseReply4">답글</a></td></tr>
		               						<tr>
		               							<td>
		               								<form class="collapse mt-2" id="collapseReply4">
								                    	<textarea class="comment" rows="3" placeholder="관리자에게 답글을 작성..."></textarea>
								                    	<table class="w-100">
								                    		<tr>
								                    			<td style="background-color: rgb(245, 245, 245);">0/500</td>
								                    			<td style="text-align: center; width: 50px; background-color: rgb(230, 230, 230); cursor: pointer;" onclick="location.href='#'">입력</td>
								                    		</tr>
								                    	</table>
								                    </form>
		               							</td>
		               						</tr>
		               					</table>
		               				</td>
		               			</tr>
		               		</table>
		               		<hr/>
		                </div>
		                <div>
		               		<table>
		               			<tr>
		               				<td class="align-top">
		               					<div class="img-profile">프로필 사진</div>
		               				</td>
		               				<td class="w-100">
		               					<table class="w-100">
		               						<tr><td><b>매니저B</b> 2024.01.01 10:00</td></tr>
		               						<tr><td>매니저B의 댓글...</td></tr>
		               						<tr class="text-end"><td><a data-bs-toggle="collapse" href="#collapseReply5" aria-expanded="false" aria-controls="collapseReply5">답글</a></td></tr>
		               						<tr>
		               							<td>
		               								<form class="collapse mt-2" id="collapseReply5">
								                    	<textarea class="comment" rows="3" placeholder="매니저B에게 답글을 작성..."></textarea>
								                    	<table class="w-100">
								                    		<tr>
								                    			<td style="background-color: rgb(245, 245, 245);">0/500</td>
								                    			<td style="text-align: center; width: 50px; background-color: rgb(230, 230, 230); cursor: pointer;" onclick="location.href='#'">입력</td>
								                    		</tr>
								                    	</table>
								                    </form>
		               							</td>
		               						</tr>
		               					</table>
		               				</td>
		               			</tr>
		               		</table>
		               		<hr/>
		                </div>
		                -->
                </section>
	            <footer>
				    <div class="footer clearfix mb-0 text-muted">
				        <div class="float-start">
				            <p>2024 &copy; ACORN</p>
				        </div>
				        <div class="float-end">
				            <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a href="#main">거니네조</a></p>                                
				        </div>
				    </div>
				</footer>
	        </div>
	    </div>
	</div>
    <script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
    <script src="assets/js/comment.js"></script>
</body>

</html>