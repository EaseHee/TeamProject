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
    <title>Product</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">

</head>
<script>
	function confirmDelete(product_B_code, product_code) {
		if(confirm("정말로 삭제하시겠습니까?")) {
			location.href= "product_delete.jsp?product_B_code=" + encodeURIComponent(product_B_code) + "&product_code=" + encodeURIComponent(product_code);
		}
	}
</script>
<body>
	<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.ProductDTO"></jsp:useBean>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
	                <section class="section">
	                <%
		            	//대분류, 소분류 받기
		        		String product_B_code = request.getParameter("product_B_code");
		        		String product_code = request.getParameter("product_code");
	
		        		if(product_B_code != null && !product_B_code.isEmpty() && product_code != null && !product_code.isEmpty()) {
		            		board = prodDAO.getProductOne(product_B_code, product_code);
	                %>
                    <form method="post">
                    	<input type="hidden" name="product_B_code" value="<%=request.getParameter("product_B_code") %>"/>
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">상품 코드</span>
                                    <input type="text" class="form-control" name="product_code" value="<%=board.getProduct_code() %>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">상품명</span>
                                    <input type="text" class="form-control" name="product_name" value="<%=board.getProduct_name() %>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">가격</span>
                                    <input type="text" class="form-control" name="product_price" value="<%=board.getProduct_price() %>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">수량</span>
                                    <input type="text" class="form-control" name="product_ea" value="<%=board.getProduct_ea() %>" readonly="readonly">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                                <button type="button" onclick="location.href='product_update.jsp?product_B_code=<%=board.getProduct_B_code()%>&product_code=<%=board.getProduct_code()%>'">수정</button>
                                <button type="button" onclick="confirmDelete('<%=board.getProduct_B_code() %>','<%=board.getProduct_code() %>')">삭제</button>
                                <button type="button" onclick="location.href='product_detail.jsp?product_B_code=<%=board.getProduct_B_code()%>'">목록</button>
                            </div>
                        </div>
                    </form>
                    <%
						} else {
							response.sendRedirect("product.jsp");
						}
					%>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>