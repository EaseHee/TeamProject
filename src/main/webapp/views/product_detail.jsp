<%@page import="bean.*"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
</head>
<script>
	function check() {
		if(document.search.keyWord.value == "") {
			document.search.keyWord.focus();
			return;
		}
		
		document.search.submit();
	}
	
	function addProduct() {
		var product_B_code = '<%=request.getParameter("product_B_code")%>';
		window.location.href = 'product_add.jsp?product_B_code=' + product_B_code;
	}
</script>
<body>
	<jsp:useBean id="prodDAO" class="bean.ProductDAO"></jsp:useBean>
	<jsp:useBean id="board" class="bean.ProductDTO"></jsp:useBean>
	
	<%
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		
		String product_B_code = request.getParameter("product_B_code");
		
		//검색어 받기
		String keyWord = request.getParameter("keyWord");
		
		//페이징에 필요한 변수
		int totalcnt = 0;     //총 글의 개수
		int numPerPage = 10;  //한 페이지당 보여질 글의 개수
		int totalPage = 0;    //총 페이지 수
		int nowPage = 0;      //현재 선택된 페이지
		int beginPerPage = 0; //페이지별 시작번호(중요!) EX) 1,11,21
		int pagePerBlock = 2; //블럭당 페이지 수
		int totalBlock = 0;   //총 블럭 수
		int nowBlock = 0;     //현재 블럭
		
		if(request.getParameter("nowBlock") != null) {
            nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
        }
		
		if (product_B_code != null && !product_B_code.isEmpty()) {
			ArrayList<ProductDTO> list = (ArrayList<ProductDTO>) prodDAO.getProductList(product_B_code, keyWord);
			
			prodDAO.getProductList(product_B_code, keyWord);
			
			totalcnt = list.size();
			
			totalPage = (int)Math.ceil((double)totalcnt / numPerPage); // 페이지 개수 구하기

	        if(request.getParameter("nowPage") != null) {
	            nowPage = Integer.parseInt(request.getParameter("nowPage"));
	        }

	        // 페이지당 시작번호
	        beginPerPage = nowPage * numPerPage;

	        totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
	        
	        if(request.getParameter("nowBlock") != null) {
	            nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	        }
	%>

    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="dashboard.jsp"><!-- <img src="assets/images/logo/logo.png" alt="Logo" srcset="">-->LOGO</a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>

                        <li class="sidebar-item">
                            <a href="dashboard.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>HOME</span>
                            </a>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>CUSTOMER</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="customer.jsp">회원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="customer.jsp">기타</a>
                                </li>                                
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-collection-fill"></i>
                                <span>RESERVATION</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="reservation.jsp">예약 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="reservation.jsp">기타</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>SERVICE</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="service.jsp">서비스 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="service.jsp">기타</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item active has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>PRODUCT</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="product.jsp">상품 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="product.jsp">기타</a>
                                </li>
                             </ul>
                        </li>
 
                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-pen-fill"></i>
                                <span>NOTICE</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="notice_list.jsp">공지 사항</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="notice_list.jsp">기타</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
           		</div>
        	</div>
	        <div id="main">
	            <header class="mb-3">
	                <a href="#" class="burger-btn d-block d-xl-none">
	                    <i class="bi bi-justify fs-3"></i>
	                </a>
	            </header>
	
	            <div class="page-heading">
	                <div class="page-title">
	                    <div class="row">
	                        <div class="col-12 col-md-6 order-md-1 order-last">
	                            <h3>상품 조회</h3>
	                        </div>
	                        <div class="col-12 col-md-6 order-md-2 order-first">
	                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="login.jsp">로그아웃</a></li>                                    
	                                </ol>
	                            </nav>
	                        </div>
	                    </div>
	                </div>
	                <hr style="height: 5px;">
	                <div class="row form-group">
					    <form method="get" action="product_detail.jsp?product_B_code=<%=product_B_code%>" class="col-4 d-flex align-items-end" accept-charset="UTF-8">
				        	<input type="hidden" name="product_B_code" value="<%=request.getParameter("product_B_code") %>"/>
					        <input type="text" name="keyWord" placeholder="상품명으로 검색" class="form-control me-2">
					        <input type="submit" class="btn btn-outline-success" onclick="check()" value="조회">
					    </form>
					</div>
	                <section class="section">
	                	<div class="buttons d-flex justify-content-end align-items-end">
							<a href="#" onclick="addProduct()" class="btn btn-outline-success" style="margin-right: 0px;">등록</a>
						</div>
	                    <div class="row" id="table-hover-row">
	                        <div class="col-12">
	                            <div class="card">
	                                <div class="card-content">
	                                    <div class="table-responsive">
	                                        <table class="table table-hover mb-0" id="productTable">
	                                            <thead>
	                                                <tr>
	                                                    <th>상품코드</th>
	                                                    <th>상품명</th>
	                                                    <th>가격</th>
	                                                    <th>수량</th>
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                            	<%
	                                            		for(int i=beginPerPage; i < beginPerPage + numPerPage && i < totalcnt; i++) {
	                                            			board = list.get(i);
	                                            	%>
	                                            	
	                                                <tr>
	                                                    <td class="text-bold-500"><%=board.getProduct_code() %></td>
	                                                    <td class="text-bold-500"><a href="product_read.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&product_code=<%= board.getProduct_code() %>"><%=board.getProduct_name()%></a></td>
	                                                    <td class="text-bold-500"><%=board.getProduct_price() %></td>
	                                                    <td class="text-bold-500"><%=board.getProduct_ea() %></td>
	                                                </tr>
	                                                <%
	                                            		}
	                                          
	                                                %>
	                                            </tbody>
	                                        </table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div id="excel_export" class="buttons d-flex justify-content-end align-items-end">
							<button onclick="downloadExcel()" class="btn btn-outline-warning" style="margin-right: 0px;">엑셀 다운로드</button>
						</div>
	                    <div class="col-12 d-flex justify-content-center align-items-center">
							<nav aria-label="Page navigation example">
								<ul class="pagination pagination-primary">
									<!-- nowBlock이 0보다 클 때에만 '이전'을 클릭할 수 있게 -->
						            <% if(nowBlock > 0) { %>
						                <li class="page-item">
											<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=(nowBlock-1) * pagePerBlock %>&nowBlock=<%=nowBlock-1%>">
											<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a>
										</li>
						            <% } %>
									<%
						                int startPage = nowBlock * pagePerBlock + 1;
						                int endPage = Math.min(startPage + pagePerBlock - 1, totalPage);
						
						                for(int i=startPage; i<=endPage; i++) {
						            %>
						                <li class="page-item active"><a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=i-1 %>&nowBlock=<%=nowBlock%>"><%=i%></a></li>
						            <%
						                }
						            %>
						            <% if(totalBlock > nowBlock + 1) { %>
						                <li class="page-item">
						                	<a class="page-link" href="product_detail.jsp?product_B_code=<%=request.getParameter("product_B_code") %>&nowPage=<%=(nowBlock + 1) * pagePerBlock %>&nowBlock=<%=nowBlock + 1%>">
											<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span></a>
										</li>
						            <% } %>
								</ul>
							</nav>
						</div>
	                </section>
	            <footer>
	                <div class="footer clearfix mb-0 text-muted">
	                    <div class="float-start">
	                        <p>2024 &copy; ACORN</p>
	                    </div>
	                    <div class="float-end">
	                        <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a
	                                href="#">거니네조</a>
	                        </p>                                
	                    </div>
	                </div>
	            </footer>
	        </div>
	    </div>
	</div>
	<%
        } else {
        	response.sendRedirect("product.jsp");
        }
    %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    <script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
    <script>
	    function downloadExcel() {
	        var table = document.getElementById("productTable");
	        // 테이블 > 워크시트
	        var wb = XLSX.utils.table_to_book(table, {sheet: "상품 관리"});
	        XLSX.writeFile(wb, '상품_관리.xlsx');
	    }
	</script>
</body>
</html>