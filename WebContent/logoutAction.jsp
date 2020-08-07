<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
	<%
	    //현재 이 페이지에 접속한 회원이 세션을 빼앗기도록 만들어서 로그아웃을 시켜준다.
		session.invalidate();
	%>
	<!-- 이 후에 main.jsp로 이동할 수 있도록 만들어준다. -->
	<script>
        location.href = 'main.jsp';
    </script>
</body>
</html>
