package bean;

import java.util.Objects;

public class ServiceDTO {
    private String service_code;
    private String service_name;
    private int service_price;
    
	public String getService_code() {
		return service_code;
	}
	public void setService_code(String service_code) {
		this.service_code = service_code;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public int getService_price() {
		return service_price;
	}
	public void setService_price(int service_price) {
		this.service_price = service_price;
	}
	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ServiceDTO service = (ServiceDTO) o;
        return Objects.equals(service_code, service.service_code);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(service_code);
    }
}
