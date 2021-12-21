<%@page import="utils.JSFunction"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileNotFoundException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//파일이 저장된 디렉토리의 물리적 경로를 얻어온다.
String saveDirectory = application.getRealPath("/Uploads");
//서버에 저장된 파일명과 원본파일명을 파라미터로 받아온다.
String saveFilename = request.getParameter("sName");
String originalFilename = request.getParameter("oName");

try{
	File file = new File(saveDirectory, saveFilename);
	InputStream inStream = new FileInputStream(file);
	
	//사용자의 웹브라우저 종류를 알아내기 위해 요청헤더를 얻어온다.
	String client = request.getHeader("User-Agent");
	if(client.indexOf("WOW64") == -1){
		//인터넷 익스플로러가 아닌경우 한글 파일명을 인코딩함
		originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
	}
	else{
		//인터넷 익스플로러일때 한글 파일명 인코딩
		originalFilename = new String(originalFilename.getBytes("KSC5601"), "ISO-8859-1");
	}
	
	
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\""+originalFilename+"\"");
	response.setHeader("Content-Lenth", ""+file.length());
	//새로운 출력 스트림을 생성해서 파일을 내보낸다.
	out.clear();
	
	OutputStream outStream = response.getOutputStream();
	
	byte b[] = new byte[(int)file.length()];
	int readBuffer = 0;
	
	while((readBuffer =inStream.read(b))>0){
		outStream.write(b,0,readBuffer);
	}
	
	inStream.close();
	outStream.close();
}catch(FileNotFoundException e){
	JSFunction.alertBack("파일을 찾을수 없습니다.",out);
}catch(Exception e){
	JSFunction.alertBack("예외가 발생하셨습니다.",out);
}
%>