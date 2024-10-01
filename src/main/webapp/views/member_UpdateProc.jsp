<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date, java.sql.Time, bean.MemberDTO, bean.MemberDAO" %>

<jsp:useBean id="memberDao" class="bean.MemberDAO"/>
<jsp:useBean id="memberDto" class="bean.MemberDTO"/>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:setProperty property="*" name="memberDto"/>

<%
	memberDao.updateMemberDTO(memberDto);
	response.sendRedirect("member.jsp");
%>