package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.Session;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/community/edit.do")
public class EditController extends HttpServlet {
	
	// 수정페이지 진입부분
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 일련번호 파라미터 받기
		String idx = req.getParameter("idx");
		// 커넥션풀을 통한 DB연결
		MVCBoardDAO dao = new MVCBoardDAO();
		// 게시물 가져오기
		MVCBoardDTO dto = dao.selectView(idx);
		// DTO객체를 request영역에 저장
		/*
		본인이 작성한 글이 아니어도 URL패턴을 분석하면 수정페이지로 진입할 수 
		있으므로 페이지 진입전 본인 확인을 추가로 하는 것이 안전하다.
		 */
		HttpSession session = req.getSession();
		if(!session.getId().equals(dto.getId())){
			JSFunction.alertBack(resp, "작성자 본인만 수정할 수 있습니다.");
			return;
		}
		req.setAttribute("dto", dto);
		// Edit으로 forward한다.
		req.getRequestDispatcher("/community/Edit.jsp").forward(req, resp);
	}
	
	// 수정처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
    	// 물리적경로 얻어오기
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");
        // 업로드 제한용량 얻어오기
        ServletContext application = this.getServletContext();
        int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));

//      파일 업로드 처리
        MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
//      업로드에 실패한 경우...(파일을 첨부하지 않더라도 객체는 생성된다)
        if (mr == null) {
        	// 경고창을 띄우고 쓰기 페이지로 이동
            JSFunction.alertBack(resp, "첨부파일이 제한용량을 초과합니다.");  
            return;
        }
//		업로드에 성공한 경우...
//      폼값 저장
        String idx = mr.getParameter("idx");			// 일련번호
//      새롭게 등록된 파일이 없는경우 Query문에 사용함.
        String prevOfile = mr.getParameter("prevOfile");// 기존 DB에 등록된 원본파일명
        String prevSfile = mr.getParameter("prevSfile");// 기존 DB에 등록된 서버에저장된파일명
        
//      수정페이지에서 새롭게 입력한 폼값
//        String name = mr.getParameter("name"); // id는 수정못함
        String title = mr.getParameter("title");
        String content = mr.getParameter("content");

//      업로드에 성공했다면 폼값을 DTO에 저장
        MVCBoardDTO dto = new MVCBoardDTO(); 
        dto.setIdx(idx);
        dto.setTitle(title);
        dto.setContent(content);

        // 새롭게 저장된 파일이 있는지 확인하기 위해 파일명을 얻어옴
        String fileName = mr.getFilesystemName("ofile");
        if (fileName != null) {// 새롭게 등록된 파일이 있으면...
//        	저장할 파일명을 생성한다.
        	//날짜와 시간을 이용해서 파일명을 생성
            String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
            //파일의 확장자를 추출
            String ext = fileName.substring(fileName.lastIndexOf("."));
            //서버에 저장될 파일명을 생성
            String newFileName = now + ext;
            
            //파일객체 생성
            File oldFile = new File(saveDirectory + File.separator + fileName);
            File newFile = new File(saveDirectory + File.separator + newFileName);
//          파일명 변경
            oldFile.renameTo(newFile);
            
//          DTO객체에 기존파일명과 변경된파일명 저장
            dto.setOfile(fileName);  
            dto.setSfile(newFileName);
//          새로운 파일이 등록되었으므로 기존에 등록한 파일은 삭제처리
            FileUtil.deleteFile(req, "/Uploads", prevSfile);
        }
        else {// 새롭게 등록한 파일이 없는경우...
//        	기존에 등록한 파일명을 유지한다.
        	dto.setOfile(prevOfile);
        	dto.setSfile(prevSfile);
        }
        
        // DB 업데이트 처리
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.updatePost(dto);
        //커넥션풀 자원 반납
        dao.close();
        
        if (result == 1) {// 수정이 완료되었다면...
//        	상세보기 페이지로 이동
            resp.sendRedirect("../community/view.do?tname=step&idx="+ idx);
        }
	}
}
