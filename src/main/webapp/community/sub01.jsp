<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<head>
<!-- 다운로드 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
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
			</div>
			<!-- 검색 -->
	        <div class="row">
	            <form class="mt-3" method="get" action="../community/list.do?tname=step">
	                <div class="input-group mb-3 ms-auto" style="width: 400px;">
	                    <select name="searchField" class="form-control">
	                         <option value="title">제목</option>    <!-- 여기에 value에 값이 있어야지 searchWord로 검색했을때 값들이 나온다. -->
	                         <option value="content">내용</option>
	                         <option value="id">작성자</option>
                     	</select>
                     	<input type="text" name="searchWord" class="form-control" placeholder="Search" style="width: 200px;">
                     	<button class="btn btn-danger" type="submit">
	                    	<i class="bi-search" style="font-size: 1rem; color: white;"></i>
	                    </button>
                    </div>
                </form>
            </div>
			<!-- 게시판리스트부분 -->
			<div class="row">
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
					<th class="text-left">제목</th>
					<th class="text-center">작성자</th>
					<th class="text-center">작성일</th>
					<th class="text-center">조회수</th>
					<th class="text-center">첨부</th>
				</tr>
				</thead>
			<c:choose>    
			    <c:when test="${ empty boardLists }">  <!-- 게시물이 없을 때 -->
			        <tr>
			            <td colspan="6" align="center">
			                등록된 게시물이 없습니다^^*
			            </td>
			        </tr>
			    </c:when>
			    <c:otherwise>  <!-- 출력할 게시물이 있을때 -->
			        <c:forEach items="${ boardLists }" var="row" varStatus="loop">    
			        <tr align="center">
			            <td>
			            	<!--  
			            	가상번호 계산하기
			            	=>  게시물수 - (((페이지번호-1) * 페이지당 게시물수) + 해당루프의index)
			            		index는 0부터 시작한다. 
			            	-->   
			                ${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index)}   
			            </td>
			            <td align="left"><!-- 제목 -->   
			                <a href="../community/view.do?tname=step&idx=${ row.idx }">${ row.title }</a> 
			            </td> 
			            <td>${ row.id }</td><!-- 작성자 -->  
			            <td>${ row.postdate }</td><!-- 작성일 -->  
			            <td>${ row.visitcount }</td><!-- 조회수 -->  
			            <td><!-- 첨부파일 -->   
			            <c:if test="${ not empty row.ofile }">
			                <a href="../community/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">
			                <span class="material-icons">save</span></a>
			            </c:if>
			            </td>
			        </tr>
			        </c:forEach>        
			    </c:otherwise>    
				</c:choose>
			    </table>
				<div class="mb-3" style="padding-right:50px;">
					<div class="col d-flex justify-content-end" style="margin-left: 650px;">
						<button type="button" class="btn btn-danger btn-sm"
							onclick="location.href='../community/write.do?tname=step';">글쓰기</button>
					</div>
					<!-- 페이징 처리 -->
					<div class="row mt-5">
					    <!-- <div class="col">
					        <ul class="pagination justify-content-center">
					            <li class="page-item"><a class="page-link" href="#">
					                <i class="bi-skip-backward-fill" style="font-size: 1rem;"></i>
					        </a></li>
					        <li class="page-item"><a class="page-link" href="#">
					            <i class="bi-skip-start-fill" style="font-size: 1rem;"></i>
					        </a></li>
					        <li class="page-item active"><a class="page-link" href="#">1</a></li>
					        <li class="page-item"><a class="page-link" href="#">2</a></li>
					        <li class="page-item"><a class="page-link" href="#">3</a></li>
					        <li class="page-item"><a class="page-link" href="#">
					            <i class="bi-skip-end-fill" style="font-size: 1rem;"></i>
					        </a></li>
					        <li class="page-item"><a class="page-link" href="#">
					            <i class="bi-skip-forward-fill" style="font-size: 1rem;"></i>
					        </a></li>
					    	</ul>
						</div> -->
    			</div>
					${ map.pagingImg }
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
