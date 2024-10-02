package bean;

import java.util.Objects;

public class AdminDTO {
    private String admin_id;
    private String admin_pw;
    private String admin_name;
    private String admin_ph;
    private String admin_mail;
    private String admin_postcode;
    private String admin_roadAddress;
    private String admin_detailAddress;
  
    public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_pw() {
		return admin_pw;
	}

	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}

	public String getAdmin_name() {
		return admin_name;
	}

	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}

	public String getAdmin_ph() {
		return admin_ph;
	}

	public void setAdmin_ph(String admin_ph) {
		this.admin_ph = admin_ph;
	}

	public String getAdmin_mail() {
		return admin_mail;
	}

	public void setAdmin_mail(String admin_mail) {
		this.admin_mail = admin_mail;
	}
	
	public String getAdmin_postcode() {
		return admin_postcode;
	}

	public void setAdmin_postcode(String admin_postcode) {
		this.admin_postcode = admin_postcode;
	}

	public String getAdmin_roadAddress() {
		return admin_roadAddress;
	}

	public void setAdmin_roadAddress(String admin_roadAddress) {
		this.admin_roadAddress = admin_roadAddress;
	}

	public String getAdmin_detailAddress() {
		return admin_detailAddress;
	}

	public void setAdmin_detailAddress(String admin_detailAddress) {
		this.admin_detailAddress = admin_detailAddress;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AdminDTO admin = (AdminDTO) o;
        return Objects.equals(admin_id, admin.admin_id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(admin_id);
    }
}
