<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="navBar.jsp"%>
<script type="text/javascript">
	setTimeout(function() {
		location.href = "/"
	}, 5000);
</script>

<body>

	
	<div class="container" id="container">

		<h2 class="text-secondary" style="padding: 400px 0px 0px 0px; text-align: center">
			Access Denied<br>Need Authority</h2>
		<br>
		<br>
		<div class="text-secondary" style="padding: 0px 400px 0px 400px; text-align: center; width: auto;">
			<img src="/resources/imgs/walking.gif" />
		</div>
		<br>
		<div class="text-secondary" style="padding: 0px 400px 0px 400px; text-align: center; width: auto;">Redirecting to Home..</div>


	</div>
	<%@include file="footer.jsp"%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>

</body>
</html>