<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">


<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MYPAGE</title>
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
<jsp:include page="/views/header.jsp" ></jsp:include>
				<!-- MYPAGE 시작 -->
				<section class="section">
                    <form action="Mypage" method="post">
                    	<div class="container">
                        	<div class="row" id="table-hover-row">                        	
	                            <div class="col-lg-12 mb-4 mb-sm-5">
	                          		<div class="card card-style1 border-0">
				                        <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
				                            <div class="row align-items-center">
				                                <div class="col-lg-5 mb-4 mb-lg-0 d-flex justify-content-center align-items-center">
				                                    <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="315">
				                                </div>
			                               		<div class="col-lg-7 px-xl-10">
				                                    <ul class="list-unstyled mb-1-9">
				                                        <li class="input-group mb-2 mb-xl-3 display-28">
						                                    <span class="input-group-text" id="basic-addon1" >지점 코드</span>
															<input type="text" class="form-control" name="branchcode" value="${manager.branch_code}" readonly="readonly" />
														</li>
														<li class="input-group mb-2 mb-xl-3 display-28">
						                                    <span class="input-group-text">이 름</span>
				                                   			<input type="text" class="form-control" name="name" value="${manager.manager_name}">
														</li>
														<li class="input-group mb-2 mb-xl-3 display-28">
						                                    <span class="input-group-text">전화 번호</span>
				                                  			<input type="text" class="form-control" name="tel" value="${manager.manager_tel}">
														</li>
														<li class="input-group mb-2 mb-xl-3 display-28">
						                                    <span class="input-group-text">이메일</span>
				                                        	<input type="email" class="form-control" name="mail" value="${manager.manager_mail}">
														</li>
													</ul>													
				                                </div>
				                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
											        	<button type="submit">수정완료</button>
											   	</div>
	                            			</div>
                            			</div>
                           			</div>
                        		</div>
							</div>
						</div>
					</form>
				</section>
                            <%--
				<form action="Mypage" method="post">				
					<section class="" background-color='#607080'>
				        <div class="container">
				            <div class="row">
				                <div class="col-lg-12 mb-4 mb-sm-5">
				                    <div class="card card-style1 border-0">
				                        <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
				                            <div class="row align-items-center">
				                                <div class="col-lg-6 mb-4 mb-lg-0">
				                                    <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="315">
				                                </div>
				                                <div class="col-lg-6 px-xl-10">
				                                    <ul class="list-unstyled mb-1-9">
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">지점코드 :</span>
				                                        	<input type="text" name="branchcode" value="${manager.branch_code}" readonly="readonly">
				                                        </li>
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">이름 :</span>
				                                        	<input type="text" name="name" value="${manager.manager_name}">
				                                        </li>
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">전화번호 :</span>
				                                        	<input type="text" name="tel" value="${manager.manager_tel}">
				                                        </li>
				                                        <li class="mb-2 mb-xl-3 display-28">
				                                        	<span class="display-26 text-secondary me-2 font-weight-600">이메일 :</span>
				                                        	<input type="email" name="mail" value="${manager.manager_mail}">
				                                        </li>
				                                    </ul>
				                                </div>
				                                <!-- 버튼 -->
				                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
											        <button class="btn btn-primary me-md-2" type="submit">수정완료</button>
											    </div>
												<!-- 버튼 종료 -->
				                            </div>
				                        </div>
				                    </div>       
				                </div>
				            </div>
				        </div>
				    </section>
			    </form>
			     --%>
                <!-- MYPAGE 종료 -->
<jsp:include page="/views/footer.jsp"></jsp:include>

</html>
</body>
</html>