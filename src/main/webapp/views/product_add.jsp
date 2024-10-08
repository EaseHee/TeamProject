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
    <title>상품 등록</title>
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
	<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.ProductDTO"></jsp:useBean>
	
	<%
		String product_B_code = request.getParameter("product_B_code");
	%>

    <div id="app">
<jsp:include page="/views/header.jsp" ></jsp:include>
	                <section class="section">
                    <form method="post" action="product_addProc.jsp" id="">
                    	<input type="hidden" name="product_B_code" value="<%=request.getParameter("product_B_code") %>"/>
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">상품 코드</span>
                                    <input type="text" class="form-control" name="product_code" placeholder="상품 코드를 입력해 주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">상품명</span>
                                    <input type="text" class="form-control" name="product_name" placeholder="상품명을 입력해주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">가격</span>
                                    <input type="number" class="form-control" name="product_price" placeholder="가격 입력해주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">수량</span>
                                    <input type="number" class="form-control" name="product_ea" placeholder="수량을 입력해주세요">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                                <button type="button" onclick="location.href='product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>'">목록</button>
                                <button type="submit" onclick="등록되었습니다.">등록</button>
                            </div>
                        </div>
                    </form>
                </section>
                <br><br><br>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>

</html>