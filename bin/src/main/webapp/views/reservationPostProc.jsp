<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date, java.sql.Time, bean.ReservationDTO, bean.ReservationDAO" %>

<jsp:useBean id="dao" class="bean.ReservationDAO"/>
<jsp:useBean id="dto" class="bean.ReservationDTO"/>
<%--
    request.setCharacterEncoding("UTF-8");

	int res_no = Integer.parseInt(request.getParameter("b_res_no"));
	String ser_name = request.getParameter("b_ser_name");
	Date res_date = Date.valueOf(request.getParameter("b_res_date"));
	Date res_time = Date.valueOf(request.getParameter("b_res_time"));
	String cus_name = request.getParameter("b_cus_name");
	String res_comm = request.getParameter("b_res_comm");
	
	dto.setRes_no(res_no);
	dto.setSer_name(ser_name);
	dto.setRes_date(res_date);
	dto.setRes_time(res_time);
	dto.setCus_name(cus_name);
	dto.setRes_comm(res_comm);
	
	dao.setReservationDTO(dto);
	
	response.sendRedirect("reservation.jsp");
	
--%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:setProperty property="*" name="dto"/>

<%
	dao.setReservationDTO(dto);
	response.sendRedirect("reservation.jsp");
%>