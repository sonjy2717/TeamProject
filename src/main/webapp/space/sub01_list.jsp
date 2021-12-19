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

<%
String idx = request.getParameter("idx");
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
	
	<thead>
	<tr class="success">
		<th class="text-center">번호</th>
		<th class="text-left"><a href="sub01_view.jsp">제목</a></th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
		<th class="text-center">첨부</th>
	</tr>
	</thead>
	
	<tbody>
	<!-- 리스트반복 -->
	
	<tr>
		<td class="text-center">번호</td>
		<td class="text-left"><a href="sub01_view.jsp">제목</a></td>
		<td class="text-center">작성자</td>
		<td class="text-center">작성일</td>
		<td class="text-center">조회수</td>
		<td class="text-center">첨부</td>
	</tr>
	<%
				if(boardLists.isEmpty()){
				%>
					<tr>
						<td colspan= "5" align = "center">
						등록된 게시물이 없습니다^^*
						</td>
					</tr>
				<%
				}
				else{
					int virtualNum = 0; //게시물의 출력번호
					int countNum=0;
					//확장 for문을 통해 List컬렉션에 저장된 레코드의 갯수만큼 반복한다.
					for(BoardDTO dto: boardLists)
					{
						//레코드 번호 설정
				%>
					<tr>
						<td class="text-center">1</td>
							<td class="text-left"><a href="sub01_view.jsp?idx=<%=dto.getIdx()%>"><%=dto.getTitle() %></a></td>
							<td class="text-center"><%=dto.getId() %></td>
							<td class="text-center"><%=dto.getPostdate() %></td>
							<td class="text-center"><%=dto.getVisitcount()%></td>
							<td class="text-center">첨부</td>
					</tr>
				<%
					}
				}
				%>
				
	</tbody>
	</table>
	
</div>

</body>
</html>