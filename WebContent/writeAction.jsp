<!-- 실제로 글쓰기를 눌러서 만들어주는 Action페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바스크립트 문장사용 -->
<%
    request.setCharacterEncoding("UTF-8");
%>
<!-- 건너오는 모든 파일을 UTF-8로 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
	<%
	    String userID = null;
	    // 로그인 된 사람은 회원가입페이지에 들어갈수 없다
	    if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }
	    //글쓰기 자체는 로그인이 되어 있어야만 할 수 있다.
	    if (userID == null) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('로그인을 하세요')");
	        //로그인 안된 사람을 login.jsp를 통해서 로그인 페이지로 넘겨준다.
	        script.println("location.href = 'login.jsp'");
	        script.println("</script>");
	    } else {//로그인이 되어있는 경우!
	        if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { //제목 또는 내용이 입력되지 않은 경우
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('입력 되지 않은 사항이 있습니다.')");
	            script.println("history.back()"); //돌려보내준다.
	            script.println("</script>");
	        } else { //로그인이 되어있고 내용과 제목 다 입력이 잘 되어있는 상태라면!
	            BbsDAO bbsDAO = new BbsDAO(); //실제로 데이터베이스에 등록을 해주어야한다--> 하나의 인스턴스르르 만들어준다.

	            //실제로 게시글을 작성할 수 있도록 해준다--> 차례대로 매개변수를 넣어준다.
	            int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());

	            if (result == -1) { // 글쓰기에 실패했을 경우
	                PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
	                script.println("<script>");
	                script.println("alert('글쓰기에 실패했습니다.')");
	                script.println("history.back()");
	                script.println("</script>");
	            } else { // 글쓰기에 성공했을 경우
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("location.href= 'bbs.jsp'"); //게시글 작성 기능을 완료해줄 수 있다.
	                script.println("</script>");
	            }
	        }
	    }
	%>
</body>
</html>
