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
    <title>회원 정보 수정</title>
    
    <style>
        .div {
            padding-left: 55px;
        }
        .form, textarea, select {
            width: 80%;
            border-radius: 5px;
            border: solid rgb(228, 228, 228) 2px;
            font-family: "맑은고딕", Malgun Gothic;
            margin-top: 8px;
        }
        .form {
            height: 25px;      
        }
        textarea {
            height: 150px;
        }
        button {
            background-color: rgb(42, 105, 241);
            color: white;
            border: none;
            border-radius: 5px;
            height: 25px;
            width: auto;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%
    String customer_id = request.getParameter("customer_id");
    
    String customer_name = null;
    String customer_gender = null;
    String customer_tel = null;
    String customer_mail = null;
    String customer_reg = null;
    String customer_rank = null;
    String customer_note = null;
    
    Context context = null;
    DataSource dataSource = null;

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        context = new InitialContext();
        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        connection = dataSource.getConnection();

        // DB에서 정보를 가져오기 위한 SQL 쿼리
        String sql = "SELECT * FROM customer WHERE customer_id=?";
        
        statement = connection.prepareStatement(sql);
        statement.setString(1, customer_id); 
        
        resultSet = statement.executeQuery();
        
        if (resultSet.next()) {
            customer_name = resultSet.getString("customer_name");
            customer_gender = resultSet.getString("customer_gender");
            customer_tel = resultSet.getString("customer_tel");
            customer_mail = resultSet.getString("customer_mail");
            customer_reg = resultSet.getString("customer_reg");
            customer_rank = resultSet.getString("customer_rank");
            customer_note = resultSet.getString("customer_note");
        }
    } 
    catch(Exception err) {
        System.out.println("customerUpdate.jsp : " + err);
    } 
    finally {
        if(resultSet != null) resultSet.close();
        if(statement != null) statement.close();
        if(connection != null) connection.close();
    }
%>

<div class="div">
    <h2>회원 정보 수정</h2>
    <form method="post" action="customerUpdateProc.jsp" accept-charset="UTF-8">
    <input type="hidden" name="customer_id" value="<%=customer_id%>" /> 
        <div>
            <label>이름</label>
            <br><input type="text" class="form" name="customer_name" value="<%=customer_name%>" placeholder="이름을 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>성별</label>
            <div class="search-filter">
                <select class="form" name="customer_gender">
                    <option value="남자" <%= "남자".equals(customer_gender) ? "selected" : "" %>>남자</option>
                    <option value="여자" <%= "여자".equals(customer_gender) ? "selected" : "" %>>여자</option>
                </select>
            </div>
        </div>
        <br>
        <div>
            <label>연락처</label>
            <br><input type="text" class="form" name="customer_tel" value="<%=customer_tel%>" placeholder="연락처를 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>이메일</label>
            <br><input type="text" class="form" name="customer_mail" value="<%=customer_mail%>" placeholder="이메일을 입력해 주세요.">
        </div>
        <br>
        <div>
            <label>회원 등록일</label>
            <br><input type="date" class="form" name="customer_reg" value="<%=customer_reg%>" readonly>
        </div>
        <br>
        <div>
            <label>회원 등급</label>
            <div class="search-filter">
                <select class="form" name="customer_rank">
                    <option value="GOLD" <%= "GOLD".equals(customer_rank) ? "selected" : "" %>>GOLD</option>
                    <option value="SILVER" <%= "SILVER".equals(customer_rank) ? "selected" : "" %>>SILVER</option>
                    <option value="BRONZE" <%= "BRONZE".equals(customer_rank) ? "selected" : "" %>>BRONZE</option>
                </select>
            </div>
        </div>
        <br>
        <div>
            <label>특이사항</label>
            <br><input type="text" class="form" name="customer_note" value="<%=customer_note%>" placeholder="특이사항을 입력해 주세요.">
        </div>
        <br>
        <div class="button-container">
            <button type="submit" onclick="alert('수정 되었습니다.')">수정 완료</button>
            <button type="button" onclick="location.href='customer.jsp'">목록</button>
        </div>
    </form>
</div>
</body>
</html>
