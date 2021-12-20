<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- 글쓰기 페이지 진입전 로그인 확인 -->
<%@ include file="./IsLoggedIn.jsp" %>
<%@ page import ="model1.board.BoardDAO"%>
<%@ page import ="model1.board.BoardDTO"%>
<%
String idx = request.getParameter("idx"); //게시물의 일련번호
BoardDAO dao = new BoardDAO(application); //DB연결
BoardDTO dto = dao.selectView(idx);	//게시물조회
//세션영역에 저장된 회원아이이디를 얻어와서 문자열의 형태로 변환
//String sessionId = session.getAttribute("UserId").toString();
String sessionId = "test1";
dto.setId("test1"); //수정을 위한 임의 설정. 나중에 삭제해야함.
dto.setIdx(idx); //여기랑 EditProcess.jsp에 둘다 dto.set(idx);가 있어야지 idx가 제대로 넘어가면서 제대로 실행됨.
//밑의 form태그의 hidden에서  name="idx" value="<%=dto.getIdx() ~ 이부분에서 set하여 get으로 넘기기 위함.

/*
본인이 작성한 글이 아니어도 URL패턴을 분석하면 수정페이지로 진입할 수 
있으므로 페이지 진입전 본인 확인을 추가로 하는 것이 안전하다.
*/
if(!sessionId.equals(dto.getId())){
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>

<script type = "text/javascript">
function validateForm(form){
	if(form.title.value==""){
		alert("제목을 입력해주세요.");
		form.title.focus();
		return false;
	}
	if(form.content.value==""){
		alert("내용을 입력해주세요.");
		form.content.focus();
		return false;
	}
}
</script>
</head>
<body>

<form name="writeFrm" method= "post" action="EditProcess.jsp"
	onsubmit="return validateForm(this);">
	<!-- 게시물의 일련번호인 idx를 서버로 전송하기 위해 hidden 타입의 입력상자가 필요하다. -->
	<input type="hidden"  name="idx" value="<%=dto.getIdx() %>"/>  
	<table border= "1" width= "90%">
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name="title" style="width: 90%;" value="<%=dto.getTitle() %>"  />
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea name="content" style="width: 90%; height: 100px;"><%=dto.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align = "center">
			<button type="submit">수정완료</button>
			<button type="reset">다시입력</button>
			<button type="button" onclick="location.href='List.jsp';">목록보기</button>
			</td>
		</tr>	
	</table>
</form>
</body>
</html>