package bean;

import java.util.Objects;

public class AdminDTO {
    private String admin_id;
    private String admin_pw;
    private String admin_name;
    private String admin_ph;
    private String admin_mail;
	
    
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
