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
<script src="assets/js/pages/dashboard.js"></script>
<script src="assets/js/pages/chartMonthRevenue.js"></script><!-- 그래프 ui 설정 변경 js 파일 _ 축별 설정 및 데이터 전달 시 해당 파일 참조 -->
<script src="assets/js/main.js"></script>
<script src="assets/js/calendarWithReservation.js" defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
	window.onload = function(){
		const currentUrl = window.location.pathname;
		if(currentUrl.includes('dashboard')){
			document.getElementById('dashboard-li').classList.add('active')
			document.getElementById('header-text').textContent = '메인'
		}else if(currentUrl.includes('customer')){
			document.getElementById('customer-li').classList.add('active')
			document.getElementById('header-text').textContent = '고객'
		}else if(currentUrl.includes('reservation')){
			document.getElementById('reservation-li').classList.add('active')
			document.getElementById('header-text').textContent = '예약'
		}else if(currentUrl.includes('service')){
			document.getElementById('service-li').classList.add('active')
			document.getElementById('header-text').textContent = '서비스'
		}else if(currentUrl.includes('product')){
			document.getElementById('product-li').classList.add('active')
			document.getElementById('header-text').textContent = '상품'
		}else if(currentUrl.includes('member')){
			document.getElementById('member-li').classList.add('active')
			document.getElementById('header-text').textContent = '직원'
		}else if(currentUrl.includes('notice')){
			document.getElementById('notice-li').classList.add('active')
			document.getElementById('header-text').textContent = '공지'
		}else if(currentUrl.includes('mypage')){
			document.getElementById('header-text').textContent = '마이 페이지'
		}else{
			window.alert('존재하지 않는 페이지 입니다.')
		}
	}
</script>