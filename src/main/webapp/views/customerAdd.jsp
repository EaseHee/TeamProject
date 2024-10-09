<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 등록</title>
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
    <div id="app">		
        <jsp:include page="/views/header.jsp" ></jsp:include>
                <section class="section">
                    <form method="post" id="" accept-charset="UTF-8" action="customerAddProc.jsp">
                        <div class="row" id="table-hover-row">
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 ID</span>
                                    <input type="text" class="form-control" name="customer_id" placeholder="아이디를 입력해 주세요." />
                                </div>
                            </div>
                            <br><br><br>
							<div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 이름</span>
                                    <input type="text" class="form-control" name="customer_name" placeholder="이름을 입력해 주세요." />
                                </div>
                            </div>
							<br><br><br>
							<div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">성별</span>
                                    <select class="choices form-select search-filter" name="customer_gender" style="width: 80px; display: inline-block;">
							            <option value="남자">남자</option>
							            <option value="여자">여자</option>
							        </select> 
                                </div>
                            </div>
							<br><br><br>
							<div class="col-lg-12 mb-12">
								<div class="input-group mb-12">
									<span class="input-group-text" id="basic-addon1">고객 연락처</span> 
									<input type="text" class="form-control" name="customer_tel" placeholder="연락처를 입력해 주세요.">
								</div>
							</div>
							<br><br><br>
							<div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 이메일</span>
                                    <input type="text" class="form-control" name="customer_mail" placeholder="이메일을 입력해 주세요.">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
    								<span class="input-group-text" id="basic-addon1">고객 등록일</span>
    								<input type="date" id="customer_reg" class="form-control" name="customer_reg" onclick="this.showPicker()">
								</div>
							<script>
   								window.onload = function() {
        						var now_utc = Date.now(); // 현재 시간을 UTC로
        						var timeOff = new Date().getTimezoneOffset() * 60000; // UTC와의 차이를 밀리초로
        						var today = new Date(now_utc - timeOff).toISOString().split("T")[0]; // ISO 형식에서 날짜 부분만 추출
        						document.getElementById('customer_reg').setAttribute('min', today); // min 속성에 오늘 날짜 설정
    							}
							</script>
                            </div>
                            <br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 등급</span>
						            <select class="choices form-select search-filter" name="customer_rank" style="width: 80px; display: inline-block;">
							            <option value="GOLD">GOLD</option>
							            <option value="SILVER">SILVER</option>
							            <option value="BRONZE">BRONZE</option>
							        </select>     
                                </div>
                            </div>
							<br><br><br>
                            <div class="col-lg-12 mb-12">
                                <div class="input-group mb-12">
                                    <span class="input-group-text" id="basic-addon1">고객 특이사항</span>
                                    <input type="text" class="form-control" name="customer_note" placeholder="특이사항을 입력해 주세요.">
                                </div>
                            </div>
                            <br><br><br>
                            <div class="button-container">         
                                <button type="button" onclick="location.href='customer.jsp'">목록</button>
                                <button type="submit" onclick="alert('등록되었습니다.')">등록</button>
                            </div>
                        </div>
                    </form>
                </section>   
<jsp:include page="/views/footer.jsp"></jsp:include>
</body>
</html>
</body>
</html>