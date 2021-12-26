<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>id_overapping.html</title>
<script>
function idUse(userid){
    /*
    부모창에서 팝업창을 열 때 readonly 속성이 적용되어 사용자는 내용을
    수정할 수 없지만, JS를 이용하면 수정할 수 있다.
    또한 opener속성을 통해 부모창으로 필요한 데이터를 전달할 수 있다.
    */
    opener.document.join.id.value = userid;
    self.close();
}
</script>
<script>

</script>
</head>
<body>
    <h2>아이디 중복확인 하기</h2>

    <h3>부모창에서 입력한 아이디 :<%=request.getParameter("id")%></h3>
<%
String formId = request.getParameter("id");
MemberDAO dao = new MemberDAO();

boolean result = dao.confirmId(formId);



/* if(request.getParameter("id").equals(kosmo)){ */
if(result==true){
%>
    <h3>아이디가 중복되므로 재입력해주세요.</h3>
    <form name="overlapFrm">
        <input type="text" name="id" size="20">
        <input type="submit" value="아이디 재검색" />
    </form>
<%
}
else{
%>
	<h3>사용 가능한 아이디 입니다.</h3>
	<button type="button" onclick="idUse('<%= request.getParameter("id") %>');">아이디 사용</button>
<%
}
%>
</body>
</html>