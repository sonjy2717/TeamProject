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
String name = request.getParameter("name");				// 고객명/회사명
String phone_num = request.getParameter("phone_num1")
	   			+"-"+ request.getParameter("phone_num2")
	   			+"-"+ request.getParameter("phone_num3");// 연락처
String email = request.getParameter("email1")
				+"@"+  request.getParameter("email2");	// 이메일
String ft_cake = request.getParameter("ft_cake");		//케익체험 인원수
String ft_cookie = request.getParameter("ft_cookie");	//쿠키체험 인원수
String ft_date = request.getParameter("ft_date");		//체험 희망날짜
String regi_type = request.getParameter("regi_type");	//접수종류 구분
String note = request.getParameter("note");				//기타 특이사항

if(note==""){ note="없음";}
if(ft_cake==""){ft_cake="0";}
if(ft_cookie==""){ft_cookie="0";}

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
dto.setPhone_num(phone_num);
dto.setEmail(email);
dto.setFt_cake(Integer.parseInt(ft_cake));
dto.setFt_cookie(Integer.parseInt(ft_cookie));
dto.setFt_date(ft_date);
dto.setRegi_type(regi_type);
dto.setNote(note);

/* 이메일 전송 */
Map<String, String> emailInfo = new HashMap<String, String>();
//////////////////////////////// 차후 from의 value값을 관리자 이메일로 변경해야 함
emailInfo.put("from", "bbi-bbi-@naver.com");
emailInfo.put("to", dto.getEmail());
//////////////////////////////// 차후 관리자 이메일로도 전송해야 함
// emailInfo.put("to", dto.getEmail());
emailInfo.put("subject", "[마포구립장애인 직업재활센터] 체험학습 신청정보 안내");

String content
	= "<strong>["+ dto.getName() +"님의 체험학습 "+ dto.getRegi_type() +" 내역]</strong><br><br>"
	+ "<strong>일시 : </strong>"+ dto.getFt_date() +"<br>"
	+ "<strong>케이크 만들기 신청 인원수 : </strong>"+ dto.getFt_cake() +"명<br>"
	+ "<strong>쿠키 만들기 신청 인원수 : </strong>"+ dto.getFt_cookie() +"명<br>"
	+ "<strong>특이사항 : </strong>"+ dto.getNote();

String htmlContent = "";
try {
	String templatePath = application.getRealPath("/emailSend/FTMailForm.html");
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