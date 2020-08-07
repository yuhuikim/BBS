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
<!-- 로그인 페이지에서 넘겨준 아이디와 비번을 그대로 받아서 한명의 사용자에 넣어준다. -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- -->
	<%
	    String userID = null;
	    if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }
	    
	    //이미 로그인한 사람은 또다시 로그인 할 수 없게 막아주는 것임
	    if(userID!=null){
	        PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인이 되어있습니다.')");
            script.println("location.href='main.jsp'");
            script.println("</script>");
	    }
	    UserDAO userDAO = new UserDAO();
	    int result = userDAO.login(user.getUserID(), user.getUserPassword());

	    //로그인에 성공했을 때 result==1
	    if (result == 1) {
	        //로그인 성공 시에 해당 아이디를 세션을 보내준다. 
	        session.setAttribute("userID", user.getUserID());

	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("location.href='main.jsp'");
	        script.println("</script>");
	    } else if (result == 0) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('비밀번호가 틀립니다.')");
	        //history.back():이전페이지로 사용자를 돌려보낸다. - 로그인 페이지로 이동
	        script.println("history.back()");
	        script.println("</script>");
	    } else if (result == -1) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('존재하지 않는 아이디입니다')");
	        script.println("history.back()");
	        script.println("</script>");
	    } else if (result == -2) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('데이터베이스 오류가 발생했습니다.')");
	        script.println("history.back()");
	        script.println("</script>");
	    }
	%>
</body>
</html>