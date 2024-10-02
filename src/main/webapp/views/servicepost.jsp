<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>INSERT</title>
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
<jsp:include page="/views/header.jsp" ></jsp:include>
				<section class="section">
					<form method="post" action="serviceaddproc.jsp" accept-charset="UTF-8">
						<div class="row" id="table-hover-row">
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">품목 코드</span>
									<input type="text" class="form-control" name="service_code" placeholder="품목 코드를 입력해 주세요">
								</div>
							</div>
							<br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">서비스 명</span>
									<input type="text" class="form-control" name="service_name" placeholder="등록하실 서비스를 입력해주세요">
								</div>
							</div>
							<br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">판매 가격</span>
									<input type="text" class="form-control" name="service_price" placeholder="가격을 입력해 주세요">
								</div>
							</div>
							<br><br><br>
							<div class="button-container">
							<button type="button" onclick="location.href='service.jsp'">목록</button>
								<button type="submit">등록</button>
								
							</div>
						</div>
					</form>
				</section>
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>
</html>