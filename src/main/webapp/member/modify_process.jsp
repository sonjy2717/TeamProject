<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

//수정페이지에서 전송한 폼값 받기.

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

String phone_num = request.getParameter("mobile1") + "-"
		+ request.getParameter("mobile2") + "-"
		+ request.getParameter("mobile3");

String email = request.getParameter("email_1") + "@"
		+ request.getParameter("email_2");

String postcode = request.getParameter("zip1");

String basicadd = request.getParameter("addr1");
String detailadd = request.getParameter("addr2");

//DTO객체에 입력값 추가하기.
MemberDTO dto = new MemberDTO();

dto.setId(id);
dto.setPass(pass);
dto.setName(name);
dto.setPhone_num(phone_num);
dto.setEmail(email);
dto.setPostcode(postcode);
dto.setBasicadd(basicadd);
dto.setDetailadd(detailadd);

//DAO객체 생성 및 DB연결
MemberDAO dao = new MemberDAO(application);
//dto객체를 매개변수로 전달하여 수정처리
int affected = dao.updateEdit(dto);
//자원 해제
dao.close();

if(affected == 1){
	//수정에 성공한 경우에는 수정된 내용을 확인하기 위해 상세보기 페이지로 이동
	JSFunction.alertLocation("회원정보가 수정되었습니다.", "modify.jsp", out);
}
else{
	//실패한 경우에는 뒤로 이동
	JSFunction.alertLocation("수정하기에 실패하였습니다..", "modify.jsp", out);
}
%>