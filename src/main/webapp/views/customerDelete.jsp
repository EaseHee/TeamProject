<!-- cusDeleteProc.jsp -->
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 삭제</title>
</head>
<body>
<%
    String cus_id = request.getParameter("customer_id");
    
    if (cus_id != null) {
        Context context = null;
        DataSource dataSource = null;

        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();
            
            // 예약 삭제 db
            String deleteReservationSql = "DELETE FROM reservation WHERE customer_id=?";
            statement = connection.prepareStatement(deleteReservationSql);
            statement.setInt(1, Integer.parseInt(cus_id));
            statement.executeUpdate();

            // 고객 삭제 db
            String deleteCustomerSql = "DELETE FROM customer WHERE customer_id=?";
            statement = connection.prepareStatement(deleteCustomerSql);
            statement.setInt(1, Integer.parseInt(cus_id));
            statement.executeUpdate();
            
            response.sendRedirect("customer.jsp");
        } 
        catch(Exception err) {
            System.out.println("customerDelete.jsp : " + err);
        } 
        finally {
            if(statement != null) statement.close();
            if(connection != null) connection.close();
        }
    } 
%>
	
</body>
</html>
