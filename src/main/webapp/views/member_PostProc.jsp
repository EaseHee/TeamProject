<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date, java.sql.Time, bean.MemberDTO, bean.MemberDAO" %>

<jsp:useBean id="memberDao" class="bean.MemberDAO"/>
<jsp:useBean id="memberDto" class="bean.MemberDTO"/>
<!--
<%--jsp:useBean id="branchDto" class="bean.BranchDTO"/--%> 
-->

<!-- 
    request.setCharacterEncoding("UTF-8");

	String branch_no = request.getParameter("branch_no");
	String member_id = request.getParameter("member_id");
	String member_name = request.getParameter("member_name");
	String member_job = request.getParameter("member_job");
	String member_date = request.getParameter("member_date");
	String member_tel = request.getParameter("member_tel");
	
	branchDto.setBranch_id(branch_no);
	memberDto.setMember_id(member_id);
	memberDto.setMember_name(member_name);
	memberDto.setMember_job(member_job);
	memberDto.setMember_date(member_date);
	memberDto.setMember_tel(member_tel);
	
	memberDao.setMemberDTO(memberDto);
	
	response.sendRedirect("member.jsp");	
-->

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:setProperty property="*" name="memberDto"/>

<%
	memberDao.setMemberDTO(memberDto);
	response.sendRedirect("member.jsp");
%>