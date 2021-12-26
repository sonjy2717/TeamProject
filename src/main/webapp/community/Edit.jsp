<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- 글쓰기 페이지 진입전 로그인 확인 -->
<%-- <%@ include file="./IsLoggedIn.jsp" %> --%>

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

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
				<c:choose>
				<c:when test="${ dto.getTname.equals('step') }">  <!-- 직원자료실인경우 -->
			        <img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
			    </c:when>
				<c:otherwise>
					<img src="../images/community/sub02_title.gif" alt="보호자 게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;보호자 게시판<p>
				</c:otherwise>
				</c:choose>
				</div>
			</div>


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
		<button type="submit" class="btn btn-danger">수정하기</button>
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