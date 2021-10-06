<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>

<!DOCTYPE html>
<html lang="zxx">

<head>

<meta charset="UTF-8">
<title>gootdate</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous"
>
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>

<link rel="apple-touch-icon" sizes="76x76" href="/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="/assets/img/favicon.png">
<title>Soft UI Design System by Creative Tim</title>
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
<!-- Nucleo Icons -->
<link href="/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="/assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<link href="/assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- CSS Files -->
<link id="pagestyle" href="/assets/css/soft-design-system.css?v=1.0.5" rel="stylesheet" />
<script src="/assets/js/core/popper.min.js"></script>
<script src="/assets/js/core/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!-- live notification -->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
	integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous"
>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.3/jquery.mCustomScrollbar.min.css'>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.3/jquery.mCustomScrollbar.concat.min.js'></script>

</head>
<style>
/* 편하려고 페이지 동일성을위해서 컨테이너하고 제목태그인 h2는 css를 좀입혀놓았습니다 */
#container {
	min-height: 50%;
	margin: auto;
	padding: 0px 0px 300px 0px;
}

h2 {
	text-align: center;
	padding: 100px 0px 100px 0px;
}

.online {
	position: absolute;
	top: 20px;
	left: 40px;
	color: green;
	text-decoration: none;
	transition: 1s;
	z-index: 10000;
}
/* .onlineImg{
position: absoulte;
	top: 20px;
	left: 20px;
	color: green;
	text-decoration: none;
	transition: 1s;
	z-index: 10000;

} */

#online:hover {
	text-shadow: 0 0 .1em, 0 0 .3em;
}
</style>
<script type="text/javascript">
	//jQuery.noConflict();
	$(function() {

		if ('${sessionScope.loginMember}' != '') {
			$("#registerLi")
					.replaceWith(
							'<li class="nav-item px-3"><a href="../member/memberPage"  class="nav-link">${sessionScope.loginMember.name}</a></li>')
			$("#loginLi")
					.replaceWith(
							'<li class="nav-item px-3"> <a href="#" id="logout"  class="nav-link">Sign out</a></li>');
		}

		$("#logout").click(function() {
			$("#logoutForm").submit();
		})
	})
</script>
<body>

	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private, no-store, must-revalidate");
	%>
	<!-- hidden logout form -->
	<form action="/security/logout" method="POST" id="logoutForm" style="display: none">

		<button type="submit">LOGOUT</button>
	</form>

	<!-- nav -->
	<div class="container position-sticky z-index-sticky top-0">
		<div class="row">
			<div class="col-12">
				<nav class="navbar navbar-expand-lg  blur blur-rounded top-0 z-index-fixed shadow position-absolute my-3 py-2 start-0 end-0 mx-4">
					<div class="container-fluid">
						<a class="navbar-brand font-weight-bolder ms-sm-3" href="/" rel="tooltip" title="Designed and Coded by Creative Tim" data-placement="bottom"> GootDate
						</a>
						<button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation"
							aria-expanded="false" aria-label="Toggle navigation"
						>
							<span class="navbar-toggler-icon mt-2"> <span class="navbar-toggler-bar bar1"></span> <span class="navbar-toggler-bar bar2"></span> <span
								class="navbar-toggler-bar bar3"
							></span>
							</span>
						</button>
						<div class="collapse navbar-collapse pt-3 pb-2 py-lg-0 w-100" id="navigation">
							<ul class="navbar-nav navbar-nav-hover ms-lg-12 ps-lg-5 w-100">


								<li class="nav-item px-3"><a class="nav-link"> Pages </a></li>

								<li class="nav-item px-3"><a class="nav-link"> Utilities </a></li>

								<li class="nav-item px-3"><a class="nav-link"> Blocks </a></li>

								<li class="nav-item px-3"><a class="nav-link" href="/cs/listAll?pageNo=1"> customer service </a></li>

								<li class="nav-item px-3" id="registerLi"><a class="nav-link" href="/security/memberRegisterPage"> register </a></li>

								<li class="nav-item px-3" id="loginLi"><a class="nav-link" href="/security/loginPage"> login </a></li>

							</ul>
						</div>
					</div>
				</nav>
				<!-- End Navbar -->
			</div>
		</div>
	</div>
	<!-- nav End -->
	<s:authorize access="isAuthenticated()">
		<audio id='audio' src='/resources/liveChat/alarm.mp3'></audio>
		<input type="text" id="sessionId" value="${sessionScope.loginMember.userid}" style="display: none"></input>
		<span class="online" style="left:20px"><img src="/resources/imgs/online.png" style="width: 10px; position: relative; z-index: 10000;"></span>
		<span id="online" class="online"></span>
	</s:authorize>