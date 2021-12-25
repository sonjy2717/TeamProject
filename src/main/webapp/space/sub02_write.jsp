<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<script>
<%
String idx = request.getParameter("idx");
//DAO 객체 생성 및 DB연결
BoardDAO dao = new BoardDAO(application);
BoardDTO dto = dao.selectView(idx);
dao.updateVisitCount(idx);

dao.close();
%>
$( function() {
	 $( "#datepicker" ).datepicker();
	 $( "#datepicker" ).datepicker("option", "dateFormat", "yy-mm-dd");
} );

function validateForm(form){
	if(form.datepicker.value==""){
		alert("날짜를 입력해주세요.");
		form.datepicker.focus();
		return false;
	}
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
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
				<div>


<form name="writeFrm"enctype="multipart/form-data" method= "post" action="WriteProcess.jsp" onsubmit="return validateForm(this);">
<input type="hidden" name="tname" value= "일정" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
					<tr>
						<th class="text-center" style="vertical-align:middle;">
						날짜:  </th>
						<td>
						<input type="text" name="datepicker" id="datepicker" class="form-control" />
						</td>
					</tr>
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
					
		</tbody>
</table>

	<div class="row text-center" style="">
		<!-- 각종 버튼 부분 -->
		<div class="col d-flex justify-content-end">
		<button type="submit" class="btn btn-danger">전송하기</button>
		<button type="reset" class="btn btn-secondary">Reset</button>
		<button type="button" class="btn btn-warning" 
			onclick="location.href='sub02.jsp';">리스트보기</button>
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