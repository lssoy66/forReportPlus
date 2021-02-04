<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>/login/admin Page</h1>
	<br><br>
	
	 Page672 JSP에서 로그인한 사용자의 정보<br>
<!-- <a href="/login/customLogout.fr">Logout</a> -->
     <form action="/login/customLogout.fr" method='post'>
     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
     <button>로그아웃</button>
     </form>
     
</html>