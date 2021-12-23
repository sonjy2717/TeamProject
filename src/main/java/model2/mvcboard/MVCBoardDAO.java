package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool {
	public MVCBoardDAO() {
		super();
	}
//	[List]
	// 게시물 개수 카운트
	public int selectCount(Map<String, Object> map, String tname) {
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
	// 현재 페이지에 출력할 게시물을 얻어옴
	public List<MVCBoardDTO> selectListPage(Map<String,Object> map, String tname) {
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		String query = " "
                + "SELECT * FROM "
                + "		( SELECT Tb.*, ROWNUM rNum FROM "
                + "			( SELECT * FROM board WHERE tname=?";
		// 검색어가 있는경우
        if (map.get("searchWord") != null)
        {
            query += " AND " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        	query += "        ORDER BY idx DESC "
	               + "    ) Tb "
	               + " ) "
	               + " WHERE rNum BETWEEN ? AND ?";
		
		try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, tname);
            psmt.setString(2, map.get("start").toString());
            psmt.setString(3, map.get("end").toString());
            rs = psmt.executeQuery();

            while (rs.next()) {
                MVCBoardDTO dto = new MVCBoardDTO();

                dto.setIdx(rs.getString(1));
                dto.setId(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setVisitcount(rs.getString(8));
                dto.setTname(rs.getString(9));
                dto.setRnum(rs.getString(10));

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return board;
	}
	
//	[Write]
	//새로운 게시물에 대한 입력처리
	public int insertWrite(MVCBoardDTO dto, String tname) {
		int result = 0;
		
		try {
			String query = "INSERT INTO board ( "
					+ " idx, id, title, content, ofile, sfile, tname) "
					+ " VALUES ( "
					+ " seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, tname);
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
//  [View]
	//주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환한다.
	public MVCBoardDTO selectView(String idx) {
		MVCBoardDTO dto = new MVCBoardDTO(); //DTO 객체 생성
		String query = "SELECT * FROM board WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if (rs.next()) { //결과를 DTO에 저장
				dto.setIdx(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setVisitcount(rs.getString(8));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	//주어진 일련번호에 해당하는 게시물의 조회수를 1 증가 시킨다.
	public void updateVisitCount(String idx) {
		String query = "UPDATE board SET "
				+ " visitcount = visitcount + 1 "
				+ " WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
}
