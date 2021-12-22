package shopping;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2.shopping.BasketDTO;
import model2.shopping.ShoppingDAO;

@WebServlet("/market/basket.do")
public class BasketController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ShoppingDAO dao = new ShoppingDAO();
		BasketDTO dto = new BasketDTO();
		
		String idx = req.getParameter("idx");
		String id = req.getParameter("id");
		String price = req.getParameter("price");
		String count = req.getParameter("count");
		if (count == null) {
			count = "1";
		}
		dto.setIdx(idx);
		dto.setId(id);
		dto.setPrice(price);
		dto.setCount(count);
		
		int update = dao.updateCount(idx, id);
		if (update == 1) { 
			System.out.println("UPDATE 성공"); 
		} 
		else {
			System.out.println("항목 없음"); 
		}
		
		int insert = dao.insertBasket(dto);
		if (insert == 1) { 
			System.out.println("INSERT 성공"); 
		} 
		else {
			System.out.println("INSERT 실패"); 
		}
		
		List<BasketDTO> list = dao.showBasketList(id, idx);
		
		dao.close();
		
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/market/basket.jsp").forward(req, resp);
	}
}
