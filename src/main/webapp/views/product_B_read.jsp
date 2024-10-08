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
    <title>상품 상세</title>
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
	function confirmDelete(product_B_code) {
		if(confirm("정말로 삭제하시겠습니까?")) {
            location.href = "product_B_delete.jsp?product_B_code=" + encodeURIComponent(product_B_code);
		}
	}
</script>
<body>
	<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
	                <section class="section">
	                <%
		            	//대분류 코드 받아오기
		            	String product_B_code = request.getParameter("product_B_code");
	
	                	if(product_B_code != null && !product_B_code.isEmpty()) {
		            		ProductDTO board = prodDAO.getProductBOne(product_B_code);
	                %>
                    <form method="post">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">상품 코드</span>
                                    <input type="text" class="form-control" name="product_B_code" value="<%=board.getProduct_B_code() %>" readonly="readonly">
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
                            <div class="button-container">
                            	<button type="button" onclick="location.href='product.jsp'">목록</button>
                                <button type="button" onclick="confirmDelete('<%=board.getProduct_B_code() %>')">삭제</button>
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