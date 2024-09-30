<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="bean.MemberDAO" />
<jsp:useBean id="memberDto" class="bean.MemberDTO" />
<%
	String member_id = request.getParameter("member_id");

	memberDao.deleteMemberDTO(member_id);
	response.sendRedirect("member.jsp");
%>
