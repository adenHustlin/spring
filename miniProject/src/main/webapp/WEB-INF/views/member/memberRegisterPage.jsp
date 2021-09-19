<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {

		$("#userid").on(
				"propertychange change keyup paste input",
				function() {
					let userid = this.value;
					if (userid.search(/\s/g) == -1
							&& userid.length<12 &&userid.length>6) {

						$.ajax({
							url : "/security/useridConfirm/" + userid,

							type : "GET",
							success : function(data) {
								console.log(data)
								if (data == "exists") {
									$("#idError").html("id exsists")
								} else {
									$("#idError").html("valid id")
								}
							},
							error : function() {

							}

						});
						/* location.href="member/useridConfirm/"+userid;
						console.log("${result}") */
					} else {
						$("#idError").html("follow id format")
					}

				})
	})
</script>
<body>
	<jsp:include page="../navBar.jsp"></jsp:include>
	<h2 style="text-align: center">login</h2>
	<div class="container">
		<form action="/security/memberRegister" method="post">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">id</label> <input type="text" class="form-control" id="userid" name="userid"
					placeholder="Enter ID" required> <span id="idError"></span>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">password</label> <input type="password" class="form-control" id="password" name="password"
					placeholder="Enter password" required> <span id="pwdError"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">confirm password</label> <input type="password" class="form-control" id="Cpassword"
					name="Cpassword" placeholder="confirm password" required> <span id="pwdError2"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">name</label> <input type="text" class="form-control" id="name" name="name" placeholder="Enter name"
					required> <span id="nameError"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">email</label> <input type="email" class="form-control" id="email" name="email"
					placeholder="Enter email" required>
				<!-- <button class="btn btn-outline-secondary">confirm email</button>
				<input class="form-control" type="text" placeholder="Enter Confirmation Code" id="emailConfirmationCode">
				<button class="btn btn-outline-secondary">confirm email</button> -->

				<span id="emailError"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">phone</label> <input type="text" class="form-control" id="phone" name="phone"
					placeholder="Enter phone" required> <span id="phoneError"></span>
			</div>
			<button type="submit" class="btn btn-outline-secondary">register</button>

		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>
