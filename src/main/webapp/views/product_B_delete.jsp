<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
		 
<jsp:useBean id="prodDAO" class="bean.ProductDAO" />

<%
	//대분류 가져오기
	String product_B_code = request.getParameter("product_B_code");

	if (product_B_code != null && !product_B_code.isEmpty()) {
		try {
			prodDAO.deleteBProduct(product_B_code);
			response.sendRedirect("product.jsp");
		} catch(Exception e) {
			out.println("삭제 중 오류가 발생했습니다: " + e.getMessage());
			e.printStackTrace();
		}
	} else {
		out.println("대분류 코드가 누락되었습니다.");
	}
%>