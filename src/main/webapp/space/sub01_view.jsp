<%@page import="java.net.URLEncoder"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>

<%
String idx = request.getParameter("idx");
String tname = request.getParameter("tname");
//DAO 객체 생성 및 DB연결
BoardDAO dao = new BoardDAO(application);
BoardDTO dto = dao.selectView(idx);
dto.setIdx(idx);
dao.updateVisitCount(idx);
dao.close();
%>
<script>
function deletePost(){
	var confirmed = confirm("정말로 삭제하시겠습니까?");
	if(confirmed){
		var form = document.writeFrm;
		form.method="post"; 
		form.action="DeleteProcess.jsp?idx=<%=dto.getIdx()%>";
		form.submit(); 	
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

<form name= "writeFrm" enctype="multipart/form-data">
	<table class="table table-bordered">
	
	<input type="hidden"  name="tname" value="<%=dto.getTname()%>"/>
	<colgroup>
		<col width="20%"/>
		<col width="30%"/>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">작성자</th>
			<td>
				<%=dto.getId() %>
			</td>
			<th class="text-center" 
				style="vertical-align:middle;">작성일</th>
			<td>
				<%=dto.getPostdate()%>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">이메일</th>
			<td>
				nakjasabal@naver.com
			</td>
			<th class="text-center" 
				style="vertical-align:middle;">조회수</th>
			<td>
				<%=dto.getVisitcount() %>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">제목</th>
			<td colspan="3">
				<%=dto.getTitle() %>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">내용</th>
			<td colspan="3">
				<%=dto.getContent() %>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">첨부파일</th>
			<td colspan="3">
				<%
				if(dto.getOfile() != null){
				%>
			
				<img src="../Uploads/<%= dto.getSfile() %>" width="100" height="100">
				<% 	
				}
				%>
			</td>
		</tr>
	</tbody>
	</table>

	<div class="row mb-3">
		<div class="col d-flex justify-content-end">
			<!-- 각종 버튼 부분 -->
			 <%
            if(session.getAttribute("user_id") != null
            && session.getAttribute("user_id").toString().equals(dto.getId())){
            %>   
			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='Edit.jsp?idx=<%=dto.getIdx()%>&tname=<%=tname%>';">수정하기</button>
			<button type="button" class="btn btn-success btn-sm" onclick="deletePost();">삭제하기</button>	
			<%
            }
			%>
			<button type="button" class="btn btn-warning btn-sm" 
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