package model2.shopping;

public class OrderformDTO {
    private String idx; //상품 일련번호
	private String name; //주문자 성명
	private int postcode; //우편번호
	private String basicadd; //기본 주소
	private String detailadd; //상세 주소
	private String phone_num; //핸드폰
	private String email; //이메일
	private String message; //배송 메세지
	private int payment; //결제 방법
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPostcode() {
		return postcode;
	}
	public void setPostcode(int postcode) {
		this.postcode = postcode;
	}
	public String getBasicadd() {
		return basicadd;
	}
	public void setBasicadd(String basicadd) {
		this.basicadd = basicadd;
	}
	public String getDetailadd() {
		return detailadd;
	}
	public void setDetailadd(String detailadd) {
		this.detailadd = detailadd;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
}
