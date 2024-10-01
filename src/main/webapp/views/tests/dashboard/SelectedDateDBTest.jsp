<%@page import="bean.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SelectedDateDB Test</title>
<style>
	#explainTest {
		border: 1px solid black;
		padding: 1em;
		margin: 1em;
	}
</style>
</head>
<body>
	<div id="explainTest">
		<h1>SelectedDate DB Test</h1>
		<div class="field">
			<h2>테스트 대상</h2>
			<ul>
				<li>
					java.bean.DashBoardDAO
					<ul>
						<li>public List&lt;DashboardDTO&gt; getReservationByDate()</li>
						<li>public void setSelectedDate(String selectedDateStr)</li>
					</ul>
				</li>
			</ul>
		</div>
		<hr/>
		<div class="field">
			<h2>테스트 개요</h2>
			<ul>
				<li>특정 날짜를 입력하면 그 날짜에 해당하는 예약 시간 및 예약 서비스명을 잘 가져오는 지 테스트.</li>
			</ul>
		</div>
	</div>
	<div id="testArea">
		<form method="POST">
			<input type="date" name="date" />
			<input type="submit" value="전송"/>
		</form>

		<table border="1">
			<tr>
				<th>예약 시간</th>
				<th>예약 서비스명</th>
			</tr>
			<c:choose>
				<c:when test="${ empty param.date }">
					<tr>
						<td colspan="2">날짜를 선택하세요</td>
					</tr>
				</c:when>
				<c:when test="${ pageContext.request.method == 'POST' }">
					<jsp:useBean id="dao" class="bean.DashboardDAO"></jsp:useBean>
					<jsp:setProperty property="selectedDate" name="dao" value="${ param.date }"/>
					<c:forEach var="oneRecord" items="${ dao.reservationByDate }">
						<c:choose>
							<c:when test="${ empty dao.reservationByDate }">
								<tr>
									<td colspan="2">조회 결과가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>${ empty oneRecord.reservation_time ? "-" : oneRecord.reservation_time }</td>
									<td>${ empty oneRecord.service_name ? "-" : oneRecord.service_name }</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="2">원하는 날짜 선택하세요.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>