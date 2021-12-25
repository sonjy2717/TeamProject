<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="./IsLoggedIn.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<script type = "text/javascript">
<%
String tname= request.getParameter("tname");
%>
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
				
				<%} else if(tname.equals("사진")){
				%>
				<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				<%}
				%>
				</div>
				<div>


				<form name="writeFrm" enctype="multipart/form-data" method= "post" action="WriteProcess.jsp" onsubmit="return validateForm(this);">
				<input type="hidden" name="tname" value= "<%=tname %>" />
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
							<input type="text" name="title" class="form-control" />
						</td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">내용</th>
						<td>
							<textarea rows="10" name="content" class="form-control"></textarea>
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