package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool {
	public MVCBoardDAO() {
		super();
	}
	
	// 게시물 개수 카운트
	public int selectCount(Map<String, Object> map, String tname) {
		int totalCount = 0;
		String query =  "SELECT * FROM board WHERE tname ='"+tname+"'";
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
	
	// 현재 페이지에 출력할 게시물을 얻어옴
	public List<MVCBoardDTO> selectListPage(Map<String,Object> map, String tname) {
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		String query = " "
                + "SELECT * FROM "
                + "		( SELECT Tb.*, ROWNUM rNum FROM "
                + "			( SELECT * FROM board ";
		// 검색어가 있는경우
        if (map.get("searchWord") != null)
        {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' "
                   + " AND tname=?";
        }
		query += "        ORDER BY idx DESC "
	               + "    ) Tb "
	               + " ) "
	               + " WHERE rNum BETWEEN ? AND ?";
		
		try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            psmt.setString(3, tname);
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

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return board;
	}
}
