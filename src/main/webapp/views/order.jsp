<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>



<body>
	<jsp:useBean id="orderDao" class="bean.OrderDAO"></jsp:useBean>
	<% 
		ArrayList<OrderDTO> list = (ArrayList<OrderDTO>)orderDao.getProduct_B_List();		
	%>
	<h2>발주 페이지</h2>
	
    <select id="Bsort">
    <%
    	for(OrderDTO board : list){
    %>
        <option value="<%=board.getProduct_B_code()%>"><%= board.getProduct_name() %></option>
    <%
    	}
    %>
    </select>
	<button onclick="chooseBsort()">검색</button>	    
    
    <div id="orderlist"></div>
</body>
<script src="/TeamProject/views/assets/js/order.js"></script>
</html>