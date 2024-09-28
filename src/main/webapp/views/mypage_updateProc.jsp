<%@page import="bean.MypageDAO"%>
<%@page import="bean.MypageDTO"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String branchcode = request.getParameter("branchcode");
    String name = request.getParameter("name");
    String tel = request.getParameter("tel");
    String email = request.getParameter("email");

    MypageDTO dto = new MypageDTO();
    dto.setBranch_code(branchcode);
    dto.setManager_name(name);
    dto.setManager_tel(tel);
    dto.setManager_mail(email);

    MypageDAO dao = new MypageDAO();
    dao.updateManager(dto);

    response.sendRedirect("mypage_view.jsp");
%>