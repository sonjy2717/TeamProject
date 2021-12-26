<%@page import="utils.BoardPage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<style>
 .main_photo_list{
 margin-right:5px;
 }
</style>
<%
String tname = "사진";
BoardDTO dto2 = new BoardDTO();

dto2.setTname(tname);

BoardDAO dao = new BoardDAO(application);


String idx = request.getParameter("idx");
// String tnameB = request.getParameter("tname"); 아직까지는 사용되지 않는 문구임
Map<String, Object> param = new HashMap<String, Object>();

//검색 파라미터를 request 내장 객체를 통해 얻어온다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//검색어가 있는 경우에만..
if(searchWord != null){
	//Map컬렉션에 파라미터 값을 추가한다.
	param.put("searchField",searchField); //검색필드명(title, content등)
	param.put("searchWord",searchWord);// 검색어
}

int totalCount = dao.selectCount2(param,tname);
//int totalCount = dao.selectCount(param);

//List<BoardDTO> boardLists = dao.selectList(param);
/*** 페이지 처리 start ***/
//컨텍스트 초기화 파라미터를 얻어온 후 사칙연산을 위한 정수로 변경한다.
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage =  Integer.parseInt(application.getInitParameter("POSTS_PER_BLOCK"));
//전체 페이지 수를 계산한다.
int totalPage= (int)Math.ceil((double)totalCount/pageSize);
/*
목록에 첫 진입시에는 페이지 관련 파라미터가 없으므로 무조건 1PAGE로 지정한다.
만약 pageNum이 있다면 파라미터를 받아와서 정수로 변경한 후 페이지수로 지정한다.
*/
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if(pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

//게시물의 구간을 계산한다.
int start = (pageNum - 1) * pageSize + 1; //구간의 시작
int end = pageNum * pageSize;//구간의 끝

param.put("start", start); //Map컬렉션에 저장 후 DAO로전달함
param.put("end", end);
/**페이지 처리 end**/

//List<BoardDTO> boardLists = dao.selectList(param,tname);
//List<BoardDTO> boardLists = dao.selectList2(param, tname);
//List<BoardDTO> boardLists = dao.selectListPage(param);
List<BoardDTO> boardLists = dao.selectListPage2(param, tname);
dao.close();
%>
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
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
			</div>
	<!-- 검색 -->
       <div class="row">
            <form method="get" action="../space/sub04.jsp">
                <div class="input-group ms-auto" style="width: 400px; height:30px; margin-bottom: 20px">
                    <select name="searchField" class="form-control">
                         <option  ${request.getParameter(searchField) == "title" ? "selected": ""}   value="title">제목</option>    <!-- 여기에 value에 값이 있어야지 searchWord로 검색했을때 값들이 나온다. -->
                         <option ${request.getParameter(searchField) == "content" ? "selected": ""}  value="content">내용</option>
                         <option ${request.getParameter(searchField) == "id" ? "selected": ""} value="id">작성자</option>
                     </select>
                     <input type="text" name="searchWord" value="${request.getParameter("searchWord")}"class="form-control" placeholder="Search" style="width: 200px;">
                     <button style="height:35px;" class="btn btn-success" type="submit">
                     <i class="bi-search" style="font-size: 1rem; color: white;"></i>
                     </button>
                </div>
            </form>
        </div>
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
					virtualNum = totalCount - (((pageNum-1) * pageSize) + countNum++);
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
	<!-- 페이지 번호 -->
    <div class="row mt-3">
        <div class="col">
        	<ul class="pagination justify-content-center">
                <%=BoardPage.pagingStr(totalCount, pageSize,
        				blockPage, pageNum, request.getRequestURI(),searchField,searchWord) %>
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
</html>
