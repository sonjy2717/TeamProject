<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ include file="./IsLoggedIn.jsp" %>  
<%
//폼값 받기

try{
	
	String saveDirectory = application.getRealPath("/Uploads"); //저장 물리적 경로
	int maxPostSize = 1024*1000; //1MB
	String encoding = "UTF-8"; //인코딩 방식
	
	MultipartRequest mr = new MultipartRequest(request,saveDirectory, maxPostSize, encoding);
	
	String fileName = mr.getFilesystemName("attachedFile");
	String ext = fileName.substring(fileName.lastIndexOf("."));
	String now = new SimpleDateFormat("yyyyMMdd_HmmS").format(new Date());
	String newFileName = now +ext;

	File oldFile = new File(saveDirectory + File.separator + fileName);
	File newFile = new File(saveDirectory + File.separator + newFileName);
	oldFile.renameTo(newFile);
	
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String tname= mr.getParameter("tname");
	
	BoardDTO dto = new BoardDTO();
	
	dto.setTitle(title);
	dto.setContent(content);
	dto.setOfile(fileName);
	dto.setSfile(newFileName);
	//세션영역에 저장된 회원 인증정보(아이디)를 가져와서 DTO에 저장한다.
	//dto.setId(session.getAttribute("UserId").toString());
	dto.setId("test1");
	
	BoardDAO dao = new BoardDAO(application);
	int iResult= dao.insertWrite(dto,tname);
	//자원해제
	dao.close();

	//dto객체를 매개변수로 전달하여 레코드 insert 처리
	if(iResult == 1){
		//글쓰기에 성공했다면 리스트(목록) 페이지로 이동한다.
		response.sendRedirect("../main/main.jsp");
	}else{
		//실패한 경우에는 글쓰기 페이지로 이동한다. 즉 뒤로 이동한다.
		JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
	}
}catch(Exception e){
	System.out.println("게시물 입력 오류");
	e.printStackTrace();
}

%>