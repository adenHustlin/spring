<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>param</h2>
	 <div>${param.member }</div>
	 <div>${param }</div>
	 <div>${param.name }</div>
	 <div>${param.birth }</div>
	 </hr>
	 <h2>binding</h2>
	 <div>${name }</div>
	 <div>${birth }</div>
	 <div>${memberInfo }</div>
	 <div>${member }</div>
	 
</body>
</html>