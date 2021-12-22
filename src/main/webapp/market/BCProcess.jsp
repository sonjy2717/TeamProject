<%@page import="utils.JSFunction"%>
<%@page import="application.form.appFormDTO"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="smtp.NaverSMTP" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 처리(insert)전 로그인 확인 -->
<%-- <%@ include file="./IsLoggedIn.jsp"%> --%>
<%
// 폼값 받기
String name = request.getParameter("name");
String bt_postcode = request.getParameter("address1");// 우편번호
String bt_basicadd = request.getParameter("address2");// 기본주소
String bt_detailadd = request.getParameter("address3");// 상세주소
String phone_num = request.getParameter("phone_num1")
	   			+"-"+ request.getParameter("phone_num2")
	   			+"-"+ request.getParameter("phone_num3");
String email = request.getParameter("email1")
				+"@"+  request.getParameter("email2");
String bc_type = request.getParameter("bc_type");
String bc_space = request.getParameter("bc_space");
String bc_date = request.getParameter("bc_date");
String regi_type = request.getParameter("regi_type");
String note = request.getParameter("note");

if(note==""){ note="없음";}

/*
//확인용
out.println("name="+ name +"<br>");
out.println("address="+ bt_postcode +"<br>"+ bt_basicadd +"<br>"+ bt_detailadd +"<br>");
out.println("phone_num="+ phone_num +"<br>");
out.println("email="+ email +"<br>");
out.println("bc_type="+ bc_type +"<br>");
out.println("bc_space="+ bc_space +"<br>");
out.println("bc_date="+ bc_date +"<br>");
out.println("regi_type="+ regi_type +"<br>");
out.println("note="+ note);
*/

// DTO객체 생성
appFormDTO dto = new appFormDTO();
dto.setName(name);
dto.setBc_postcode(Integer.parseInt(bt_postcode));
dto.setBc_basicadd(bt_basicadd);
dto.setBc_detailadd(bt_detailadd);
dto.setPhone_num(phone_num);
dto.setEmail(email);
dto.setBc_type(bc_type);
dto.setBc_space(Integer.parseInt(bc_space));
dto.setBc_date(bc_date);
dto.setRegi_type(regi_type);
dto.setNote(note);

/* 이메일 전송 */
Map<String, String> emailInfo = new HashMap<String, String>();
////////////////////////////////차후 관리자 이메일로 변경
emailInfo.put("from", "bbi-bbi-@naver.com");
emailInfo.put("to", dto.getEmail());
emailInfo.put("subject", "[마포구립장애인 직업재활센터] 블루클리닝 신청정보 안내");

String content
	= "<strong>["+ dto.getName() +"님의 블루클리닝 "+ dto.getRegi_type() +" 내역]</strong><br><br>"
	+ "<strong>일시 : </strong>"+ dto.getBc_date() +"<br>"
	+ "<strong>장소 : </strong>"+ dto.getBc_basicadd() +"("+ dto.getBc_postcode() +") "+ dto.getBc_detailadd() +"<br>"
	+ "<strong>평수 : </strong>"+ dto.getBc_space() +"평<br>"
	+ "<strong>청소종류 : </strong>"+ dto.getBc_type() +"<br>"
	+ "<strong>특이사항 : </strong>"+ dto.getNote();

String htmlContent = "";
try {
	String templatePath = application.getRealPath("/emailSend/BCMailForm.html");
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
	JSFunction.alertLocation("접수가 완료되었습니다.", "../main/main.jsp", out);
}
catch (Exception e) {
	JSFunction.alertBack("접수에 실패했습니다.", out);
	e.printStackTrace();
}
%>