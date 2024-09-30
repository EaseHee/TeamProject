<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date, java.sql.Time, bean.ReservationDTO, bean.ReservationDAO" %>

<jsp:useBean id="dao" class="bean.ReservationDAO"/>
<jsp:useBean id="dto" class="bean.ReservationDTO"/>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:setProperty property="*" name="dto"/>

<%
	dao.updateReservationDTO(dto);
	response.sendRedirect("reservation.jsp");
%>