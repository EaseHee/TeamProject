<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="bean.MemberDAO" />
<jsp:useBean id="memberDto" class="bean.MemberDTO" />
<%
	//사번으로 가져오기 
	String member_id = request.getParameter("member_id");

	if (member_id != null && !member_id.isEmpty()) {
		try{
			memberDao.deleteMemberDTO(member_id);
			response.sendRedirect("member.jsp");
		}
		catch (Exception err) {
			out.println("삭제 중 오류가 발생했습니다. " + err.getMessage());
			err.printStackTrace();
		}
	}
	else { 
		out.println("직원 사번이 누락되었습니다.");
	}
	
%>
