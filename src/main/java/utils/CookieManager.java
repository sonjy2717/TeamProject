package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager { 
	//쿠키생성 
	public static void makeCookie(HttpServletResponse response, String cName,
			String cValue, int cTime) {
		Cookie cookie = new Cookie(cName, cValue); 
		cookie.setPath("/");				
		cookie.setMaxAge(cTime);				
		response.addCookie(cookie);				  
	}
	//쿠키값읽기
	public static String readCookie(HttpServletRequest request,String cName) {
		String cookieValue = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie c : cookies) { 
				String cookieName = c.getName(); 
				if(cookieName.equals(cName)) {  
					cookieValue = c.getValue(); 
				}
			}
		}
		return cookieValue; 
	}
	//쿠키 삭제
	public static void deleteCookie(HttpServletResponse response, String cName) {
		makeCookie(response, cName, "", 0);
	}
}
