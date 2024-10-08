<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<br><br><br>
<footer>
    <div class="footer clearfix mb-0 text-muted">
        <div class="float-start">
            <p>2024 &copy; ACORN</p>
        </div>
        <div class="float-end">
            <p><span class="text-danger"><i class="bi bi-heart"></i></span> by <a
                    href="#main">거니네조</a>
            </p>                                
        </div>
    </div>
</footer>
	        </div>
	    </div>
    </div>
<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendors/apexcharts/apexcharts.js"></script>
<script src="assets/js/pages/chartMonthRevenue.js"></script><!-- 그래프 ui 설정 변경 js 파일 _ 축별 설정 및 데이터 전달 시 해당 파일 참조 -->
<script src="assets/js/main.js"></script>
<script src="assets/js/calendar.js"></script>
<script src="assets/js/calendarWithReservation.js" defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
	window.onload = function(){
		const currentUrl = window.location.pathname;
		if(currentUrl.includes('dashboard')){
			document.getElementById('dashboard-li').classList.add('active');
			document.getElementById('header-text').textContent = '메인';
		}else if(currentUrl.includes('customer')){
			document.getElementById('customer-li').classList.add('active');
			document.getElementById('header-text').textContent = '고객';
			if(currentUrl.includes('Add')) document.getElementById('header-text').textContent = '고객 등록';
			else if(currentUrl.includes('Read')) document.getElementById('header-text').textContent = '고객 상세';
			else if(currentUrl.includes('Update')) document.getElementById('header-text').textContent = '고객 수정';			
		}else if(currentUrl.includes('reservation')){
			document.getElementById('reservation-li').classList.add('active');
			document.getElementById('header-text').textContent = '예약';
			if(currentUrl.includes('Post')) document.getElementById('header-text').textContent = '예약 등록';
			else if(currentUrl.includes('Read')) document.getElementById('header-text').textContent = '예약 상세';
			else if(currentUrl.includes('Update')) document.getElementById('header-text').textContent = '예약 수정';
		}else if(currentUrl.includes('service')){
			document.getElementById('service-li').classList.add('active');
			document.getElementById('header-text').textContent = '서비스';
			if(currentUrl.includes('post')) document.getElementById('header-text').textContent = '서비스 등록';
			else if(currentUrl.includes('detail')) document.getElementById('header-text').textContent = '서비스 상세';
			else if(currentUrl.includes('update')) document.getElementById('header-text').textContent = '서비스 수정';
		}else if(currentUrl.includes('product')){
			document.getElementById('product-li').classList.add('active');
			document.getElementById('header-text').textContent = '상품';
			if(currentUrl.includes('add')) document.getElementById('header-text').textContent = '상품 등록';
			else if(currentUrl.includes('product_read')) document.getElementById('header-text').textContent = '상품 상세';
			else if(currentUrl.includes('update')) document.getElementById('header-text').textContent = '상품 수정';
		}else if(currentUrl.includes('member')){
			document.getElementById('member-li').classList.add('active');
			document.getElementById('header-text').textContent = '직원';
			if(currentUrl.includes('Post')) document.getElementById('header-text').textContent = '직원 등록';
			else if(currentUrl.includes('Read')) document.getElementById('header-text').textContent = '직원 상세';
			else if(currentUrl.includes('Update')) document.getElementById('header-text').textContent = '직원 수정';
		}else if(currentUrl.includes('notice')){
			document.getElementById('notice-li').classList.add('active');
			document.getElementById('header-text').textContent = '공지';
			if(currentUrl.includes('notice_view')) document.getElementById('header-text').textContent = '공지 상세 페이지';
		}else if(currentUrl.includes('mypage')){
			document.getElementById('header-text').textContent = '마이 페이지';
		}else{
			window.alert('존재하지 않는 페이지 입니다.');
		}
	}
</script>