package utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class JSFunction {
	
	// Javascript함수를 통해 경고창을 띄우고 원하는 페이지로 이동한다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		/*
			Java클래스에서는 JSP의 내장객체를 사용할 수 없으므로
			반드시 매개변수로 전달받은 뒤 사용해야 한다.
			
		 - 여기서는 화면에 문자열을 출력하기 위한 out내장객체를
		   JspWriter타입으로 받은 후에 사용하고 있다.
		 */
		try {
			String script = ""
						+ "<script>"
						+ "	   alert('"+ msg +"');"
						+ "    location.href='"+ url +"';"
						+ "</script>";
			// 스크립트 문자열을 웹브라우저에 출력한다.
			out.println(script);
		}
		catch(Exception e) {}
	}
	
	// JS를 통해 경고창을 띄우고 이전 페이지로 이동한다.
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
						+ "<script>"
						+ "	   alert('"+ msg +"');"
						+ "    history.back();"
						+ "</script>";
			out.println(script);
		}
		catch(Exception e) {}
	}
	
	
	/*
		앞의 2개의 메소드는 JSP에서 out내장객체를 통해
		Javascript함수를 실행한다.
		아래는 서블릿에서 함수를 실행하기 위해 작성되므로
		out내장객체 대신 response내장객체를 추가하면 된다.
	 */
	public static void alertLocation(HttpServletResponse resp, String msg, String url) {
		
		try {
			//컨텐츠 타입 설정
			resp.setContentType("text/html;charset=UTF-8");
			// PrintWriter객체를 통해 스크립트를 서블릿에서 직접 출력한다.
			PrintWriter writer = resp.getWriter();
			String script = ""
						+ "<script>"
						+ "	   alert('"+ msg +"');"
						+ "    location.href='"+ url +"';"
						+ "</script>";
			writer.println(script);
		}
		catch(Exception e) {}
	}
	public static void alertBack(HttpServletResponse resp, String msg) {
		try {
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
						+ "<script>"
						+ "	   alert('"+ msg +"');"
						+ "    history.back();"
						+ "</script>";
			writer.println(script);
		}
		catch(Exception e) {}
	}
}
