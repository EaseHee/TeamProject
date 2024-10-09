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
    <title>상품 관리</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="assets/css/page.css">

</head>
<body>
	<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.ProductDTO"></jsp:useBean>
	
	<%
		//한글로 받을 수 있기 때문에
		request.setCharacterEncoding("UTF-8");
	
		//검색어 받기
		String keyWord = request.getParameter("keyWord");
		
		//페이징에 필요한 변수
		int totalRecord = 0;     //총 글의 개수
		int numPerPage = 10;  //한 페이지당 보여질 글의 개수
		int totalPage = 0;    //총 페이지 수
		int nowPage = 0;      //현재 선택된 페이지
		int beginPerPage = 0; //페이지별 시작번호(중요!) EX) 1,11,21
		int pagePerBlock = 5; //블럭당 페이지 수
		int totalBlock = 0;   //총 블럭 수
		int nowBlock = 0;     //현재 블럭
		
		ArrayList<ProductDTO> list = (ArrayList<ProductDTO>)prodDAO.getProduct_B_List(keyWord);
		
		totalRecord = list.size();
				
		totalPage = (int)Math.ceil((double)totalRecord / numPerPage); // 페이지 개수 구하기

		totalPage = (int) Math.ceil((double) totalRecord / numPerPage);

		if(request.getParameter("nowPage") != null )
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
			
		beginPerPage = nowPage*numPerPage;
		totalBlock = (totalPage + pagePerBlock - 1)/pagePerBlock;
		
		if(request.getParameter("nowBlock") != null )
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	%>

    <div id="app">
	<jsp:include page="/views/header.jsp" ></jsp:include>
	                <div class="row form-group">
					    <form method="post" action="product.jsp" class="col-4 d-flex align-items-end" accept-charset="UTF-8">
					        <input type="text" name="keyWord" placeholder="상품명으로 조회" class="form-control" value="<%= keyWord != null ? keyWord : "" %>">
					        <input type="submit" class="btn btn-outline-success" value="조회">
					    </form >
					    <form class="col-4 d-flex"></form>
					    <form class="col-4 d-flex justify-content-end align-items-end">
					    	<a href="product_B_add.jsp" class="btn btn-outline-success" style="margin-right: 0px;">등록</a>
					    </form>
					</div>
	                <section class="section">
	                    <div class="row" id="table-hover-row">
	                        <div class="col-12">
	                            <div class="card">
	                                <div class="card-content">
	                                    <div class="table-responsive">
	                                        <table class="table table-hover mb-0">
	                                            <thead>
	                                                <tr>
	                                                    <th class="text-center" width="15%">상품코드</th>
	                                                    <th class="text-center" width="85%">상품명</th>
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                            	
	                                            	<%
	                                            		for(int i=beginPerPage; i < beginPerPage + numPerPage && i < totalRecord; i++){
	                                            			board = list.get(i);
	                                            	%>
	                                            	
	                                                <tr><td class="text-bold-500 text-center"><a href="product_B_read.jsp?product_B_code=<%=board.getProduct_B_code() %>"><%=board.getProduct_B_code() %></a></td>
	                                                    <td class="text-bold-500 text-center"><a href="product_detail.jsp?product_B_code=<%=board.getProduct_B_code() %>"><%=board.getProduct_name() %></a></td>
	                                                </tr>
	                                                <%
	                                            		}
	                                                %>
	                                                
	                                            </tbody>
	                                        </table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-12 d-flex justify-content-center align-items-center">
							<ul class="pagination pagination-primary">
								<%
									if(0 == nowBlock ){
								%>
									<li class="page-item disabled">
										<a class="page-link" href="#">
											<span aria-hidden="true">
												<i class="bi bi-chevron-left">
												</i>
											</span>
										</a>
									</li>
								<%
									}else {
								%>
									<li class="page-item">
										<a class="page-link" href="product.jsp?nowPage=<%=(nowBlock-1)*pagePerBlock%>&nowBlock=<%=nowBlock - 1 %>&keyWord=<%=keyWord != null ? keyWord : ""%>">
											<span aria-hidden="true">
												<i class="bi bi-chevron-left">
												</i>
											</span>
										</a>
									</li>
								<%
									}
									if(nowBlock != totalBlock-1){
										for(int i=0; i < pagePerBlock; i++){
								%>
											<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
												<a class="page-link" href="product.jsp?nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>&keyWord=<%=keyWord != null ? keyWord : ""%>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
											</li>
								<%	
										}
									}else{
										if(totalPage%pagePerBlock !=0 ){
											for(int i=0; i < totalPage%pagePerBlock; i++){
											%>
												<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
													<a class="page-link" href="product.jsp?nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>&keyWord=<%=keyWord != null ? keyWord : ""%>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
												</li>
											<%
											}
										}else{
											for(int i=0; i < pagePerBlock; i++){
											%>
												<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
													<a class="page-link" href="product.jsp?nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>&keyWord=<%=keyWord != null ? keyWord : ""%>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
												</li>
											<%	
											
											}
										}
									}
									if(nowBlock == totalBlock-1){
								%>
									<li class="page-item disabled">
										<a class="page-link" href="#">
											<span aria-hidden="true">
												<i class="bi bi-chevron-right">
												</i>
											</span>
										</a>
									</li>
								<%
									} else{
								%>
									<li class="page-item">
										<a class="page-link" href="product.jsp?nowPage=<%=(nowBlock + 1)*pagePerBlock%>&nowBlock=<%=nowBlock + 1 %>&keyWord=<%=keyWord != null ? keyWord : ""%>">
											<span aria-hidden="true">
												<i class="bi bi-chevron-right">
												</i>
											</span>
										</a>
									</li>
								<%
									}
								%>
							</ul>
						</div>
	                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>