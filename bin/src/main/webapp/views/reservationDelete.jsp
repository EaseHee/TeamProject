<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<jsp:useBean id="resDao" class="bean.ReservationDAO" />
<jsp:useBean id="resDto" class="bean.ReservationDTO" />
<%
	int reservation_no = Integer.parseInt(request.getParameter("reservation_no"));
	//String ser_code = request.getParameter("ser_code");

	resDao.deleteReservationDTO(reservation_no);
	response.sendRedirect("reservation.jsp");
%>