package model2.shopping;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;

public class ShoppingDAO extends JDBConnect {
	
	//검색 조건에 맞는 게시물의 개수를 반환한다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM management";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<ShoppingDTO> selectListPage(Map<String, Object> map) {
		List<ShoppingDTO> board = new Vector<ShoppingDTO>();
		
		String query = " "
				+ "SELECT * FROM ( "
				+ " 	SELECT Tb.*, ROWNUM rNum FROM ( "
				+ "			SELECT * FROM management "
				+ "		ORDER BY idx DESC "
				+ "		) Tb "
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				ShoppingDTO dto = new ShoppingDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setPrice(rs.getInt(3));
				dto.setPoint(rs.getInt(4));
				dto.setCount(rs.getInt(5));
				
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
