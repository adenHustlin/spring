<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zxx">

<head>

<meta charset="UTF-8">
<meta name="description" content="Yoga Studio Template">
<meta name="keywords" content="Yoga, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>gootdate</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/template/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/template/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/template/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/template/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/template/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/template/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/template/css/style.css" type="text/css">


</head>
<style>
.container {
	min-height: 70%;
	margin: auto;
}
h2 {
	text-align: center;
	padding: 50px;
}
</style>
<script type="text/javascript">
	//jQuery.noConflict();
	$(function() {

		if ('${sessionScope.loginMember}' != '') {

			$("#memberDiv")
					.html(
							'<a href="#">${sessionScope.loginMember.name}</a> <a href="#" id="logout" class="in">Sign out</a>')
			$("")
		}

		$("#logout").click(function() {
			$("#logoutForm").submit();
		})
		path = '${pageContext.request.contextPath}'
		console.log(path)
	})
	function moveMemberPage() {
		location.href = "../member/memberPage"
	}
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
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Search model -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search model end -->

	<!-- Header Section Begin -->
	<header class="header-section">
		<div class="container-fluid">
			<div class="inner-header">
				<div class="logo">
					<a href="/"><img src="/template/img/logo.png" alt=""></a>
				</div>
				<div class="header-right">
					<img src="/template/img/icons/search.png" alt="" class="search-trigger"> <img src="/template/img/icons/man.png" alt="" onclick="moveMemberPage();" />
					<a href="#"> <img src="/template/img/icons/bag.png" alt=""> <span>2</span>
					</a>
				</div>
				<div class="user-access" id="memberDiv">
					<a href="/security/memberRegisterPage">Register</a> <a href="/security/loginPage" class="in">Sign in</a>
				</div>
				<nav class="main-menu mobile-menu">
					<ul>
						<li><a class="active" href="/">Home</a></li>
						<li><a href="#">Shop</a>
							<ul class="sub-menu">
								<li><a href="#">Product Page</a></li>
								<li><a href="#">Shopping Card</a></li>
								<li><a href="#">Check out</a></li>
							</ul></li>
						<li><a href="#">About</a></li>
						<li><a href="/contact">contact</a></li>
						<li><a href="/cs/listAll?pageNo=1">C S </a></li>
					</ul>
				</nav>
			</div>
		</div>
	</header>
	<!-- Header Info Begin -->
	<div class="header-info">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-4">
					<div class="header-item">
						<img src="/template/img/icons/delivery.png" alt="">
						<p>Free shipping on orders over $30 in USA</p>
					</div>
				</div>
				<div class="col-md-4 text-left text-lg-center">
					<div class="header-item">
						<img src="/template/img/icons/voucher.png" alt="">
						<p>20% Student Discount</p>
					</div>
				</div>
				<div class="col-md-4 text-left text-xl-right">
					<div class="header-item">
						<img src="/template/img/icons/sales.png" alt="">
						<p>30% off on dresses. Use code: 30OFF</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Header Info End -->
	<!-- Header End -->
	