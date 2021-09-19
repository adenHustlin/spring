<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<script type="text/javascript">
	$(function() {

		if ('${sessionScope.loginMember}' == '') {
			console.log("nouser")
			$("#userProfile")
					.html(
							'<a href="/security/loginPage" class="d-block link-secondary text-decoration-none  "><img src="../resources/imgs/login.png"/>Login</a>')

		}
		let pathname = window.location.pathname;
		console.log(pathname)
		if (pathname == "/") {
			$("#homeA").attr('class', 'nav-link  active')

		} else if (pathname.includes('/board')) {
			$("#boardA").attr('class', 'nav-link  active')
		}

		$("#logout").click(function() {
			$("#logoutForm").submit();
		})
	})
</script>

<body>
	<%
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Cache-Control", "private, no-store, must-revalidate"); // HTTP 1.1
	%>
	<header class="py-3 mb-3 border-bottom">
		<div class="container-fluid" style="grid-template-columns: 1fr 2fr;">
			<div class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0" style="text-align: center; font-size: 1.3rem;">Code Addict</div>
			<ul class="nav col-12 col-lg-auto me-lg-auto mb-2  mb-md-0" style="font-size: 1.1rem;">
				<li><a id="homeA" class="nav-link link-secondary" aria-current="page" href="/">Home</a></li>
				<li><a id="boardA" class="nav-link link-secondary" aria-current="page" href="/board/listAll?pageNo=1">Board</a></li>
			</ul>
			<form action="/security/logout" method="POST" id="logoutForm" style="display: none">

				<button type="submit">LOGOUT</button>
			</form>

			<div class="d-flex align-items-center">
				<select class="form-select" aria-label="Default select example" style="width: 500px;" id="searchType">
					<option selected>Open this select menu</option>
					<option value="writer">writer</option>
					<option value="title">title</option>
					<option value="title+content">title+content</option>
				</select> <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="search in Board">

				<div class="flex-shrink-0 dropdown" id="userProfile">
					<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false"> <img
						src="../resources/imgs/noUserImage.png" width="32" height="32" class="rounded-circle"> ${sessionScope.loginMember.name}
					</a>
					<ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2" style="">
						<li><a class="dropdown-item link-secondary" href="#"><img src="../resources/imgs/userSettings.png">&nbsp;&nbsp;User Profile</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item link-secondary" href="#" id="logout"><img src="../resources/imgs/logout.png">&nbsp;&nbsp;Sign Out</a></li>
					</ul>
				</div>
			</div>
		</div>
	</header>

</body>
</html>
