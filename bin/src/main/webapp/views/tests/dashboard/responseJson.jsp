<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<h1>response Json Test</h1>
		<div class="field">
			<h2>테스트 대상</h2>
			<ul>
				<li>servlet.DashboardServlet</li>
			</ul>
		</div>
		<hr/>
		<div class="field">
			<h2>테스트 개요</h2>
			<ul>
				<li>팩토리 패턴 적용 후 json 데이터를 잘 받을 수 있는 지 테스트.</li>
			</ul>
		</div>
	</div>
	<div id="testArea">
		<form method="POST" action="/TeamProject/dashboard">
			<input type="hidden" name="command" value="CALENDAR_RESERVATION" />
			<input type="date" name="date" />
			<input type="submit" value="전송"/>
		</form>
	</div>
</body>
</html>