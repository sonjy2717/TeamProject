<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>

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
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
				</div>
			<div>

<form name= "writeFrm" enctype="multipart/form-data">
	<table class="table table-bordered">
	
	<input type="hidden" name="tname" value="step"/>
	<colgroup>
		<col width="15%"/>
		<col width="30%"/>
		<col width="15%"/>
		<col width="15%"/>
		<col width="15%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">작성자</th>
			<td>
				${ dto.id }
			</td>
			<th class="text-center" 
				style="vertical-align:middle;">작성일</th>
			<td>
				${ dto.postdate }
			</td>
			<th class="text-center" 
				style="vertical-align:middle;">조회수</th>
			<td>
				${ dto.visitcount }
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">제목</th>
			<td colspan="5">
				${ dto.title }
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">내용</th>
			<td colspan="5">
				${ dto.content }
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">첨부파일</th>
			<td colspan="5">
				<c:if test="${ not empty row.ofile }">
					<%-- <img src="../Uploads/${ dto.sfile }" width="100" height="100"> --%>
					<a href="../community/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">[다운로드]</a>
				</c:if>
			</td>
		</tr>
	</tbody>
	</table>

	<div class="row mb-3">
		<div class="col d-flex justify-content-end">
			<!-- 각종 버튼 부분 -->
			<!-- 수정버튼 -->
			<%-- <button type="button" class="btn btn-primary btn-sm" onclick="location.href='Edit.jsp?idx=<%=dto.getIdx()%>&tname=<%=tname%>';">수정하기</button> --%>
			<!-- <button type="button" class="btn btn-success btn-sm" onclick="deletePost();">삭제하기</button> -->	
			<button type="button" class="btn btn-danger btn-sm"
				onclick="location.href='../community/edit.do?tname=step';">수정하기</button>
			&nbsp;
			<button type="button" class="btn btn-primary btn-sm" 
				onclick="location.href='../community/list.do?tname=step';">목록보기</button>
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