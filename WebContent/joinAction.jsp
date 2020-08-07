<!-- 회원가입 처리 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 우리 만든 클래스를 받아오고 싶으면 페이지 임포트를 써서 불러온다. -->
<%@ page import="user.UserDAO"%>
<!-- 자바 스크립트 문장을 작성하기 위해 쓰는 것 -->
<%@ page import="java.io.PrintWriter"%>
<!-- 건너오는 모든 데이터를 utf-8로 받을 수 있도록 하는 것 -->
<%
    request.setCharacterEncoding("UTF-8");
%>

<!-- 자바빈을 사용: 한명의 회원 정보를 담은 User라는 클래스를 자바빈으로서 사용하기 위해 
scope="page"는 현재의 페이지 내에서만 사용한다고 범위를 지정해주는 것이다.-->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- 회원가입이므로 5가지를 다 받아줘야한다. -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
	    String userID = null;
	    if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }
	    //이미 로그인한 사람은 또 다시 회원가입 페이지에 접속 할 수 없게 막아주는 것임
	    if (userID != null) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('이미 로그인이 되어있습니다.')");
	        script.println("location.href='main.jsp'");
	        script.println("</script>");
	    }
	    //모든 데이터들이 보내져야하기 때문에 각각의 데이터들이 잘 들어왔는지 확인을 해야한다.
	    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
	            || user.getUserGender() == null || user.getUserEmail() == null) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('입력되지 않은 사항이 있습니다.')");
	        script.println("history.back()");
	        script.println("</script>");

	    } else {
	        UserDAO userDAO = new UserDAO();
	        int result = userDAO.join(user);

	        //동일한 아이디일 경우
	        if (result == -1) {
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('이미 존재하는 아이디입니다.')");
	            script.println("history.back()");
	            script.println("</script>");
	        }
	        //회원가입이 되었을 땐 바로 메인 페이지에 이동할 수 있도록 해준다.
	        else {
	            session.setAttribute("userID", user.getUserID());
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("location.href='main.jsp')");
	            script.println("</script>");
	        }
	    }
	%>
</body>
</html>