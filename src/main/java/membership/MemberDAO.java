package membership;

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
				dto.setRegidate(rs.getDate("regidate"));
				dto.setEmail(rs.getString("email"));
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	public int insertWrite(MemberDTO dto) {
		//입력 결과 확인용 변수
		int result = 0;
		
		try {
			//인파라미터가 있는 쿼리문 작성(동적쿼리문)
			String query = "INSERT INTO member ( "
						 + " name,id,pass,num,phone_num,email,postcode,basicadd,detailadd ) "
						 + " VALUES ( "
						 + "  ?, ?, ?, ?, ?, ?, ?, ?, ? ) " ;
			//동적쿼리문 실행을 위한 prepareStatement 객체 생성
			psmt = con.prepareStatement(query);
			//순서대로 인파라미터 설정
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getPass());
			psmt.setString(4, dto.getNum());
			psmt.setString(5, dto.getPhone_num());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getPostcode());
			psmt.setString(8, dto.getBasicadd());
			psmt.setString(9, dto.getDetailadd());
			//쿼리문 실행 : 입력에 성공한다면 1이 반환되고 실패시 0반환.
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	public boolean confirmId(String id){
		boolean result = false;
		
		try {
			MemberDTO dto = new MemberDTO();
			//회원 로그인을 위한 쿼리문 작성
			String query = "SELECT id FROM member WHERE id=?";
			
			psmt = con.prepareStatement(query.toString());
			//쿼리문에 사용자가 입력한 아이디를 설정
			psmt.setString(1, id);
			//쿼리실행
			rs = psmt.executeQuery();
			
			//회원정보가 존재한다면 DTO객체에 회원정보를 저장한다.
			if(rs.next()) {
				result = true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public MemberDTO getMemberInfo(String uid, String uname, String umail) {
	
		
        
    	MemberDTO dto = new MemberDTO();  
        
    	String query = "";
    	
    	if(uid.equals("")) //아이디 찾기
    		query = "SELECT * FROM member WHERE name=? AND email=?";
    	else //비번찾기
    		query = "SELECT * FROM member WHERE id=? AND name=? AND email=?";

        try {
            psmt = con.prepareStatement(query);
            if(uid.equals("")) {
                psmt.setString(1, uname);
                psmt.setString(2, umail);
            }
        	else {
        		psmt.setString(1, uid);     
        		psmt.setString(2, uname);
        		psmt.setString(3, umail);
        	}
              
            rs = psmt.executeQuery();  
            if (rs.next()) {
                dto.setId(rs.getString("id"));
                dto.setPass(rs.getString("pass"));
                dto.setName(rs.getString(3));
                dto.setRegidate(rs.getDate(4));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return dto; 
    }
	public MemberDTO getMemberInfo(String uid) {

        MemberDTO dto = new MemberDTO();

        String query = "";

        query = "SELECT * FROM member WHERE id=? ";


        try {
            psmt = con.prepareStatement(query);

            psmt.setString(1, uid);


            rs = psmt.executeQuery();
            if (rs.next()) {
                dto.setId(rs.getString("id"));
                dto.setPass(rs.getString("pass"));
                dto.setName(rs.getString("name"));
                dto.setPhone_num(rs.getString("phone_num"));
                dto.setEmail(rs.getString("email"));
                dto.setPostcode(rs.getString("postcode"));
                dto.setBasicadd(rs.getString("basicadd"));
                dto.setDetailadd(rs.getString("detailadd"));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return dto; 
    }
	//게시물 수정 : 수정할 내용을 DTO객체에 저장 후 매개변수로 전달
	public int updateEdit(MemberDTO dto) {
		int result = 0;
		
		try {
			//update를 위한 커리문
			String query = "UPDATE member SET "
						 + " name=?, pass=?, phone_num=?, email=?, postcode=?, basicadd=?, detailadd=? "
						 + " WHERE id=?";
			//prepared객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getPhone_num());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getPostcode());
			psmt.setString(6, dto.getBasicadd());
			psmt.setString(7, dto.getDetailadd());
			psmt.setString(8, dto.getId());
			//쿼리 실행
			result = psmt.executeUpdate();
			
		}
		catch(Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}
