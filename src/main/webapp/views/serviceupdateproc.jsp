<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, bean.*" %>
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

    // DAO 객체 생성 및 데이터 수정
    ServiceDAO dao = new ServiceDAO();
    boolean isUpdated = dao.updateService(service_code, service_name, service_price);

    // 수정 결과에 따라 목록 페이지로 바로 리다이렉트
    if (isUpdated) {
        response.sendRedirect("service.jsp");
    } else {
        out.println("<script>alert('서비스 수정에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
