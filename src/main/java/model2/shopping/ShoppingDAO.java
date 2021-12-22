package model2.shopping;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;

public class ShoppingDAO extends JDBConnect {
	
	//검색 조건에 맞는 게시물의 개수를 반환한다.
	public int selectCount() {
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
	
	public List<ManagementDTO> selectListPage(Map<String, Object> map) {
		List<ManagementDTO> board = new Vector<ManagementDTO>();
		
		String query = " "
				+ "SELECT * FROM "
				+ "    ( SELECT Tb.*, ROWNUM rNum FROM "
				+ "        ( SELECT idx, img, name, price, "
				+ "        point, exp FROM management ORDER BY idx DESC ) Tb ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				ManagementDTO dto = new ManagementDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setPoint(rs.getString(5));
				dto.setExp(rs.getString(6));
				
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return board;
	}
	
	public List<ManagementDTO> selectList() {
		List<ManagementDTO> board = new Vector<ManagementDTO>();
		
		String query = " "
				+ " SELECT * FROM ( "
				+ "    SELECT Tb.* FROM ( "
				+ "        SELECT idx, img, name, price, point "
				+ " FROM management ORDER BY idx DESC) Tb )";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				ManagementDTO dto = new ManagementDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setPoint(rs.getString(5));
				
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return board;
	}
	
	//주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환한다.
	public ManagementDTO selectView(String idx) {
		ManagementDTO dto = new ManagementDTO(); //DTO 객체 생성
		String query = "SELECT idx, img, name, price, "
				+ " point, exp FROM management "
				+ " WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if (rs.next()) { //결과를 DTO에 저장
				dto.setIdx(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setPoint(rs.getString(5));
				dto.setExp(rs.getString(6));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	//장바구니 테이블에 객체 저장
	public int insertBasket(BasketDTO dto) {
		int result = 0;
		
		String query = "INSERT INTO basket VALUES (?, ?, ?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getIdx());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getPrice());
			psmt.setString(4, dto.getCount());
			psmt.setInt(5, Integer.parseInt(dto.getPrice()) *
					Integer.parseInt(dto.getCount()));
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("장바구니에 삽입 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//장바구니 리스트 출력
	public List<BasketDTO> showBasketList(String id, String idx) {
		List<BasketDTO> list = new Vector<BasketDTO>();
		String query = "SELECT img, name, M.price, point, count, total "
				+ "    FROM management M INNER JOIN basket B "
				+ "    ON M.idx = B.idx "
				+ " WHERE B.idx=? AND id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.setString(2, id);
			rs = psmt.executeQuery();
			
			while (rs.next()) { //결과를 DTO에 저장
				BasketDTO dto = new BasketDTO(); //DTO 객체 생성
				
				dto.setCount(rs.getString(1));
				
				list.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("장바구니 가져오기 중 예외 발생");
			e.printStackTrace();
		}
		
		return list;
	}
	
	//아이디와 상품의 일련번호가 같을시 장바구니의 수량을 한개 증가
	public int updateCount(String idx, String id) {
		int result = 0;
		
		String query = "UPDATE basket SET "
				+ " count = count + 1 "
				+ " WHERE idx=? AND id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.setString(2, id);
			psmt.executeQuery();
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("장바구니 수량 증가 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
}
