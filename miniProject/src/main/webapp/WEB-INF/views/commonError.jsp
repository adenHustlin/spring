<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="navBar.jsp"%>
<script type="text/javascript">
	 setTimeout(function() {
		location.href = "/"
	}, 8000); 
</script>

<body>
	
	
	<div class="container" id="container">

		<h2 class="text-secondary" style="padding: 400px 0px 0px 0px; text-align: center">
			Error Occurred<br>${errorMsg }</h2>
		<br> <br>
		<div class="text-secondary" style="padding: 0px 400px 0px 400px; text-align: center; width: auto;">
			<img src="/resources/imgs/walking.gif" />
		</div>
		<br>
		<div class="text-secondary" style="padding: 0px 400px 0px 400px; text-align: center; width: auto;">
			Contact 010-7135-9167<br>Redirecting to Home..
		</div>


	</div>
	<%@include file="footer.jsp"%>
	