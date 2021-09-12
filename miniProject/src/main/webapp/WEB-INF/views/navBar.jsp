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
			$("#userProfile").html('<a href="/member/login" class="d-block link-secondary text-decoration-none  "><img src="../resources/imgs/login.png"/>Login</a>')
			
		}
		let pathname = window.location.pathname;
		console.log(pathname)
		if (pathname == "/") {
			$("#homeA").attr('class', 'nav-link active')

		} else if (pathname.includes('/board')) {
			$("#boardA").attr('class', 'nav-link active')
		}
	})
</script>

<body>
	<%
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Cache-Control", "private, no-store, must-revalidate"); // HTTP 1.1
	%>
	<%-- <nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">Socialism</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a id="homeA"class="nav-link" aria-current="page" href="/">Home</a></li>
					<li class="nav-item"><a id="boardA"class="nav-link" aria-current="page" href="/board/listAll?pageNo=1">Board</a></li>
				</ul>

			
			
				
				</div>
				<div class="flex-shrink-0 dropdown" id="userDropdown">
					<a class="d-block link-dark text-decoration-none dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">${sessionScope.loginMember.userid}</a>
					<ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
						<li><a class="dropdown-item" href="#"><img src="../resources/imgs/userSettings.png"></a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="/member/logout"><img src="../resources/imgs/logout.png"></a></li>
					</ul>
				</div>
		</div>
	</nav>  --%>
	<header class="py-3 mb-3 border-bottom">
		<div class="container-fluid" style="grid-template-columns: 1fr 2fr;">
			<div class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0" style="text-align: center; font-size: 1.3rem;">Code Addict</div>
			<ul class="nav col-12 col-lg-auto me-lg-auto mb-2  mb-md-0" style="font-size: 1.1rem;">
				<li ><a id="homeA" class="nav-link link-secondary" aria-current="page" href="/">Home</a></li>
				<li ><a id="boardA" class="nav-link link-secondary" aria-current="page" href="/board/listAll?pageNo=1">Board</a></li>

			</ul>


			<div class="d-flex align-items-center" >
				<form class="w-100 me-3">
					<input type="search" class="form-control" placeholder="Search..." aria-label="Search">
				</form>

				<div class="flex-shrink-0 dropdown" id="userProfile">
					<a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false"> <img
						src="../resources/imgs/noUserImage.png"  width="32" height="32" class="rounded-circle">
						${sessionScope.loginMember.userid}
					</a>
					<ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2" style="">
						<li><a class="dropdown-item link-secondary" href="#"><img src="../resources/imgs/userSettings.png">&nbsp;&nbsp;User Profile</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item link-secondary" href="/member/logout"><img src="../resources/imgs/logout.png">&nbsp;&nbsp;Sign Out</a></li>
					</ul>
				</div>
			</div>
		</div>
	</header>

</body>
</html>
