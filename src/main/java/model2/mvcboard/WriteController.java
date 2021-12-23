package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/community/write.do")
public class WriteController extends HttpServlet {
	//글쓰기 페이지 진입
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/community/sub01_write.jsp").forward(req, resp);
    }
    
    //글쓰기 처리    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	//디렉토리의 물리적 경로 얻어옴
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");

        //application 내장객체를 통해 web.xml에 등록된 초기화 파라미터 얻어옴
        ServletContext application = getServletContext();
        int maxPostSize = Integer.parseInt(
        		application.getInitParameter("maxPostSize"));

        //파일 업로드 처리
        MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
        //업로드에 실패한 경우...(파일을 첨부하지 않더라도 객체는 생성된다)
        if (mr == null) {
        	//경고창을 띄우고 쓰기 페이지로 이동
            JSFunction.alertLocation(resp, "첨부 파일이 제한 용량을 초과합니다.",
                                     "../community/write.do");  
            return;
        }
        
        //업로드에 성공했다면 폼값을 받아 DTO에 저장
        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setId(mr.getParameter("id"));
        dto.setTitle(mr.getParameter("title"));
        dto.setContent(mr.getParameter("content"));
        String tname = req.getParameter("tname");
        System.out.println("WriteController : "+ tname);
        
        
        //업로드 된 원본 파일명을 가져온다. 
        String fileName = mr.getFilesystemName("ofile");
        //서버에 저장된 파일이 있는경우 아래 처리를한다.
        if (fileName != null) {
        	//날짜와 시간을 이용해서 파일명을 생성
            String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
            //파일의 확장자를 추출
            String ext = fileName.substring(fileName.lastIndexOf("."));
            //서버에 저장될 파일명을 생성
            String newFileName = now + ext;
            //파일객체 생성
            File oldFile = new File(saveDirectory + File.separator + fileName);
            File newFile = new File(saveDirectory + File.separator + newFileName);
            //파일명 변경
            oldFile.renameTo(newFile);
            
            //DTO객체에 원본파일명과 저장된파일명을 저장한다. 
            dto.setOfile(fileName);  
            dto.setSfile(newFileName);  
        }
        //새로운 게시물을 테이블에 저장한다. 
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.insertWrite(dto, tname);
        //커넥션풀 자원 반납
        dao.close();

        if (result == 1) {
        	//쓰기에 성공하면 리스트로 이동한다.
            resp.sendRedirect("../community/list.do?tname=step");
        }
        else {
        	//실패하면 쓰기페이지로 이동한다. 
            resp.sendRedirect("../community/write.do");
        }
    }
}
