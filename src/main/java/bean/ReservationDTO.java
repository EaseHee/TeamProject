package bean;

import java.util.Objects;


public class ReservationDTO {
    private int reservation_no;
    private String reservation_date;
    private String reservation_time;
    private String reservation_comm;
    private int customer_id;
    private String service_code;
    private String customer_name;
    private String service_name;
    private int service_cnt;

    
	
	public int getReservation_no() {
		return reservation_no;
	}

	public void setReservation_no(int reservation_no) {
		this.reservation_no = reservation_no;
	}

	public String getReservation_date() {
		return reservation_date;
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}

	public String getReservation_time() {
		return reservation_time;
	}

	public void setReservation_time(String reservation_time) {
		this.reservation_time = reservation_time;
	}

	public String getReservation_comm() {
		return reservation_comm;
	}

	public void setReservation_comm(String reservation_comm) {
		this.reservation_comm = reservation_comm;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public String getService_code() {
		return service_code;
	}

	public void setService_code(String service_code) {
		this.service_code = service_code;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public int getService_cnt() {
		return service_cnt;
	}

	public void setService_cnt(int service_cnt) {
		this.service_cnt = service_cnt;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReservationDTO reservation = (ReservationDTO) o;
        return Objects.equals(reservation_no, reservation.reservation_no);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(reservation_no);
    }

}