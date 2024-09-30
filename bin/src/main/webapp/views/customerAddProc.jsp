<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 폼에서 전달된 데이터 받기
    request.setCharacterEncoding("utf-8");
    String customer_id = request.getParameter("customer_id"); // 회원 ID
    String customer_name = request.getParameter("customer_name");
    String customer_gender = request.getParameter("customer_gender");
    String customer_tel = request.getParameter("customer_tel");
    String customer_mail = request.getParameter("customer_mail");
    String customer_reg = request.getParameter("customer_reg");
    String customer_rank = request.getParameter("customer_rank");
    String customer_note = request.getParameter("customer_note");

    Context context = null;
    DataSource dataSource = null;

    Connection connection = null;
    PreparedStatement statement = null;
    
    try {
        context = new InitialContext();
        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        connection = dataSource.getConnection();
        
        String sql = "INSERT INTO customer (customer_id, customer_name, customer_gender, customer_tel, customer_mail, customer_reg, customer_rank, customer_note) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
        // PreparedStatement 생성 및 값 설정
        statement = connection.prepareStatement(sql);
        statement.setInt(1, Integer.parseInt(customer_id)); // cus_id를 정수로 변환하여 설정
        statement.setString(2, customer_name);
        statement.setString(3, customer_gender);
        statement.setString(4, customer_tel);
        statement.setString(5, customer_mail);
        statement.setString(6, customer_reg);
        statement.setString(7, customer_rank);
        statement.setString(8, customer_note);
        
        // SQL 쿼리 실행
        statement.executeUpdate();
        
        // 회원 목록 페이지로 리다이렉션
        response.sendRedirect("customer.jsp");

    } catch(Exception err) {
        // 에러 발생 시 콘솔에 출력
        err.printStackTrace();
    } finally {
        // 리소스 해제
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
