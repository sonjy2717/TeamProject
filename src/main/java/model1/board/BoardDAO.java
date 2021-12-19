package model1.board;

import common.JDBConnect;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;

public class BoardDAO extends JDBConnect{
	
	//부모의 인자생성자를 호출한다. 이때 application 내장 객체를 매개변수로 전달한다.
	public BoardDAO(ServletContext application) {
		//내장 객체를 통해 	web.xml에 작성된 컨텍스트 초기화 파라미터를 얻어온다.
		super(application);
	}
	
	public int selectCount(Map<String, Object> map) {
		
		int totalCount = 0;
		
		String query = "SELECT COUNT(*) FROM board";
		
		if(map.get("searchWord") != null) {
			query += " WHERE "+ map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<BoardDTO> selectList(Map<String, Object> map){  //모든게시판의 모든 게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		String query =  "SELECT * FROM board";
		
		if(map.get("searchWord") != null) {
			query += " WHERE "+ map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query  += " ORDER BY idx DESC ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
		
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	public int practice (Map<String, Object> map, String tName) {
		return 1;
	}
	
	public List<BoardDTO> selectList2(Map<String, Object> map, String tName){ //선택한 게시판의 모든게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		String query =  "SELECT * FROM board WHERE tName ='"+tName+"'";
		
		if(map.get("searchWord") != null) {
			query += " WHERE "+ map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query  += " ORDER BY idx DESC ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
		
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}

	public int insertWrite(BoardDTO dto, String tName) {
		//입력결과 확인용 변수
		int result = 0;
		
		try {
			String query = "INSERT INTO board ( idx, title, content, id , visitcount, tname )"
					+ " VALUES ( seq_board_num, ?, ?, ?, 0, ?) ";
			
			psmt= con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, tName);
			
			result = psmt.executeUpdate();
			
		}
		catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public BoardDTO selectView(String idx) { 
	
		BoardDTO dto = new BoardDTO();
		
		try {	
			String query = "SELECT * FROM board WHERE idx=?";
			
			psmt = con.prepareStatement(query);
            psmt.setString(1, idx);   
            rs = psmt.executeQuery(); 
			
            if (rs.next()) {
				 dto.setId(rs.getString("id"));
				 dto.setPostdate(rs.getDate("postdate"));
				 dto.setVisitcount(rs.getString("visitcount"));
				 dto.setTitle(rs.getString("title")); dto.setContent(rs.getString("content")); 
				 dto.setOfile("ofile");
				 dto.setOfile("sfile");
            }
			
			
		}catch(Exception e) {
			System.out.println("게시물 상세보기중 예외발생");
		}
		
		return dto;
	}
	public void updateVisitCount(String idx) {
		
			String query = " UPDATE board SET "
					+ " visitcount=visitcount+1 "
					+ " WHERE idx=? ";
			
			try {
				psmt= con.prepareStatement(query);
				psmt.setString(1, idx);
				psmt.executeQuery();
				
			}catch(Exception e) {
				System.out.println("게시물 조회수 증가 중 예외가 발생하였습니다.");
				e.printStackTrace();
			}
		}
}
