<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="No-Cache">
<meta http-equiv="Pragma" content="No-Cache">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
	response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Cache-Control", "private, no-store, must-revalidate");
	%>
	<%-- <c:import url="navBar.jsp"></c:import>  --%>
	<%@include file="navBar.jsp"%>

	<h2>main</h2>

	<a href='<c:url value="/member/memberPage"/>'>MEMBER</a>
	<a href='<c:url value="/admin/adminPage"/>'>ADMIN</a>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>