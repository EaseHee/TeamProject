package bean;

import lombok.Data;

@Data
/**
 * lombok 라이브러리를 사용하면 DTO 클래스에서 개발자가 직접 
 * getter, setter 메서드를 정의하지 않아도 해당 라이브러리가 
 * 컴파일 과정에서 자동으로 생성해줍니다. 
 * 이를 통해 DB 필드명이 바뀌어도 필드명만 바꿔주면 되어서 더욱 간편합니다. 
 * lombok 라이브러리 설치법 및 사용법은 "채썜의 Servlet&JSP 프로그래밍 핵심" 책의 7장 초반에 있으며, 
 * 그 과정도 매우 쉽습니다. 
 * 단, lombok에서 제공하는 어노테이션들을 적용한 상태에서 getter, setter 등 
 * lombok에서 자동으로 생성해주는 메서드를 개발자가 정의해버리면 
 * 사실상 똑같은 이름의 메서드를 중복 정의하는 것이기에 에러가 발생할 수 있으니 주의해야 합니다. 
 * 그게 아니라면 비즈니스 로직을 구현하는 메서드를 얼마든지 추가해도 문제는 발생하지 않을 것입니다. 
 */

public class DashboardDTO {
	private String product_name;
	private int product_ea;
	private String reservation_time;
	private String service_name;
	private String service_code;
	private int service_price;
	private int service_cnt;
    private String notice_title;
	
	/* 월별 서비스 매출 */
	public int getChart_revenue() {
		return service_price * service_cnt;
	}
}
