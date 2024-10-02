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
    <title>Notice</title>
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
				                    	<button onclick="location.href='notice_view.jsp?notice_no=<%=previousNotice.getNotice_no()%>'">이전</button>
		                    	<%
		                    		} else {
		                    	%>		<!-- 자리만 차지하고 있는 버튼 -->
		                    			<button disabled aria-disabled="true" style="visibility: hidden;">이전</button>
		                    	<%
		                    		}
		                    	%>
                    			<button onclick="location.href='notice_list.jsp'">목록</button>
                    			<%
									if(nextNotice.getNotice_no() != 0){
								%>		<!-- 다음 게시글이 있을 때에만 보이는 버튼 -->
										<button onclick="location.href='notice_view.jsp?notice_no=<%=nextNotice.getNotice_no()%>'">다음</button>
								<%
									} else {
								%>		<!-- 자리만 차지하고 있는 버튼 -->
										<button disabled aria-disabled="true" style="visibility: hidden;">다음</button>
								<%
									}
								%>
		                    </div>
		                </div>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>