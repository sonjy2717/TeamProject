package memvership;

public class MemberDTO {
	//멤버변수 : board테이블의 컬럼과 동일한 이름으로 생성
	
	
	private String id;      //아이디
	private String pass;    //비밀번호
	private String name;   //이름
	private java.sql.Date regidate; //날짜
	private String email; //이메일
	
	/*
	 	board테이블 name컬럼은 존재하지 않으나, 목록에 작성자의
	 	이름을 출력하기 위해 member테이블과의 join을 통해 이름을 가져와서
	 	출력하게 된다.
	*/
	
	//getter/setter 메서드
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public java.sql.Date getRegidate() {
		return regidate;
	}

	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
