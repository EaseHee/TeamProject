<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");

    // 수정할 회원 정보
    String customer_id = request.getParameter("customer_id");
    
    String customer_name = request.getParameter("customer_name");
    String customer_gender = request.getParameter("customer_gender");
    String customer_tel = request.getParameter("customer_tel");
    String customer_mail = request.getParameter("customer_mail");
    String customer_rank = request.getParameter("customer_rank");
    String customer_note = request.getParameter("customer_note");

    Context context = null;
    DataSource dataSource = null;

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        context = new InitialContext();
        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        connection = dataSource.getConnection();

        // 회원 정보 수정
        String sql = "UPDATE customer SET customer_name=?, customer_gender=?, customer_tel=?, customer_mail=?, customer_rank=?, customer_note=? WHERE customer_id=?";
        statement = connection.prepareStatement(sql);
        
        statement.setString(1, customer_name);
        statement.setString(2, customer_gender);
        statement.setString(3, customer_tel);
        statement.setString(4, customer_mail);
        statement.setString(5, customer_rank);
        statement.setString(6, customer_note);
        statement.setString(7, customer_id);
        
        int rowsUpdated = statement.executeUpdate();
        
        // 수정이 완료되면 customer.jsp로 리다이렉트
        response.sendRedirect("customer.jsp");
    } 
    catch (Exception err) {
        err.printStackTrace(); // 오류를 콘솔에 출력
    } 
    finally {
       
    }
%>
