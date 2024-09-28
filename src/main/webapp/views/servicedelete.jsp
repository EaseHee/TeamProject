<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bean.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%
// 데이터베이스 연결 설정
ServiceDAO dao = new ServiceDAO();

String service_code = request.getParameter("service_code");
out.println("service_code: " + service_code);

if (service_code != null && !service_code.isEmpty()) {
	try {
		dao.deleteService(service_code);
		response.sendRedirect("service.jsp");
	} catch (Exception e) {
		out.println("삭제 중 오류가 발생했습니다: " + e.getMessage());
		e.printStackTrace();
	}
} else {
	out.println("품목 코드가 누락되었습니다.");
}
%>
