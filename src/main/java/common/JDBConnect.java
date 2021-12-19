package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax. servlet.ServletContext;

public class JDBConnect {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	//기본생성자
	public JDBConnect() {
		try {
			//오라클 드라이버를 로드
			Class.forName("oracle.jdbc.OracleDriver");
			//커넥션 URL 생성
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "justcoding";  //id
			String pwd = "1234"; //패스워드
			con = DriverManager.getConnection(url, id,pwd);
			
			System.out.println("DB연결 성공(기본 생성자)");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	public JDBConnect(String driver, String url, String id, String pwd ) {
		try {
			//오라클 드라이버를 로드
			Class.forName(driver);
			//커넥션 URL 생성
			con = DriverManager.getConnection(url, id,pwd);
			System.out.println("DB연결 성공(인자 생성자)");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	public JDBConnect(ServletContext application) {
		
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pwd = application.getInitParameter("OraclePwd");
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id,pwd);
			System.out.println("DB연결 성공(인자 생성자2)");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
			if(rs !=null) rs.close();
			if(stmt !=null) stmt.close();
			if(psmt !=null) psmt.close();
			if(con != null) con.close();
			
			System.out.println("JDBC 자원해제");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
