<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		
		<img src="../images/market/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>선택</th>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>구매</th>
					</tr>
			<c:choose>
				<c:when test="${ empty boardLists }">
					<tr>
						<td colspan="6" align="center">
							등록된 상품이 없습니다.
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ boardLists }" var="row" varStatus="loop">
					<tr align="center">
						<td><input type="checkbox" name="cake" value="" /></td>
						<td><a href="../market/market_view.do"><img src="../images/market/img01.jpg" /></a></td>
						<td align="left">
							<a href="../market/market_view.do?name=${ row.name }">
								${ row.name }</a>
						</td>
						<td class="p_style">${ row.price }</td>
						<td><input type="number" name="count" value="${ row.count }" class="n_box" /></td>
						<td>
							<a href=""><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a>
							<br />
							<a href="basket.jsp"><img src="../images/market/btn02.gif" /></a>
						</td>
					</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
				</table>
				<div align="center" style="margin-top: 30px; font-size: 12pt;">
					${ map.pagingImg }
					<!-- <ul class="pagination">
					  <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
					  <li class="page-item"><a class="page-link" href="#">1</a></li>
					  <li class="page-item"><a class="page-link" href="#">2</a></li>
					  <li class="page-item"><a class="page-link" href="#">3</a></li>
					  <li class="page-item"><a class="page-link" href="#">Next</a></li>
					</ul> -->
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
