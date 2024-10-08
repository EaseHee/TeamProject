package bean;

/**
import lombok.Data;

@Data
 * lombok 코드 제거 및 getter, setter 메서드 정의.
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
    private int notice_no;
    
	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_ea() {
		return product_ea;
	}

	public void setProduct_ea(int product_ea) {
		this.product_ea = product_ea;
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

	public String getService_code() {
		return service_code;
	}

	public void setService_code(String service_code) {
		this.service_code = service_code;
	}

	public int getService_price() {
		return service_price;
	}

	public void setService_price(int service_price) {
		this.service_price = service_price;
	}

	public int getService_cnt() {
		return service_cnt;
	}

	public void setService_cnt(int service_cnt) {
		this.service_cnt = service_cnt;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

}
