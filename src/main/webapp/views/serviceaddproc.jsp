<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, bean.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 등록</title>
</head>
<body>


<% 
    request.setCharacterEncoding("UTF-8");
    // 폼에서 전달된 데이터 받기
    String service_code = request.getParameter("service_code");
    String service_name = request.getParameter("service_name");
    String service_price_str = request.getParameter("service_price");

    int service_price = 0;
    if (service_price_str != null && !service_price_str.isEmpty()) {
        try {
            service_price = Integer.parseInt(service_price_str);
        } catch (NumberFormatException e) {
            // 숫자로 변환할 수 없을 때 처리
            e.printStackTrace();
            out.println("<script>alert('가격은 숫자여야 합니다.'); history.back();</script>");
            return;
        }
    }

    // 데이터 확인
    System.out.println("service_code: " + service_code);
    System.out.println("service_name: " + service_name);
    System.out.println("service_price: " + service_price);

    // DAO 객체 생성 및 데이터 등록
    ServiceDAO dao = new ServiceDAO();
    dao.insertService(service_code, service_name, service_price);

    // 등록 완료 후 목록 페이지로 리다이렉트
    response.sendRedirect("service.jsp");
%>
</body>
</html>