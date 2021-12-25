package model1.board;

import common.JDBConnect;

import java.util.HashMap;
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
		if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
        	stmt = con.createStatement();
        	rs = stmt.executeQuery(query);
        	rs.next();
        	totalCount = rs.getInt(1);
        }
        catch (Exception e) {
        	System.out.println("게시물 카운트 중 예외발생");
        	e.printStackTrace();
        }
        return totalCount;
	}
	
	public int selectCount2(Map<String, Object> map, String tname) {
		int totalCount = 0;
		String query =  "SELECT COUNT(*) FROM board WHERE tname ='"+tname+"'";
		if (map.get("searchWord") != null) {
            query += " AND " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
        	stmt = con.createStatement();
        	rs = stmt.executeQuery(query);
        	rs.next();
        	totalCount = rs.getInt(1);
        }
        catch (Exception e) {
        	System.out.println("게시물 카운트 중 예외발생");
        	e.printStackTrace();
        }
        return totalCount;
	}
	
	public List<BoardDTO> selectList(Map<String, Object> map ,String tname){  //모든게시판의 모든 게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		
		String query = "select * from (select * from board ";
		if(map.get("searchWord") != null) {
			query+=" where "+map.get("searchField")+" like '%"+map.get("searchWord")+"%' ";
		}
		
		query+=")board where tname = '"+tname+"'";
		
	
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
				dto.setSfile(rs.getString("sfile"));
				dto.setOfile(rs.getString("ofile"));
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	public List<BoardDTO> selectList2(Map<String, Object> map, String tName){ //선택한 게시판의 모든게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		String query =  "select * from ( ";
		
		if(map.get("searchWord") != null) {
			query += " select * from board where "+ map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query  += " )board where tname = '"+tName+"'";
		
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
				dto.setSfile(rs.getString("sfile"));
				dto.setOfile(rs.getString("ofile"));
				dto.setCalDate("caldate");
				
				System.out.println("파일명:"+rs.getString("sfile"));
				
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	public List<BoardDTO> selectListPage(Map<String,Object> map) {
		List<BoardDTO> board = new Vector<BoardDTO>();
		
		String query = " "
                + "SELECT * FROM ( "
                + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                + "        SELECT * FROM board ";
		// 검색어가 있는경우
        if (map.get("searchWord") != null)
        {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }

		query += "        ORDER BY idx DESC "
	               + "    ) Tb "
	               + " ) "
	               + " WHERE rNum BETWEEN ? AND ?";
		
		try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            rs = psmt.executeQuery();

            while (rs.next()) {
                BoardDTO dto = new BoardDTO();

                dto.setIdx(rs.getString(1));
                dto.setId(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setVisitcount(rs.getString(8));
                dto.setTname(rs.getString(9));

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return board;
	}
	
	public List<BoardDTO> selectListPage2(Map<String,Object> map, String tname) {
		
		List<BoardDTO> board = new Vector<BoardDTO>();
		
		String query = " select * from( "
				+ "select Tb.*, rownum rNum from( "
				+ "    select * from (select * from board";
		if(map.get("searchWord") != null) {
			query+=" where "+map.get("searchField")+" like '%"+map.get("searchWord")+"%' ";
		}
		
		query+=")board where tname='"+tname+"' order by idx desc) Tb) "
				+ "    where rNum >=? and rNum<=?";
		
	
		
		try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            rs = psmt.executeQuery();

            while (rs.next()) {
                BoardDTO dto = new BoardDTO();

                dto.setIdx(rs.getString(1));
                dto.setId(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setVisitcount(rs.getString(8));
                dto.setTname(rs.getString(9));

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return board;
	}
	
	public int insertWrite(BoardDTO dto, String tname) { //원하는 tName 게시판에 게시글 삽입
		//입력결과 확인용 변수
		int result = 0;
		
		try {
			
			String query = " INSERT INTO board ( "
					 + " idx, title ,content , id,visitcount, tname, ofile, sfile, caldate) "
					 + " VALUES ( "
					 + " seq_board_num.NEXTVAL, ?, ?, ?,0,?,?,?,?)";
			//동적쿼리문 실행을 위한 prepared객체 생성.
			psmt= con.prepareStatement(query);
			//순서대로 인파라미터 설정.
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, tname);
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getSfile());
			psmt.setString(7, dto.getCalDate());
			//쿼리문 실행 : 입력에 성공한다면 1이 반환된다. 실패시 0반환.
			result = psmt.executeUpdate();
			}
			catch(Exception e) {
				System.out.println("게시물 입력1 중 예외 발생");
				e.printStackTrace();
			}
		
		return result;
	}
	public int updateEdit(BoardDTO dto) { 
        int result = 0;   
        try {
            
            String query = "UPDATE board SET "
                         + " title=?, content=?, ofile=?, sfile=? "
                         + " WHERE idx=?";
            
           
            psmt = con.prepareStatement(query);
          
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setString(3, dto.getOfile());
            psmt.setString(4, dto.getSfile());
            psmt.setString(5, dto.getIdx());
            
           
            result = psmt.executeUpdate();
        } 
        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; 
    }
	
	public int updateEdit2(BoardDTO dto, String tName) { //원하는 tName 게시판에 게시글 수정
		//입력결과 확인용 변수
		int result = 0;
		
		try {
			
			String query = " UPDATE board SET title=?, content=?,ofile=?,sfile=? WHERE idx=? ";
			
			// prepared 객체 생성
            psmt = con.prepareStatement(query);
            //인파라미터 설정
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setString(3, dto.getOfile());
            psmt.setString(4, dto.getSfile());
            psmt.setString(5, dto.getIdx());
            // 쿼리 실행 
            result = psmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시물 수정2 중 예외 발생");
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
				 dto.setOfile(rs.getString("ofile"));
				 dto.setSfile(rs.getString("sfile"));
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
	public int deletePost(BoardDTO dto) { 
        int result = 0;

        try {
            String query = "DELETE FROM board WHERE idx=?"; 
            
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getIdx()); 
           
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; 
    }
	
	public List<BoardDTO> selectCal(Map<String, Object> map, String tName){ //선택한 게시판의 모든게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		//1.결과 레코드셋을 담기위한 리스트계열 컬렉션 생성
	    Map<String, BoardDTO> calendar = new HashMap<String, BoardDTO>();
	      
		String query =  "SELECT caldate, title FROM board WHERE tName ='"+tName+"' and caldate is not null";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
		
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();	
				
				System.out.println(rs.getString("title") );
				System.out.println(rs.getString("caldate") );
				String day = rs.getString("caldate");
				String day2 =day.substring(day.length()-2, day.length());
				System.out.println(day2);
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	public String selectCal3(Map<String, Object> map, String tName){ //선택한 게시판의 모든게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		//1.결과 레코드셋을 담기위한 리스트계열 컬렉션 생성
	    Map<String, BoardDTO> calendar = new HashMap<String, BoardDTO>();
	      
		String query =  "SELECT caldate, title FROM board WHERE tName ='"+tName+"' and caldate is not null";
		String title = "";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
		
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();	
				
				System.out.println(rs.getString("title") );
				System.out.println(rs.getString("caldate") );
				title = rs.getString("title") ;
				String day = rs.getString("caldate");
				String day2 =day.substring(day.length()-2, day.length());
				System.out.println(day2);
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return title;
	}
	
	public String selectCal4(Map<String, Object> map, String tName){ //선택한 게시판의 모든게시물 출력용
		List<BoardDTO> bbs =  new Vector<BoardDTO>();

		//1.결과 레코드셋을 담기위한 리스트계열 컬렉션 생성
	    Map<String, BoardDTO> calendar = new HashMap<String, BoardDTO>();
	      
		String query =  "SELECT caldate, title FROM board WHERE tName ='"+tName+"' and caldate is not null";
		String day = "";
		String day2 = "";
		String[] day3 = null;
		String day4="";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
		
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();	
				
				System.out.println(rs.getString("title") );
				System.out.println(rs.getString("caldate") );
				String title = rs.getString("title") ;
				day = rs.getString("caldate");
				day2 =day.substring(day.length()-2, day.length());
				System.out.println(day2);
				day3 = day.split("-");
				day4 = day3[0] + day3[1]+day3[2];
				System.out.println(day4);
				
				bbs.add(dto);
			}	
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return day;
	}
	
	

	public Map<String, BoardDTO> printCalTitle(String tName){
	      // Map (key, value)
	      //1.결과 레코드셋을 담기위한 리스트계열 컬렉션 생성
	      Map<String, BoardDTO> calendar = new HashMap<String, BoardDTO>();
	      
	      String query =  "SELECT idx, caldate, title FROM board WHERE tName ='"+tName+"' and caldate is not null";

	      try {
	         psmt = con.prepareStatement(query);
	
	         rs = psmt.executeQuery();
	         while(rs.next()){
	            System.out.println(rs.getString("caldate")+" "+rs.getString("title"));
	            
	            BoardDTO dto = new BoardDTO();
	            dto.setIdx(rs.getString("idx"));
	            dto.setTitle(rs.getString("title"));
	            dto.setCalDate(rs.getString("caldate"));
	            
	           
	            calendar.put(rs.getString("caldate"), dto);
	         }
	      }
	      catch(Exception e){
	         System.out.println("print Select시 예외발생");
	         e.printStackTrace();
	      }
	      return calendar;
	   }
	
}
