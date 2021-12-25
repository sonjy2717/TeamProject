<%@page import="fileupload.FileUtil"%>
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
			
			String idx=mr.getParameter("idx");
			String prevOfile =mr.getParameter("prevOfile"); //기존 DB에 등록된 원본파일명
			String prevSfile =mr.getParameter("prevSfile");//기존 DB에 등록된 저장파일명
			BoardDTO dto = new BoardDTO();
			
			dto.setIdx(mr.getParameter("idx"));
			dto.setTitle(mr.getParameter("title"));
			dto.setContent(mr.getParameter("content"));
			
			
			String fileName = mr.getFilesystemName("attachedFile");
			
			if(fileName != null) { //새롭게 등록된 파일이 있으면..
				String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				String ext = fileName.substring(fileName.lastIndexOf("."));
				String newFileName = now + ext;
				
				//파일명을 변경
				File oldFile = new File(saveDirectory + File.separator + fileName);
				File newFile = new File(saveDirectory + File.separator + newFileName);
			
				oldFile.renameTo(newFile);
				//DTO에 기존파일명과 변경된 파일명 저장
				dto.setOfile(fileName);
				dto.setSfile(newFileName);
				//새로운 파일이 등록되엇으므로 기존에 등록한 파일은 삭제처리.
				FileUtil.deleteFile(request, "/Uploads", prevSfile);
			}
			else { //새롭게 등록된 파일이 없는 경우...
				dto.setOfile(prevOfile);
				dto.setSfile(prevSfile);
			}
	
			BoardDAO dao = new BoardDAO(application);
			String tname= mr.getParameter("tname");
			
			//세션영역에 저장된 회원 인증정보(아이디)를 가져와서 DTO에 저장한다.
			dto.setId(session.getAttribute("user_id").toString());
			
	
			int iResult= dao.updateEdit2(dto,tname);
			//자원해제
			dao.close();
			//dto객체를 매개변수로 전달하여 레코드 insert 처리
			if(iResult == 1){
				//글쓰기에 성공했다면 리스트(목록) 페이지로 이동한다.
				response.sendRedirect("./sub01.jsp");
			}else{
				//실패한 경우에는 글쓰기 페이지로 이동한다. 즉 뒤로 이동한다.
				JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
			}
}catch(Exception e){
	System.out.println("게시물 입력 오류");
	e.printStackTrace();
}
%>