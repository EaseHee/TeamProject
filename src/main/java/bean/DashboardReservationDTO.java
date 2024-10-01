package bean;

/**
 * DashboardDAO.getReservationByDate()에서 사용할 DTO 클래스
 * 
 * 다음과 같이 여러 테이블들의 필드명들이 섞여 있음. 
 * customer.customer_name, 
 * reservation.reservation_time, 
 * service.service_name, 
 * member.member_name 
 */
public class DashboardReservationDTO {
	private String customer_name;
	private String reservation_time;
	private String service_name;
	private String member_name;
	
	public String getCustomer_name() {
		return customer_name;
	}
	
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	
	public String getReservation_time() {
		return reservation_time;
	}
	
	public void setReservation_time(String reservation_time) {
		this.reservation_time = reservation_time;
	}
	
	public String getService_name() {
		return service_name;
	}
	
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	
	public String getMember_name() {
		return member_name;
	}
	
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
}
