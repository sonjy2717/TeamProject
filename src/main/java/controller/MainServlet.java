package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import membership.MemberDAO;
import membership.MemberDTO;
import utils.CookieManager;

public class MainServlet extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    
    	String cName = CookieManager.readCookie(req, "loginId");
    	req.setAttribute("loginId", cName);
    	
    	
    	//리퀘스트 영역에 속성값을 저장한다. 
        req.setAttribute("message", "justcoding");
        //View에 해당하는 JSP페이지로 포워드 한다. 
        req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
        
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    	String user_id = req.getParameter("user_id");
    	String user_pw = req.getParameter("user_pw");
    	String save_check = req.getParameter("save_check");
    	System.out.println("아이디:"+user_id+"비밀번호:"+user_pw);

    	MemberDAO dao = new MemberDAO();
    	MemberDTO dto = dao.getMemberDTO(user_id, user_pw);
    	
    	HttpSession session = req.getSession();
    	
    	if(dto.getId() != null) {
    		session.setAttribute("user_id", dto.getId());
    		session.setAttribute("user_pw", dto.getPass());
    		
    		/*
    		로그인에 성공하고
    			체크한 경우 : 쿠키 생성
    			체크를 해제한 경우 : 쿠키 삭제
    		 */
    		CookieManager.makeCookie(resp, "loginId", user_id, 86400);
    		
    	
	    
    		resp.sendRedirect("./main.do");
    	}
    	else {    		    
    		CookieManager.deleteCookie(resp, "loginId");
    		resp.sendRedirect("./main.do");
    	}   	
    }
}
