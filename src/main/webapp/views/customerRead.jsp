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
        <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
   <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">
   <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">    

 
</head>
<body>

    <div id="app">
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
	<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="reservationPostProc.jsp">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">지점 코드</span>
									<input type="text" class="form-control" value="B001" readonly="readonly">
									<!-- 지점 테이블 생성 필요 branch -->
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">회원 ID</span> 
									<input type="text" class="form-control" value="<%= request.getParameter("customer_id") %>"  readonly="readonly" />
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">이름</span>
                                    <input type="text" class="form-control" value="<%= resultSet.getString("customer_name") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>							
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">성별</span>
                                    <input type="text" class="form-control" value="<%= resultSet.getString("customer_gender") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">전화 번호</span>
                                    <input type="date" class="form-control" value="<%= resultSet.getString("customer_tel") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">이메일</span>
                                    <input type="text" class="form-control" value="<%= resultSet.getString("customer_mail") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">회원등록일</span>
                                    <input type="text" class="form-control" value="<%= resultSet.getString("customer_reg") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">회원 등급</span>
                                    <input type="text" class="form-control" value="<%= resultSet.getString("customer_rank") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">특이사항</span>
                                    <input type="text" class="form-control" value="<%= resultSet.getString("customer_note") %>" readonly="readonly" />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                                <button type="button" onclick="location.href='customer.jsp'">목록</button>
								<button type="button" onclick="location.href='customerUpdate.jsp?customer_id=<%= customer_id %>'">수정</button>
								<button type="button" onclick="location.href='customerDelete.jsp?customer_id=<%=customer_id%>'">삭제</button>
                            </div>
                        </div>
       <%
                }                
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
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>

</body>

</html>
