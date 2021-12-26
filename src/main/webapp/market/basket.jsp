<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../util/IsLoggedIn.jsp" %>

<script>
function edit(idx) {
	var form = document.frm;
	var choice_count = document.getElementById("count_"+idx).value;
	
	frm.basket_idx.value = idx;
	frm.basket_count.value = choice_count;
	
	if (choice_count <= 0) {
		alert("수량은 0개 이하로 설정할 수 없습니다.");
		return;
	}
	
	form.method = "post";
	form.action = "../market/edit.do?";
	form.submit();
}

function deleteList() {
	
}
</script>

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
				<form name="frm">
				<input type="hidden" name="basket_idx" value="" />
				<input type="hidden" name="basket_count" value="" />
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
					<c:when test="${ empty list }">
						<tr>
							<td colspan="9" align="center">
								장바구니가 비었습니다.
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ list }" var="row" varStatus="loop">
						<tr align="center">
							<td>
								<input type="checkbox" name="cake" value="" />
							</td>
							<td>
								<img src="../images/market/${ row.img }" width="50px"/>
							</td>
							<td>${ row.name }</td>
							<td>${ row.price }원</td>
							<td><img src="../images/market/j_icon.gif" />${ row.point }원</td>
							<td>
								<input type="number" id="count_${ row.idx }" value="${ row.count }" class="basket_num" style="width: 40px;"/>&nbsp;
								<img src="../images/market/m_btn.gif" onclick="edit('${ row.idx }');" />
							</td>
							<td>무료배송</td>
							<td>[무료]</td>
							<td><span>${ row.total }</span></td>
						</tr>
						</c:forEach>
					</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				</form>
				<button style="margin-top: 10px;" type="button" align="left" onclick="deleteList();">선택삭제</button>
				<p class="basket_text">
					합계 : ${ total }<span class="money"></span>
					<br /><br />
					<a href="../market/list.do"><img src="../images/market/basket_btn01.gif" /></a>&nbsp;
					<a href="../market/buy.do"><img src="../images/market/basket_btn02.gif" /></a>
				</p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
