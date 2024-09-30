<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보</title>
    
    <style>
		a {
		    text-decoration: none;  /* 밑줄 없애기 */
		}
		.list-group-item.detail{
			font-size: small;
		}
		.bi-plus-square {
			display: inline-block;
			transform: translateY(2px);
		}
		.bi-person-fill{
			display: inline-block;
			transform: translateY(6px);
			margin-right: 5px;
		}
		.bi-bell-fill{
			display: inline-block;
			transform: translateY(3px);
			margin-right: 5px;
		}
		.bi-box-arrow-right{
			display: inline-block;
			transform: translateY(3px);
		}
    </style>
</head>
<body>

<div class="container">
    <h1>회원 정보</h1>
    
    <table>
        <tr>
            <th>회원 ID</th>
            <td><%= request.getParameter("customer_id") %></td>
        </tr>
        <%
            String customer_id = request.getParameter("customer_id");
            
        Context context = null;
        DataSource dataSource = null;

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();
                
                String sql = "SELECT * FROM customer WHERE customer_id = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(customer_id));
                
                resultSet = statement.executeQuery();
                
                if (resultSet.next()) {
        %>
        <tr>
            <th>이름</th>
            <td><%= resultSet.getString("customer_name") %></td>
        </tr>
        <tr>
            <th>성별</th>
            <td><%= resultSet.getString("customer_gender") %></td>
        </tr>
        <tr>
            <th>연락처</th>
            <td><%= resultSet.getString("customer_tel") %></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><%= resultSet.getString("customer_mail") %></td>
        </tr>
        <tr>
            <th>회원 등록일</th>
            <td><%= resultSet.getString("customer_reg") %></td>
        </tr>
        <tr>
            <th>회원 등급</th>
            <td><%= resultSet.getString("customer_rank") %></td>
        </tr>
        <tr>
            <th>특이사항</th>
            <td><%= resultSet.getString("customer_note") %></td>
        </tr>
        <%
                } 
        %>
        
        <%
                
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
    <br>
    <div class="button-container">
		<button type="button" onclick="location.href='customer.jsp'">목록</button>
		<button type="button" onclick="location.href='customerUpdate.jsp?customer_id=<%= customer_id %>'">수정</button>
		<button type="button" onclick="location.href='customerDelete.jsp?customer_id=<%=customer_id%>'">삭제</button>
    </div>
</div>

</body>
</html>
