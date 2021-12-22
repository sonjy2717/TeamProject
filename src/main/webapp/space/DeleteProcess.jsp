<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="model1.board.BoardDAO"%>
<%@ page import ="model1.board.BoardDTO"%>
<%@ include file="./IsLoggedIn.jsp" %> <!-- 로그인 확인 -->

<%
//폼값 받기
String idx=request.getParameter("idx");

//DTO객체와 DB 연결 및 기존 게시물 가져오기
BoardDTO dto = new BoardDTO();
BoardDAO dao = new BoardDAO(application);
dto = dao.selectView(idx);
//세션 영역에 저장된 아이디를 문자열로 반환
//String sessionId = session.getAttribute("UserId").toString();
String sessionId = "test1";

int delResult = 0;
//현재 삭제하는 사람이 해당글의 작성자가 맞는지 확인
if(sessionId.equals(dto.getId())){
	dto.setIdx(idx);
	delResult = dao.deletePost(dto);
	dao.close();
	
	if(delResult == 1){
		//게시물 삭제에 성공하면 리스트로 이동한다.
		JSFunction.alertLocation("삭제되었습니다.", "./sub01.jsp",out); //실험용
	}
	else{
		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
}
else{
	JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
	return;
}
%>