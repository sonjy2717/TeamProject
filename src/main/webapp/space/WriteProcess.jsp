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
	
			//업로드에 성공했다면 폼값을 받아 DTO에 저장
			if(mr == null) {
				//경고창을 띄우고 쓰기 페우지로 이동.
				JSFunction.alertBack("mr생성에 실패하였습니다.", out);
				return;
			}
	
			BoardDTO dto = new BoardDTO();
			//세션영역에 저장된 회원 인증정보(아이디)를 가져와서 DTO에 저장한다.
			dto.setId(session.getAttribute("user_id").toString());
			String date = mr.getParameter("datepicker");
			
			System.out.println(date);
			dto.setTitle(mr.getParameter("title"));
			dto.setContent(mr.getParameter("content"));
			dto.setCalDate(date);
			
			
			String fileName = mr.getFilesystemName("attachedFile");
			
			if(fileName != null) {
				String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				String ext = fileName.substring(fileName.lastIndexOf("."));
				String newFileName = now + ext;
				
				File oldFile = new File(saveDirectory + File.separator + fileName);
				File newFile = new File(saveDirectory + File.separator + newFileName);
			
				oldFile.renameTo(newFile);
				
				dto.setOfile(fileName);
				dto.setSfile(newFileName);
			}
	
			BoardDAO dao = new BoardDAO(application);
			String tname= mr.getParameter("tname");
			
		
			
	
			int iResult= dao.insertWrite(dto,tname);
			//자원해제
			dao.close();
			//dto객체를 매개변수로 전달하여 레코드 insert 처리
			if(iResult == 1){
				//글쓰기에 성공했다면 리스트(목록) 페이지로 이동한다.
				response.sendRedirect("./sub02.jsp");
			}else{
				//실패한 경우에는 글쓰기 페이지로 이동한다. 즉 뒤로 이동한다.
				JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
			}
}catch(Exception e){
	System.out.println("게시물 입력 오류");
	e.printStackTrace();
}
%>