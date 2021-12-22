<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
	//회원정보 입력 확인
	var validateForm1 = function(frm) {
		if(frm.name1.value==''){
            alert('이름을 입력하세요');
            frm.name1.focus();
            return false;
        }
		if(frm.email1.value==''){
            alert('이메일를 입력하세요');
            frm.email1.focus();
            return false;
        }
		
	}
	var validateForm2 = function(frm) {
		if(frm.id.value==''){
            alert('아이디를 입력하세요');
            frm.id.focus();
            return false;
        }
		if(frm.name1.value==''){
            alert('이름을 입력하세요');
            frm.name1.focus();
            return false;
        }
		if(frm.email1.value==''){
            alert('이메일를 입력하세요');
            frm.email1.focus();
            return false;
        }
		
	}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
				<form action="loginSearch_Process.jsp" method="post" name="findFrm"
				onsubmit="return validateForm1(this);" style="float: left;">
					<div class="id_box" >
						<ul>
							<li><input type="text" name="name1" value="" class="login_input01" /></li>
							<li><input type="text" name="email1" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="id_btn" name="find"/></a>
						<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
				</form>
				<div class="idpw_box">
				<form action="loginSearch_Process.jsp" method="post" name="findFrm"
				onsubmit="return validateForm2(this);">
					<div class="pw_box" >
						<ul>
							<li><input type="text" name="id" value="" class="login_input01" /></li>
							<li><input type="text" name="name1" value="" class="login_input01" /></li>
							<li><input type="text" name="email1" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="pw_btn" />
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
