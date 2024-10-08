<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<%@ page import="bean.*" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 정보</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="/TeamProject/views/assets/css/page.css">

</head>

<body>
<%
    String code = request.getParameter("code");
    ServiceDAO dao = new ServiceDAO();
    ServiceDTO service = dao.getServiceDetail(code);

    if (service == null) {
        out.println("품목 코드 찾을 수 없음: " + code);
        return;
    }
%>
<jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" action="serviceaddproc.jsp" accept-charset="UTF-8">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">품목 코드</span>
                                    <input type="text" class="form-control" name="service_code" value="<%= service.getService_code() %>" readonly>
                                    <input type="hidden" name="service_code" value="<%= service.getService_code() %>">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">서비스 명</span>
                                    <input type="text" class="form-control" name="service_name" value="<%= service.getService_name() %>" readonly>
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">판매 가격</span>
                                    <input type="text" class="form-control" name="service_price" value=<fmt:formatNumber value="<%= service.getService_price() %>"/> readonly>
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">
                            <button type="button" onclick="location.href='service.jsp'">목록</button>
                                <button type="button" onclick="location.href='serviceupdate.jsp?code=<%= service.getService_code() %>'">수정</button>
                                <button type="button" onclick="confirmDelete('<%=service.getService_code() %>')">삭제</button>
                                
                            </div>
                        </div>
                    </form>
                </section>
<jsp:include page="/views/footer.jsp"></jsp:include>
    <script>
        function confirmDelete(service_code) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                location.href = 'servicedelete.jsp?service_code=' + encodeURIComponent(service_code);
            }
        }
    </script>
</body>
</html>
