<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
	session영역에 저장된 인증관련 속성값이 있는지 확인하여 
	만약 없다면 로그인 페이지로 자동 이동 한다. 
*/
if (session.getAttribute("user_id") == null) {
	//자바스트립트를 사용하기 위한 유틸리티 클래스를 이용하여 경고창과 페이지이동을 처리함.
	JSFunction.alertLocation("로그인 후 이용해주십시오.",
                             "../member/login.jsp", out); 
	
	
	//만약 이 코드가 있다면 위의 JS코드는 실행되지 않는다. 
	//response.sendRedirect("List.jsp");    
	/*
	JSP파일에서 return을 사용하는 것은 _jspService()메서드의 실행을
	중지하겠다는 의미를 가지고 있다. 또한 Javascript보다 JSP코드의 실행이
	우선순위가 높으므로 정상적인 실행을 위해 return을 기술하는것이 좋다. 
	*/
	return; 
}
%>