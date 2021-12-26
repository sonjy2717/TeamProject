<%-- <%@page import="java.net.URLEncoder"%>
<%@page import="utils.BoardPage"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 부트스트랩의 link-href가 입력되어야 부트스트랩 구문 사용 가능 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
 .main_photo_list{
 margin-right:5px;
 }
</style>
<%
BoardDAO dao = new BoardDAO(application);
Map<String, Object> param = new HashMap<String, Object>();

//dao.practice(param,"1");
// List<BoardDTO> boardLists = dao.selectList(param); //모든게시판의 모든 게시물 출력용


String idx = request.getParameter("idx");
// String tnameB = request.getParameter("tname"); 아직까지는 사용되지 않는 문구임

int totalCount = dao.selectCount2(param,tname);
List<BoardDTO> boardLists = dao.selectList2(param, tname);
/*페이징 처리 start*/
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage =  Integer.parseInt(application.getInitParameter("POSTS_PER_BLOCK"));

//전체 페이지 수를 계산
int totalPage= (int)Math.ceil((double)totalCount/pageSize);

/*목록의 첫 진입시에는 페이지 관련 파라미터가 없으므로 무조건 1
그 이후 pageNum이 있다면 파라미터로 받아와서 정수로 변경한 후 페이지로 지정
*/
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if(pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

//게시물의 구간을 계산
int start = (pageNum - 1) * pageSize + 1; //구간의 시작
int end = pageNum * pageSize;//구간의 끝
param.put("start", start); //Map컬렉션에 저장 후 DAO로전달함
param.put("end", end);
/**페이지처리 end**/
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover" >
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="120px"/>
		<col width="120px"/>
		<col width="80px"/>
		<col width="50px"/>
	</colgroup>
	
		<%
		if(boardLists.isEmpty()){
		%>
		<tr>
		<td colspan= "5" align = "center">
				등록된 게시물이 없습니다^^*
		</td>
			</tr>
			<%
			}else{	
				int flagNum = 0;
				int virtualNum = 0; //게시물의 출력번호
				int countNum=0;
				//확장 for문을 통해 List컬렉션에 저장된 레코드의 갯수만큼 반복한다.a
				
				for(BoardDTO dto: boardLists){
					//레코드 번호 설정
					virtualNum = totalCount--;
				%>
				<%
					if(dto.getOfile()!=null){
				%>
					<div class="col-3">
					<a href="sub01_view.jsp?idx=<%=dto.getIdx()%>&tname=<%=tname%>"><img src="../Uploads/<%= dto.getSfile() %>" style= "border:1px solid #cecece; width:200; height:200"></a>
					</div>
						
				<% 	
					}
				%>
				<% 	
					}
				%>
				
				
				<%
				}
				%>
				
				
					
				

	
	</table>
</div>
<div class="row mb-3" style="padding-right:50px;">
	<div class="col d-flex justify-content-end">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
	
	<button type="button" class="btn btn-info"  onclick="location.href='sub01_write.jsp?tname=<%=tname%>';">글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	
	<button type="submit" class="btn btn-danger">전송하기</button> -->
	</div>
</div>
<div class="row text-center">
	<!-- 페이지번호 부분 -->
	<ul class="pagination">
		<li><span class="glyphicon glyphicon-fast-backward"></span></li>
		<li><a href="#">1</a></li>		
		<li class="active"><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>		
		<li><a href="#">5</a></li>
		<li><span class="glyphicon glyphicon-fast-forward"></span></li>
	</ul>	
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html> --%>