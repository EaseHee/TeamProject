<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보</title>
    
    <style>
         body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        h1 {
            font-size: 36px;
            margin: 20px 0;
            border-bottom: 2px solid black;
        }
        table {
            width: 70%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>회원 정보</h1>
    
    <table>
        <tr>
            <th>회원 ID</th>
            <td><%= request.getParameter("cus_id") %></td>
        </tr>
        <%
            String cus_id = request.getParameter("cus_id");
            
	        final String URL = "jdbc:mariadb://svc.sel4.cloudtype.app:32217/acorn";
	        final String ID = "root";
	        final String PW = "1820";
            
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(URL, ID, PW);
                
                String sql = "SELECT * FROM cus WHERE cus_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(cus_id));
                
                rs = stmt.executeQuery();
                
                if (rs.next()) {
        %>
        <tr>
            <th>이름</th>
            <td><%= rs.getString("cus_name") %></td>
        </tr>
        <tr>
            <th>성별</th>
            <td><%= rs.getString("cus_gender") %></td>
        </tr>
        <tr>
            <th>연락처</th>
            <td><%= rs.getString("cus_ph") %></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><%= rs.getString("cus_mail") %></td>
        </tr>
        <tr>
            <th>회원 등급</th>
            <td><%= rs.getString("cus_rank") %></td>
        </tr>
        <tr>
            <th>특이사항</th>
            <td><%= rs.getString("cus_note") %></td>
        </tr>
        <%
                } 
        %>
        
        <%
                
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
    <br>
    <div class="button-container">
		<button type="button" onclick="location.href='customer.jsp'">목록</button>
		<button type="button" onclick="location.href='cusUpdate.jsp?cus_id=<%= cus_id %>'">수정</button>
		<button type="button" onclick="location.href='cusDelete.jsp?cus_id=<%=cus_id%>'">삭제</button>
    </div>
</div>

</body>
</html>
