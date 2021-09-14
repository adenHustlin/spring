<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<title>Home</title>
</head>
<script type="text/javascript">
	 $(function(){
		
		$("#userid").on("propertychange change keyup paste input",function(){
		let userid=this.value;
		console.log(userid.length)
		if(userid.search( /\s/g)==-1 && userid.length<12 &&userid.length>6){
			
			/* $.ajax({
				url : "/test/userid",
				data: {userid:userid},
				dataType : "JSON",
				type : "POST",
				success : function(data) {
					console.log(data)
					if(data.result=="exist"){
						$("#idError").html("is exsists")
					}else{
						$("#idError").html("valid id")
					}
				},
				error : function() {

				}
			
			}); */
		}else{
			$("#idError").html("follow id format")
		}
		
	})
		
	$.ajax({
		url : "/test/userid",
		data: {userid:userid},
		dataType : "JSON",
		type : "POST",
		success : function(data) {
			console.log(data)
			if(data.result=="exist"){
				$("#idError").html("is exsists")
			}else{
				$("#idError").html("valid id")
			}
		},
		error : function() {

		}
	
	});
	})
	
	 
</script>
<body>
- 사용자는 아이디, 비밀번호, 이름, 전화번호, 이메일을 이용하여 회원 가입을 할 수 있다
 - 아이디는 6자 ~ 12자 이내이며, 중복 되는 값을 허용할 수 없고, 반드시 필요하다
 - 비밀번호는 8자 ~ 12자 이내이며, 비밀번호 확인을 통해 잘못 된 비밀번호가 가입되지 않도록 한다. 
 - 이름은 중복을 허용하는 2자 ~4자이며, 반드시 필요하다.
 - 이메일은 이메일 주소 형식인지 아닌지 검증한다.
 - 전화번호 ( 전화번호 형식인지 아닌지 검증한다)
<jsp:include page="navBar.jsp"></jsp:include>
	<h2 style="text-align: center">login</h2>
	 <div class="container">
		<form action="/controller/post" method="post">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label" >id</label> <input type="text" class="form-control"
					id="userid" name="userid" placeholder="Enter ID"  required>
					<span id="idError"></span>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">password</label> <input type="password" class="form-control"
					id="password" name="password" placeholder="Enter password" required>
					<span id="pwdError"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">confirm password</label> <input type="password" class="form-control"
					id="Cpassword" name="Cpassword" placeholder="confirm password" required>
					<span id="pwdError2"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">name</label> <input type="text" class="form-control"
					id="name" name="name" placeholder="Enter name" required>
					<span id="nameError"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">email</label> <input type="email" class="form-control"
					id="email" name="email" placeholder="Enter email" required>
					<span id="emailError"></span>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">phone</label> <input type="text" class="form-control"
					id="phone" name="phone" placeholder="Enter phone" required>
					<span id="phoneError"></span>
			</div>
			<button type="submit" class="btn btn-outline-secondary">register</button>

		</form>
	</div> 	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>
