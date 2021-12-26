<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>

<script>
function basket() {
	var form = document.frm;
	
	if (form.count.value <= 0) {
		alert("수량은 0개 이하로 설정할 수 없습니다.");
		form.count.focus();
		form.count.value = '1';
		return;
	}
	
	form.method = "post";
	form.action = "../market/basket.do";
	form.submit();
}
/* function buy() {
	var form = document.frm;
	
	if (form.count.value <= 0) {
		alert("수량은 0개 이하로 설정할 수 없습니다.");
		form.count.focus();
		return;
	}
	
	form.method = "post";
	form.action = "../market/buy.do";
	form.submit();
} */
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
				<input type="hidden" name="idx" value="${ dto.idx }" />
				<input type="hidden" name="price" value="${ dto.price }" />
				<div class="market_view_box">
					<div class="market_left">
						<img src="../images/market/${ dto.img }" width="300px" alt="이미지 입니당" />
						<p class="plus_btn"></p>
					</div>
					<div class="market_right">
						<p class="m_title">${ dto.name }
						<p>- ${ dto.exp }</p>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style">${ dto.price }원</dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd>${ dto.point }원</dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd>
										<input type="number" name="count" value="1" class="n_box" />
									</dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box">
							<img src="../images/market/m_btn01.gif" onclick="buy();" alt="바로구매" />
							&nbsp;&nbsp;
							<img src="../images/market/m_btn02.gif" onclick="basket();" alt="장바구니" />
						</p>
					</div>
				</div>
				<img src="../images/market/${ dto.img }" width="750px" alt="이미지 입니당" />
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
