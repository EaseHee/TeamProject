package bean;

import java.util.Objects;

public class CustomerDTO {
    private int customer_id;
    private String customer_name;
    private String customer_gender;
    private String customer_tel;
    private String customer_mail;
    private String customer_reg;
    private String customer_rank;
	private String customer_note;
    
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public String getCustomer_gender() {
		return customer_gender;
	}
	public void setCustomer_gender(String customer_gender) {
		this.customer_gender = customer_gender;
	}
	public String getCustomer_note() {
		return customer_note;
	}
	public void setCustomer_note(String customer_note) {
		this.customer_note = customer_note;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getCustomer_tel() {
		return customer_tel;
	}
	public void setCustomer_tel(String customer_tel) {
		this.customer_tel = customer_tel;
	}
	public String getCustomer_mail() {
		return customer_mail;
	}
	public void setCustomer_mail(String customer_mail) {
		this.customer_mail = customer_mail;
	}
	public String getCustomer_reg() {
		return customer_reg;
	}
	public void setCustomer_reg(String customer_reg) {
		this.customer_reg = customer_reg;
	}
	public String getCustomer_rank() {
		return customer_rank;
	}
	public void setCustomer_rank(String customer_rank) {
		this.customer_rank = customer_rank;
	}
	
     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerDTO customer = (CustomerDTO) o;
        return Objects.equals(customer_id, customer.customer_id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(customer_id);
    }
}
