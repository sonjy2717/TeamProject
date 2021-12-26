<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
//한글처리
request.setCharacterEncoding("UTF-8");


//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

String num = request.getParameter("tel1") + "-"
		+ request.getParameter("tel2") + "-"
		+ request.getParameter("tel3");

String phone_num = request.getParameter("mobile1") + "-"
		+ request.getParameter("mobile2") + "-"
		+ request.getParameter("mobile3");

String email = request.getParameter("email_1") + "@"
		+ request.getParameter("email_2");

String postcode = request.getParameter("zip1");

String basicadd = request.getParameter("addr1");
String detailadd = request.getParameter("addr2");

MemberDTO dto = new MemberDTO();

dto.setName(name);
dto.setId(id);
dto.setPass(pass);
dto.setNum(num);
dto.setPhone_num(phone_num);
dto.setEmail(email);
dto.setPostcode(postcode);
dto.setBasicadd(basicadd);
dto.setDetailadd(detailadd);
	
//DAO객체 생성 및 DB연결
MemberDAO dao = new MemberDAO(application);
//dto객체를 매개변수로 전달하여 레코드 insert 처리
int iResult = dao.insertWrite(dto);
//자원 해제
dao.close();

if(iResult == 1){
%>
<script>
	alert("회원가입 성공");
	location.href="login.jsp";
</script>
<%

}else{
%>
<script>
	alert("회원가입에 실패하였습니다.");
	location.href="join02.jsp";
</script>
<% 
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>