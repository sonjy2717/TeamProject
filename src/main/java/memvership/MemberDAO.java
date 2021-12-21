package memvership;

import javax.servlet.ServletContext;

import common.JDBConnect;
/*
DAO(Data Access Object) : 실제 데이터베이스에 접근하여
 	여러가지 CRUD작업을 하기위한 객체.
*/
//DB 연결을 위한 클래스를 상속한다.
public class MemberDAO  extends JDBConnect{
	
	public MemberDAO() {
		super();
	}
	
	//인자가 4개인 부모의 생성자를 호출하여 연결한다.
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	//application 내장객체만 매개변수로 받아 부모로 전달하는 생성자
	public MemberDAO(ServletContext application) {
		super(application);
	}
	
	/*
	사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 확인한 후
	존재하는 정보인 경우 DTO 객체에 그 정보를 담아 반환한다. 
	*/
	public MemberDTO getMemberDTO(String uid, String upass) {
		
		MemberDTO dto = new MemberDTO();
		//회원로그인을 위한 쿼리문 작성
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			//쿼리문에 사용자가 입력한 아이디, 패스워드를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리실행
			rs = psmt.executeQuery();
			
			//회원정보가 존재한다면 DTO객체에 회원정보를 저장한다.
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setRegidate(rs.getDate(4));
				dto.setEmail(rs.getString("email"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
