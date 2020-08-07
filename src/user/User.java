package user;

// 한 명의 회원 데이터를 다룰 수 있는 데이터베이스 및 자바빈이 완성. 
// 하나의 데이터를 다루고 처리할 수 있는 기법을 자바빈이라고 함
public class User { //유저 클래스
    private String userID;
    private String userPassword;
    private String userName;
    private String userGender;
    private String userEmail;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

}
