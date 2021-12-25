package fileupload;

import java.util.List;
import java.util.Vector;

import common.DBConnPool;

//DB 커넥션 풀을 통한 연결
public class MyfileDAO extends DBConnPool {
	 
	//파일 및 게시물 입력
    public int insertFile(MyfileDTO dto) {
        int applyResult = 0;
        try {
        	//1.쿼리문 작성
            String query = "INSERT INTO board ( "
                + " idx, id, title, ofile, sfile) "
                + " VALUES ( "
                + " seq_board_num.nextval, ?, ?, ?, ?, ?)";
            //2.prepared객체 생성 및 인파라미터 설정
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getTitle());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            //3.쿼리실행
            applyResult = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("INSERT 중 예외 발생");
            e.printStackTrace();
        }        
        return applyResult;
    }

    //파일 목록 출력
    public List<MyfileDTO> myFileList() {
    	
        List<MyfileDTO> fileList = new Vector<MyfileDTO>();
        
        //레코드를 일련번호의 내림차순으로 정렬
        String query = "SELECT * FROM myfile ORDER BY idx DESC";
        try {
            psmt = con.prepareStatement(query);   
            rs = psmt.executeQuery();  
            //ResultSet의 객체수 만큼 반복
            while (rs.next()) {                
                MyfileDTO dto = new MyfileDTO();
                dto.setIdx(rs.getString(1));
                dto.setName(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setCate(rs.getString(4));
                dto.setOfile(rs.getString(5));
                dto.setSfile(rs.getString(6));
                dto.setPostdate(rs.getString(7));
                //각 레코드를 List컬렉션에 추가
                fileList.add(dto);   
            }
        }
        catch (Exception e) {
            System.out.println("SELECT 시 예외 발생");
            e.printStackTrace();
        }        
        
        return fileList;   
    }
}