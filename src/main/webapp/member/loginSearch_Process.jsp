<%@page import="smtp.NaverSMTP"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String find = request.getParameter("find");
String id = request.getParameter("id");
String name = request.getParameter("name1");
String email = request.getParameter("email1");

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDTO memberDTO = null;
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

if(id==null){ //아이디 찾기	
	memberDTO = dao.getMemberInfo("", name, email);
	if(memberDTO.getId()==null){
		JSFunction.alertBack("귀하의 정보가 없습니다.", out);
		return;
	}
	dao.close();
	JSFunction.alertLocation("귀하의 아이디는 "+ memberDTO.getId() +" 입니다", "login.jsp", out);
}
 else if(!(id==null)){ //비번 찾기	
	memberDTO = dao.getMemberInfo(id, name, email);
	if(memberDTO.getPass()==null){
		JSFunction.alertBack("귀하의 정보가 없습니다.", out);
		return;
	}
	dao.close();
	//JSFunction.alertLocation("귀하의 비밀번호는 "+ memberDTO.getPass() +" 입니다", "login.jsp", out);
	JSFunction.alertLocation("귀하의 비밀번호를 이메일로 전송해드렸습니다.", "login.jsp", out);
	
	// DTO객체 생성
	/* MemberDTO dto = new MemberDTO(); */
	memberDTO.setName(name);
	memberDTO.setEmail(email);
	memberDTO.setId(id);
	
	
	/* 이메일 전송 */
	Map<String, String> emailInfo = new HashMap<String, String>();
	////////////////////////////////차후 관리자 이메일로 변경
	emailInfo.put("from", "bbi-bbi-@naver.com");
	emailInfo.put("to", memberDTO.getEmail()); 
	emailInfo.put("subject", "[마포구립장애인 직업재활센터] 비밀번호 확인 안내");

	String content
		= "<strong>["+ memberDTO.getName() +"님의 패스워드는"+ memberDTO.getPass() +" 입니다.]</strong><br><br>";

	String htmlContent = "";
	try {
		String templatePath = application.getRealPath("/emailSend/passMailForm.html");
		BufferedReader br = new BufferedReader(new FileReader(templatePath));
		
		String oneLine;
		while ((oneLine = br.readLine()) != null) {
	htmlContent += oneLine +"\n";
		}
		br.close();
	}
	catch(Exception e) {
		e.printStackTrace();
	}

	htmlContent = htmlContent.replace("__CONTENT__", content);
	out.println(htmlContent);

	emailInfo.put("content", htmlContent);
	emailInfo.put("format", "text/html;charset=UTF-8");

	try {
		NaverSMTP smtpServer = new NaverSMTP();
		smtpServer.emailSending(emailInfo);
		JSFunction.alertLocation("이메일전송이 완료되었습니다. 완료되었습니다.", "../main/main.jsp", out);
	}
	catch (Exception e) {
		JSFunction.alertBack("접수에 실패했습니다.", out);
		e.printStackTrace();
	}
}
%>