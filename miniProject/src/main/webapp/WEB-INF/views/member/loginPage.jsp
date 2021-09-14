<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
	<jsp:include page="../navBar.jsp"></jsp:include>
	<h2>
		<c:out value="${error }" />
	</h2>
	<h2>
		<c:out value="${logout }" />
	</h2>

	<h2 style="text-align: center">login</h2>
	<div class="container">
		<form action="/login" method="POST">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="../resources/imgs/person.png"></label> <input type="text" class="form-control"
					id="userid" name="userid" placeholder="Enter ID" required autofocus>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="/resources/imgs/password.png"></label> <input type="password" class="form-control"
					id="password" name="password" placeholder="Enter password" required>
			</div>

			<!-- <div class="form-check form-switch">
				<input class="form-check-input" type="checkbox" value="" id="useCookie" name="useCookie"> <label class="form-check-label" for="useCookie">
					Auto Login </label>
			</div> -->
			<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />


			<button type="submit" class="btn btn-outline-secondary">Login</button>
			<c:if test="${param.error==1 }">
				<p>login failed</p>
			</c:if>
			<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
				<font color="red">
					<p>
						Your login attempt was not successful due to <br /> ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
					</p> <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
				</font>
			</c:if>


		</form>
		<p class="text-secondary">
			<a href="../memberRegister.move" class="text-secondary">wanna join our crew?</a>
		</p>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>