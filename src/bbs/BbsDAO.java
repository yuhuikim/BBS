package bbs;

import java.sql.*;

public class BbsDAO {
    private Connection conn; // DB에 접근하는 객체
    private ResultSet rs; // DB data를 담을 수 있는 객체

    // db랑 연결해주기
    public BbsDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
            String dbID = "root";
            String dbPassword = "rootpw";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 현재시간을 가져오는 함수
    public String getDate() {
        String SQL = "SELECT NOW()"; // 현재시간을 나타내는 mysql
        try {
            // BbsDAO함수는 여러 개의 함수가 사용되기 때문에 각각 함수끼리 데이터베이스 접근에 있어서 마찰이 일어나지 않도록 하기 위해
            // PreparedStatement를 안쪽에 넣어준다.
            // 현재 연결되어있는 객체를 이용해서 SQL 문장을 실행준비단계로 만들어준다.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // rs로 실행 결과를 가져온다.
            rs = pstmt.executeQuery();

            // 결과가 있는 경우
            if (rs.next()) {
                // 현재의 날짜를 그대로 반환할 수 있게 해준다.
                return rs.getString(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; // 데이터베이스 오류
    }

    // 게시글 번호
    public int getNext() {
        // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                // 그 다음 게시글의 번호
                return rs.getInt(1) + 1;
            }
            return 1; // 첫 번째 게시물인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    // 게시글 작성함수
    public int write(String bbsTitle, String userID, String bbsContent) {
        String SQL = "INSERT INTO BBS VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1); // available이니까 처음에 글을 작성했을 때 보여지는 형태가 되어야 하기 때문에 1을 넣어주어야 한다.

            // insert가 성공적으로 수행했다면 0이상의 값이 반환된다.
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류

    }
}
