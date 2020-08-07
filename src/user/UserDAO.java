package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//데이터베이스 접근 객체의 약자로 실질적으로 데이터베이스에서 회원정보를 불러오거나 데이터베이스의 회원정보를 넣고자 할 때 사용
public class UserDAO {

    // Connection은 데이터베이스에 접근하게 해주는 하나의 객체
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {

        // mysql에 접속하게 해주는 부분
        try {
            // localhost는 본인 컴퓨터의 주소를 의미, 3306포트에 BBS라는 데이터베이스에 접속할 수 있게 해준다.
            String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";

            // 본인이 설정한 mysql의 id랑 pw를 적어준다.
            String dbID = "root";
            String dbPassword = "rootpw";

            // mysql에 접속할 수 있도록 매개체 역할해주는 라이브러리이다.
            Class.forName("com.mysql.cj.jdbc.Driver");

            // dbURL에 dbID와 dbPassword를 통해서 접속할 수 있도록 해준다.
            // 접속이 완료되면 conn 객체 안에 접속된 정보가 담기게 된다.
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 실제로 로그인을 시도하는 함수를 만들어준다.
    public int login(String userID, String userPassword) {

        // 실제로 데이터베이스에 입력할 문장을 작성해준다.
        String SQL = "SELECT userPassword FROM USER WHERE userID=?";

        try {
            // SQL injection 같은 해킹 기법을 방어하기 위해서 prepareStatement을 사용하는데
            // "SELECT userPassword FROM USER WHERE userID=?" 로 준비해놓았다가
            // ?에 해당하는 값에 매개변수로 넘어온 값을 넣어준다.
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);

            // rs라는 객체에 실행한 결과를 담아준다.
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 아이디가 있는 경우
                if (rs.getString(1).equals(userPassword)) // 비밀번호도 동일하다면
                    return 1; // 로그인 성공
                else
                    return 0; // 비밀번호 불일치
            }
            return -1; // 아이디가 없음 --> -1을 함으로써 아이디가 없다는 것을 알려준다. 그래서 결과값이 나오지 않는다.
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터 베이스 오류
    }

    // User클래스를 통해서 만들어질 수 있는 하나의 인스턴스가 되는 것이다.
    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES(?,?,?,?,?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //insert 문장을 사용하면 반드시 0 이상의 숫자가 반환되기 때문에 -1이 아닌 경우는 회원가입이 성공적으로 됐음을 알 수 있다.
        return -1; // 데이터베이스 오류
    }

}
