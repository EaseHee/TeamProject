<%@ page import="java.sql.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.*, java.util.Set, java.util.HashSet"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="assets/css/page.css">

</head>
<script>
	function check() {
		if(document.search.keyWord.value == "") {
			document.search.keyWord.focus();
			return;
		}
		
		document.search.submit();
	}
	
	function addProduct() {
		var product_B_code = '<%=request.getParameter("product_B_code")%>';
		window.location.href = 'product_add.jsp?product_B_code=' + product_B_code;
	}
</script>
<body>
	<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.ProductDTO"></jsp:useBean>
	
	<%
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		
		String product_B_code = request.getParameter("product_B_code");
		
		//검색어 받기
		String keyWord = request.getParameter("keyWord");
		
		//페이징에 필요한 변수
		int totalcnt = 0;     //총 글의 개수
		int numPerPage = 10;  //한 페이지당 보여질 글의 개수
		int totalPage = 0;    //총 페이지 수
		int nowPage = 0;      //현재 선택된 페이지
		int beginPerPage = 0; //페이지별 시작번호(중요!) EX) 1,11,21
		int pagePerBlock = 5; //블럭당 페이지 수
		int totalBlock = 0;   //총 블럭 수
		int nowBlock = 0;     //현재 블럭
		
		if(request.getParameter("nowBlock") != null) {
            nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
        }
		
		if (product_B_code != null && !product_B_code.isEmpty()) {
			ArrayList<ProductDTO> list = (ArrayList<ProductDTO>) prodDAO.getProductList(product_B_code, keyWord);
			
			prodDAO.getProductList(product_B_code, keyWord);
			
			totalcnt = list.size();
			
			totalPage = (int)Math.ceil((double)totalcnt / numPerPage); // 페이지 개수 구하기

	        if(request.getParameter("nowPage") != null) {
	            nowPage = Integer.parseInt(request.getParameter("nowPage"));
	        }

	        // 페이지당 시작번호
	        beginPerPage = nowPage * numPerPage;

	        totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
	        
	        if(request.getParameter("nowBlock") != null) {
	            nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	        }
	%>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
	                <div class="row form-group">
					    <form method="get" action="product_detail.jsp?product_B_code=<%=product_B_code%>" class="col-4 d-flex align-items-end" accept-charset="UTF-8">
				        	<input type="hidden" name="product_B_code" value="<%=request.getParameter("product_B_code") %>"/>
					        <input type="text" name="keyWord" placeholder="상품명으로 조회" class="form-control" value="<%= keyWord != null ? keyWord : "" %>">
					        <input type="submit" class="btn btn-outline-success" onclick="check()" value="조회">
					    </form>
					    <form class="col-4 d-flex"></form>
					    <form class="col-4  d-flex justify-content-end align-items-end">
							<a href="#" onclick="addProduct()" class="btn btn-outline-success" style="margin-right: 0px;">등록</a>
						</form>
					</div>

	                <section class="section">
	                    <div class="row" id="table-hover-row">
	                        <div class="col-12">
	                            <div class="card">
	                                <div class="card-content">
	                                    <div class="table-responsive">
	                                        <table class="table table-hover mb-0" id="productTable">
	                                            <thead>
	                                                <tr>
	                                                    <th class="text-center" width="10%">상품코드</th>
	                                                    <th class="text-center" width="70%">상품명</th>
	                                                    <th class="text-center" width="10%">상품 가격</th>
	                                                    <th class="text-center" width="10%">상품 수량</th>
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                            	<%
	                                            		for(int i=beginPerPage; i < beginPerPage + numPerPage && i < totalcnt; i++) {
	                                            			board = list.get(i);
	                                            	%>
	                                            		<tr>
		                                                    <td class="text-bold-500 text-center"><%=board.getProduct_code() %></td>
		                                                    <td class="text-bold-500"><a href="product_read.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&product_code=<%= board.getProduct_code() %>"><%=board.getProduct_name()%></a></td>
		                                                    <td class="text-bold-500 text-center"><fmt:formatNumber value="<%=board.getProduct_price() %>"/></td>
		                                                    <td class="text-bold-500 text-center"><fmt:formatNumber value="<%=board.getProduct_ea() %>"/></td>
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
	                    <div class="row">
	                    	<div class="col-6 d-flex justify-content-start align-items-center">
	                    		<span class="badges badge bg-primary">상품 종류 : <%= list.size() %>개</span>	
	                    	</div>
	                    	<div class="col-6 d-flex justify-content-end">
	                    		<div id="excel_export" class="buttons d-flex justify-content-end align-items-end">
								<button onclick="downloadExcel()" class="btn btn-outline-warning btn-excel">엑셀 다운로드</button>
							</div>	
	                    	</div>
	                    </div>
	                    
	                    
	                    <div class="col-12 d-flex justify-content-center align-items-center">
							<nav aria-label="Page navigation example">
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
										<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=(nowBlock-1)*pagePerBlock%>&nowBlock=<%=nowBlock - 1 %>&keyWord=<%=keyWord != null ? keyWord : ""%>">
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
												<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>&keyWord=<%=keyWord != null ? keyWord : ""%>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
											</li>
								<%	
										}
									}else{
										if(totalPage%pagePerBlock !=0 ){
											for(int i=0; i < totalPage%pagePerBlock; i++){
											%>
												<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
													<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>&keyWord=<%=keyWord != null ? keyWord : ""%>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
												</li>
											<%
											}
										}else{
											for(int i=0; i < pagePerBlock; i++){
											%>
												<li class="page-item <%= (i == nowPage % pagePerBlock) ? "active" : "" %>">
													<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=nowBlock*pagePerBlock + i%>&nowBlock=<%=nowBlock %>&keyWord=<%=keyWord != null ? keyWord : ""%>" ><%=(nowBlock*pagePerBlock + i + 1) %></a>
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
										<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=(nowBlock + 1)*pagePerBlock%>&nowBlock=<%=nowBlock + 1 %>&keyWord=<%=keyWord != null ? keyWord : ""%>">
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
							</nav>
						</div>
	                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
	<%
        } else {
        	response.sendRedirect("product.jsp");
        }
    %>
    <script>
	    function downloadExcel() {
	    	
	    	var productData = [ //자바 객체 데이터를 jsp 배열로 변환
	    		<% 
    			//productDAO에서 getProductList() 메서드를 호출 > 모든 상품을 가져옴
    			//prodDAO.getProductList(product_B_code, keyWord) > java.util.ArrayList
    			ArrayList<ProductDTO> productList = (ArrayList<ProductDTO>) prodDAO.getProductList(product_B_code, keyWord);
    			Set<ProductDTO> products = new HashSet<>(productList);
    			
    			for(ProductDTO product : products) {%>{
    				product_code : '<%=product.getProduct_code()%>',
    				product_name : '<%=product.getProduct_name()%>',
    				product_price : '<%=product.getProduct_price()%>',
    				product_ea : '<%=product.getProduct_ea()%>'
    			},
    		<%}%>
	    	];
	    	
	        var wb = XLSX.utils.book_new(); //엑셀 파일 생성 함수
	        var ws_data = [['상품코드', '상품명', '상품 가격', '상품 수량']]; //엑셀 행
	        
	        //데이터를 행별로 추가
	        productData.forEach(function(product) {
	        		ws_data.push([product.product_code, product.product_name, product.product_price, product.product_ea]);
	        });
	        
	        var ws = XLSX.utils.aoa_to_sheet(ws_data); //ws_data 배열을 엑셀 시트로 변환
	        XLSX.utils.book_append_sheet(wb, ws, '상품 관리'); //엑셀에 변환한 시트를 추가하는 함수
	        
	        //엑셀 파일 저장
	        XLSX.writeFile(wb, '상품_관리.xlsx');
	    }
	</script>
</body>
</html>