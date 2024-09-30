<%@ page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
<jsp:useBean id="product" class="bean.ProductDTO"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
%>

<!-- setProperty 안의 속성인 param에는 product_B_add.jsp에서 name을 보고 가져오는데, property와 param의 이름이 동일하면 생략 가능 -->

<jsp:setProperty name="product" property="product_B_code" />
<jsp:setProperty name="product" property="product_name" />

<%
	prodDAO.setBProduct(product);
	response.sendRedirect("product.jsp");
%>