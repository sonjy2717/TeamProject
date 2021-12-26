<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
String user_id = (String)session.getAttribute("user_id");
MemberDAO dao = new MemberDAO(application);
MemberDTO dto = dao.getMemberInfo(user_id);
%>


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
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				
				<script>
				function checkFrm(f){
					if(f.user_id.value==""){
						alert("아이디를 입력하세요.");
						f.user_id.focus();
						return false;
					}
					if(f.user_pw.value==""){
						alert("패스워드를 입력하세요.");
						f.user_pw.focus();
						return false;
					}
				}
				</script>
				
				<%
				if (session.getAttribute("user_id") == null)
				{
				%>
				<form name="loginFrm" method="post" action="../main/main.do" onsubmit="return checkFrm(this);">
				<div class="login_box01">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" name="user_id" value="${ loginId }" class="login_input01" /></li>
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" name="user_pw" value="" class="login_input01" /></li>
					</ul>
					<button type="submit"><img src="../images/login_btn.gif" class="login_btn01" /></button>
				</div>
				</form>
					<% 
					}
					else{
					%>
					<!-- 로그인 후 -->
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><%= dto.getName() %>님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<input type="image" onclick="location.href='../member/modify.jsp';" src="../images/login_btn04.gif" />
						<a href="../member/Logout.jsp"><img src="../images/login_btn05.gif" /></a>
					</p>
					<% 
			 		}
			 		%>
				
				<p style="text-align:center; margin-bottom:50px;"><a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
