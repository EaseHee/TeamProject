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
<title>고객 수정</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/bootstrap.css">
<link rel="stylesheet"
	href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="assets/css/app.css">
<link rel="shortcut icon" href="assets/images/favicon.svg"
	type="image/x-icon">
<link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">	

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
<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                	<form method="post" action="customerUpdateProc.jsp" accept-charset="UTF-8">
                	<input type="hidden" name="customer_id" value="<%=customer_id%>" />
                        <div class="row" id="table-hover-row">
                        	<div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 ID</span>
									<input type="text" class="form-control" name="customer_id" value="<%=customer_id%>" readonly />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 이름</span>
									<input type="text" class="form-control" name="customer_name" value="<%=customer_name%>" placeholder="이름을 입력해 주세요." />
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">성별</span>
						            <select class="choices form-select search-filter" name="customer_gender" style="width: 80px; display: inline-block;">
							            <option value="남자" <%= "남자".equals(customer_gender) ? "selected" : "" %>>남자</option>
							            <option value="여자" <%= "여자".equals(customer_gender) ? "selected" : "" %>>여자</option>
							        </select>     
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">고객 연락처</span> 
									<input type="text" class="form-control" name="customer_tel" value="<%=customer_tel%>" placeholder="연락처를 입력해 주세요.">
								</div>
							</div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 이메일</span>
                                    <input type="text" class="form-control" name="customer_mail" value="<%=customer_mail%>" placeholder="이메일을 입력해 주세요.">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 등록일</span>
                                    <input type="date" class="form-control" name="customer_reg" value="<%=customer_reg%>" readonly>
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객등급</span>
						            <select class="choices form-select search-filter" name="customer_rank" style="width: 80px; display: inline-block;">
							            <option value="GOLD" <%= "GOLD".equals(customer_rank) ? "selected" : "" %>>GOLD</option>
							            <option value="SILVER" <%= "SILVER".equals(customer_rank) ? "selected" : "" %>>SILVER</option>
							            <option value="BRONZE" <%= "BRONZE".equals(customer_rank) ? "selected" : "" %>>BRONZE</option>
							        </select>     
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 특이사항</span>
                                    <input type="text" class="form-control" name="customer_note" value="<%=customer_note%>" placeholder="특이사항을 입력해 주세요.">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                            <button type="button" onclick="location.href='customer.jsp'">목록</button>
                                <button type="submit" onclick="alert('수정 되었습니다.')">수정</button>
                                
                            </div>
                        </div>
                    </form>
                </section>
    <jsp:include page="/views/footer.jsp"></jsp:include>

</html>
