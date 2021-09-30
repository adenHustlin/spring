<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>
<script src="../resources/ckeditor/ckeditor.js"></script>

<title>Insert title here</title>
<script>
	$(function() {

		let ckeditor_config = {

			resize_enaleb : true,
			height : 800,
			enterMode : CKEDITOR.ENTER_BR,

			shiftEnterMode : CKEDITOR.ENTER_P,

			filebrowserUploadUrl : '<c:url value="/cs/imageUpload" />?${_csrf.parameterName}=${_csrf.token}'

		};

		CKEDITOR.replace('content', ckeditor_config);
	});
</script>
</head>
<style>

</style>
<body>
	
	<h2>Ask Us</h2>
	<div class="container" id="container">
		<form action="/cs/createBoard" method="post">
			<div class="mb-3">
				<label class="form-label">title</label> <input type="text" class="form-control" id="title" name="title" placeholder="Enter Title" required>
			</div>
			<input type="text" name="writer" value="${loginMember.userid}" style="display: none;">
			<textarea id="content" name="content" required></textarea>

			<div class="d-grid gap-2 col-6 mx-auto" style="padding: 50px">

				<button class="btn btn-outline-secondary" type="submit">Write</button>

			</div>
		</form>

	</div>

	<%@include file="../footer.jsp"%>