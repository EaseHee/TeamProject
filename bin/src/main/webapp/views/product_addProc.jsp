<%@ page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
<jsp:useBean id="product" class="bean.ProductDTO"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");

	String product_B_code = request.getParameter("product_B_code");
	String product_code = request.getParameter("product_code");
	String product_name = request.getParameter("product_name");
	int product_price = Integer.parseInt(request.getParameter("product_price"));
	int product_ea = Integer.parseInt(request.getParameter("product_ea"));
%>

<!-- setProperty 안의 속성인 param에는 product_B_add.jsp에서 name을 보고 가져오는데, property와 param의 이름이 동일하면 생략 가능 -->

<jsp:setProperty name="product" property="product_B_code" />
<jsp:setProperty name="product" property="product_code" />
<jsp:setProperty name="product" property="product_name" />
<jsp:setProperty name="product" property="product_price" />
<jsp:setProperty name="product" property="product_ea" />

<%
    // DAO를 사용하여 데이터베이스에 저장
	prodDAO.setProductOne(product);

	String redirectURL = "product_detail.jsp?product_B_code=" + product_B_code;
	response.sendRedirect(redirectURL);
%>