<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private, no-store, must-revalidate");
	%>
	<%-- <c:import url="navBar.jsp"></c:import>  --%>
	<%@include file="navBar.jsp"%>
	<!-- Hero Slider Begin -->
	<div id="container">
	<section class="hero-slider">
		<div class="hero-items owl-carousel owl-loaded">
			<div class="single-slider-item set-bg" data-setbg="/template/img/slider-1.jpg">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<h1>2019</h1>
							<h2>Lookbook.</h2>
							<a href="#" class="primary-btn">See More</a>
						</div>
					</div>
				</div>
			</div>
			<div class="single-slider-item set-bg" data-setbg="/template/img/slider-2.jpg">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<h1>2019</h1>
							<h2>Lookbook.</h2>
							<a href="#" class="primary-btn">See More</a>
						</div>
					</div>
				</div>
			</div>
			<div class="single-slider-item set-bg" data-setbg="/template/img/slider-3.jpg">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<h1>2019</h1>
							<h2>Lookbook.</h2>
							<a href="#" class="primary-btn">See More</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	</div>
	<!-- Hero Slider End -->
	<%@include file="footer.jsp"%>

