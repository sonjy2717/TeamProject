package membership;

public class MemberDTO {
	//멤버변수 : board테이블의 컬럼과 동일한 이름으로 생성
	
	
	private String name; //이름
	private String id;  //아이디(외래키)
	private String pass;  //패스워드
	private String num; //전화번호
	private String phone_num;  //휴대전화
	private String email;  //이메일
	private String postcode;  //우편번호
	private String basicadd;  //기본 주소
	private String detailadd;  //상세 주소
	private java.sql.Date regidate; // 날짜
	
	/*
	 	board테이블 name컬럼은 존재하지 않으나, 목록에 작성자의
	 	이름을 출력하기 위해 member테이블과의 join을 통해 이름을 가져와서
	 	출력하게 된다.
	*/
	
	//getter/setter 메서드
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
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
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
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
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
}
