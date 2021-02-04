<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
<title>로그 아웃</title>
</head>
<body>
<H1>Logout Page</H1>

<form action="/forreport.fr" method='post'>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
<button>로그아웃</button>
</form>
</body>
</html>