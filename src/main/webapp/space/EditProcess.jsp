<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ include file="./IsLoggedIn.jsp" %>  
<%
//폼값 받기
String idx= request.getParameter("idx");
String title = request.getParameter("title");
String content = request.getParameter("content");
String file = request.getParameter("file");
String tname= request.getParameter("tname");

//사용자가 입력한 폼값을 저장하기 위해 DTO객체 생성
BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setOfile(file);
dto.setIdx(idx); //여기서 setIdx를 해야지 넘겨받은 parameter를 통해 Edit와 EditProcess를 정상적으로 연결할 수 있다.


//세션영역에 저장된 회원 인증정보(아이디)를 가져와서 DTO에 저장한다.
//dto.setId(session.getAttribute("UserId").toString());

//DAO객체 생성 및 DB연결
BoardDAO dao = new BoardDAO(application);
int iResult= dao.updateEdit(dto);

//자원해제
dao.close();
//dto객체를 매개변수로 전달하여 레코드 insert 처리
if(iResult == 1){
	//글쓰기에 성공했다면 리스트(목록) 페이지로 이동한다.
	response.sendRedirect("./sub03.jsp"); //임의로 게시판 설정 
}else{
	//실패한 경우에는 글쓰기 페이지로 이동한다. 즉 뒤로 이동한다.
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>