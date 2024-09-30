<%@page import="bean.ProductDTO"%>
<%@page import="bean.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<jsp:useBean id="prodDAO" class="bean.ProductDAO" />
<jsp:useBean id="product" class="bean.ProductDTO" />

<%
	request.setCharacterEncoding("UTF-8");

	String product_B_code = request.getParameter("product_B_code");
	String product_code = request.getParameter("product_code");
	String product_name = request.getParameter("product_name");
	int product_price = Integer.parseInt(request.getParameter("product_price"));
	int product_ea = Integer.parseInt(request.getParameter("product_ea"));
	
	product.setProduct_B_code(product_B_code);
	product.setProduct_code(product_code);
	product.setProduct_name(product_name);
	product.setProduct_price(product_price);
	product.setProduct_ea(product_ea);
	
	prodDAO.updateProductOne(product);
	response.sendRedirect("product_detail.jsp?product_B_code=" + product_B_code);
		
	
%>