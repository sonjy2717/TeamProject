<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
 <!-- 글쓰기 페이지 진입전 로그인 확인 -->
<%@ include file="./IsLoggedIn.jsp" %>
<%@ page import ="model1.board.BoardDAO"%>
<%@ page import ="model1.board.BoardDTO"%>
<%
String idx = request.getParameter("idx"); //게시물의 일련번호
String tname = request.getParameter("tname"); //게시물의 게시판 이름
BoardDAO dao = new BoardDAO(application); //DB연결
BoardDTO dto = dao.selectView(idx);	//게시물조회
//세션영역에 저장된 회원아이이디를 얻어와서 문자열의 형태로 변환
//String sessionId = session.getAttribute("UserId").toString();
String sessionId = "test1";
dto.setId("test1"); //수정을 위한 임의 설정. 나중에 삭제해야함.
dto.setIdx(idx); //여기랑 EditProcess.jsp에 둘다 dto.set(idx);가 있어야지 idx가 제대로 넘어가면서 제대로 실행됨.
//밑의 form태그의 hidden에서  name="idx" value="<%=dto.getIdx() ~ 이부분에서 set하여 get으로 넘기기 위함.
dto.setTname(tname);
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
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
				<%
 if(tname.equals("공지")){
%>
<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
<%
 } else if(tname.equals("자유")){
%>
<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
<%
 } else if(tname .equals("정보")){
%>
<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>

<%
 }
%>
				</div>
				<div>


<form name="writeFrm"  enctype="multipart/form-data" method= "post" action="EditProcess.jsp" onsubmit="return validateForm(this);">
<input type="hidden"  name="idx" value="<%=dto.getIdx() %>"/> 
<input type="hidden" name="tname" value="<%=dto.getTname() %>" />
<input type="hidden" name="prevOfile" value="<%=dto.getOfile() %>" />
<input type="hidden" name="prevSfile" value="<%=dto.getSfile() %>" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;" >제목</th>
		<td>
			<input type="text" name="title" value=<%=dto.getTitle() %> class="form-control" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" name="content" class="form-control"><%=dto.getContent() %></textarea>
		</td>
	</tr>
	<%
		if(tname.equals("정보")|| tname.equals("사진")){
		%>
		<tr>
		<th class="text-center" 
					style="vertical-align:middle;">첨부파일</th>
			<td>
				<input type="file" name="attachedFile"/><br />
			</td>
		</tr>
					
		<%
	 } 
					%>
</tbody>
</table>

	<div class="row text-center" style="">
		<!-- 각종 버튼 부분 -->
		<div class="col d-flex justify-content-end">
		<button type="submit" class="btn btn-danger">전송하기</button>
		<button type="reset" class="btn btn-secondary">Reset</button>
		<button type="button" class="btn btn-warning" 
			onclick="location.href='ListSkin.jsp';">리스트보기</button>
			</div>
	</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>