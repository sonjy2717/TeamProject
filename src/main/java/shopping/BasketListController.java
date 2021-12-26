package shopping;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model2.shopping.BasketDTO;
import model2.shopping.ShoppingDAO;
import utils.JSFunction;

@WebServlet("/market/basket.do")
public class BasketListController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		ShoppingDAO dao = new ShoppingDAO();
		BasketDTO dto = new BasketDTO();
		
		String id = (String)session.getAttribute("user_id");
		String count = req.getParameter("count");
		String idx = req.getParameter("idx");
		String price = req.getParameter("price");
		
		if (count == null) count = "1";
		
		dto.setIdx(idx);
		dto.setId(id);
		dto.setPrice(price);
		dto.setCount(count);
		
		int update = dao.updateCount(idx, id);
		if (update >= 1) { 
			System.out.println("UPDATE 성공");
		} 
		else {
			System.out.println("항목 없음"); 
		}
		
		if (update < 1) {
			int insert = dao.insertBasket(dto);
			if (insert >= 1) { 
				System.out.println("INSERT 성공"); 
			} 
			else {
				System.out.println("INSERT 실패"); 
			}
		}
		
		dao.close();
		
		resp.sendRedirect("basket.do?id=" + id);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ShoppingDAO dao = new ShoppingDAO();
		
		String id = req.getParameter("id");
		
		List<BasketDTO> list = dao.showBasketList(id);
		
		int total = dao.basketTotal(id);
		dao.close();
		
		req.setAttribute("total", total);
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/market/basket.jsp").forward(req, resp);
	}
}
