<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="registerMember.do" method="post">
		userid:<input type="text" name="userid">
		password:<input type="password" name="password">
		name:<input type="text" name="name">
		email:<input type="email" name="email">
		
		<input type="submit" value="submit">
	</form>
</body>
</html>