package common;

import java.sql.Connection;

/*
 * JNDI(Java Naming and Directory Interface)
  	: 디렉토리 서비스에서 제공하는 데이머 및 객체를 찾아서 참고(lookup) 하는
    API로 쉽게 말하자면 외부에 잇는 객체를 이름으로 찾아오기 위한 기술이다.
  
 DBCP(Database Connection Pool : 커넥션 풀)
 	:DB와 연결된 커넥션 객체를 미리 만들어 풀(Pool)에 저장해 둿다가
 	필요할 때 가져다쓰고 반납하는 기법을 말한다. DB에 부하를 줄이고
 	자원을 효율적으로 관리할 수 있다. 게임에서는 풀링스스템(Pooling System)
 	이라는 용어로 사용한다.
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnPool {
    public Connection con;
    public Statement stmt;
    public PreparedStatement psmt;
    public ResultSet rs;

    // 기본 생성자
    public DBConnPool() {
        try {
            //1.context객체를 생성한다.
            Context initCtx = new InitialContext();
            /*
            2. 앞에서 생성한 객체를 통해 JNDI서비스 구조의 초기 Root 디렉토리를 얻어온다.
            여기서 얻어오는 톰켓의 루트 디렉토리명은 java:comp/env로 이미 정해져
            있으므로 그대로 사용하면 된다.
             */
            Context ctx = (Context)initCtx.lookup("java:comp/env");
            /*
             3.server.xml에 등록된 네이밍을 lookup하여 DataSource를 얻어온다.
             해당 데이터 소스는 DB에 연결된 정보를 가지고 있다.
             */
            DataSource source = (DataSource)ctx.lookup("dbcp_myoracle");
            //4.커넥션풀에 생성해 놓은 커넥션 객체를 가져다가 사용한다.
            con = source.getConnection();
            //정상적으로 연결되었다면 성공메세지를 출력한다.
            System.out.println("DB 커넥션 풀 연결 성공");
        }
        catch (Exception e) {
            System.out.println("DB 커넥션 풀 연결 실패");
            e.printStackTrace();
        }
    }

    // 사용이 끝난 객체를 Pool에 반납한다. 즉 여기서의 close()는 객체의 소멸이 일어난다.
    public void close() {
        try {            
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (psmt != null) psmt.close();
            if (con != null) con.close(); 

            System.out.println("DB 커넥션 풀 자원 반납");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
