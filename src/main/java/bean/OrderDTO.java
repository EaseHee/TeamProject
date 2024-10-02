package bean;

public class OrderDTO {
	private String product_B_code; /* 상품 대분류 */
	private String product_code; /* 상품코드(소분류) */
	private String product_name; /* 상품명 */
	private int product_price; /* 가격 */
	private int product_ea; /* 수량 */

	// 상품 대분류
	public String getProduct_B_code() {
		return product_B_code;
	}
	public void setProduct_B_code(String product_B_code) {
		this.product_B_code = product_B_code;
	}

	// 상품코드(소분류)
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	// 상품명
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	// 가격
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	// 수량
	public int getProduct_ea() {
		return product_ea;
	}
	public void setProduct_ea(int product_ea) {
		this.product_ea = product_ea;
	}
}
