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
	<link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">

</head>
<body>
	<jsp:useBean id="noticeDAO" class="bean.NoticeDAO"></jsp:useBean>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
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
	                            <div class="bg-white rounded-3 p-5"><%=noticeDTO.getNotice_content()%></div>
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
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>