package shopping;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2.shopping.ShoppingDAO;
import model2.shopping.ManagementDTO;

@WebServlet("/market/view.do")
public class ViewController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ShoppingDAO dao = new ShoppingDAO();
		String idx = req.getParameter("idx");
		ManagementDTO dto = dao.selectView(idx);
		dao.close();
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/market/market_view.jsp").forward(req, resp);
	}
}
