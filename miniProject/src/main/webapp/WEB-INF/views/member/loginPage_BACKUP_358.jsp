<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<style>
</style>

<meta name="google-signin-client_id" content='${ClientId}'>
<script>
$(function(){
	$("input").attr("autocomplete","off")
	$("#showFindUseridDiv, .search-close-switch U").click(function(){
		
		$("#findUseridDiv").fadeToggle("slow")
		
	})
	$("#showFindPasswordDiv, .search-close-switch P").click(function(){
		$("#findPasswordDiv").fadeToggle("slow")
		
	})
	
	$("#findUseridEmail").on("propertychange change keyup paste input",function() {
			$.ajax({
				url : "/security/memberExistance/",	
				data:{searchType:"email",keyword:this.value},
				type : "GET",
				context:this,
				success : function(data) {
					console.log(data)
					if (data == "exists") {
						$(this).css("border-bottom","2px solid green")
						$("#Uspan").fadeOut();
						$("#Ubutton").fadeIn();
						
					} else {
						$("#Ubutton").fadeOut();
						$(this).css("border-bottom","2px solid red")
						$("#Uspan").fadeIn().html("Email does not exist")
						
					}
				}
			});
			
			
	})
	$("#Ubutton").click(function(){
		$(this).replaceWith("<img src='../resources/imgs/walking.gif'/>")
		let email=$("#findUseridEmail").val();
		$.ajax({
			url : "/security/sendUseridToEmail/"+email,
			type : "GET",
			success : function(data) {
				console.log(data)
				$("#Udiv").siblings().fadeOut();
				$("#Udiv").html("Userid Sent!")
				 setTimeout(function() {$("#findUseridDiv").fadeOut()}, 3000) 
			}
		});
	})
	$("#findPasswordUserid").on("propertychange change keyup paste input",function() {
		if(this.value.length>1){
			$.ajax({
				url : "/security/useridConfirm/"+this.value,	
				type : "GET",
				context:this,
				success : function(data) {
					console.log(data)
					if (data == "exists") {
						$(this).css("border-bottom","2px solid green")
						$("#Pspan").fadeOut();
						$("#NPdiv,#newPassword").fadeIn();
					} else {
						$(this).css("border-bottom","2px solid red")
						$("#Pspan").fadeIn().html("userid does not exist")
						$("#NPdiv,#newPassword").fadeOut();
					}
				}
			});
		}
			
	})
	/* $("#UPbutton").click(function(){
		$('#findPasswordForm').fadeOut().;
		$('#findPasswordForm').html("<div style='padding-top: 0; font-size: 60px; color: white' id='NPDiv'>Change Password</div><br> <input type='text' id='newPassword' placeholder='Enter new password'><span class='text-secondary' id='NPspan' style='display: none'></span><br> <button type='submit' class='btn btn-outline-secondary' id='NPbutton' style='display: none'>submit</button>")
		$('#findPasswordForm').fadeIn();
		/* $("#findPasswordDiv").fadeOut();
		$("#ChangePasswordDiv").fadeIn();
	}) */
	$("#newPassword").on("propertychange change keyup paste input",function() {
		if(this.value.includes(" ")){
			$(this).css("border-bottom","2px solid red")
			$(this).val("")
			
			}
		
		if(this.value.length>6&&this.value.length<12){
			$("#NPbutton").fadeIn();
			$(this).css("border-bottom","2px solid green")
			$("#NPspan").fadeOut();
		}else{
			$("#NPbutton").fadeOut();
			$(this).css("border-bottom","2px solid red")
			$("#NPspan").fadeIn().html("password must be of length 6 to 12 without blank");
		}
		
	})
	$("#NPbutton").click(function(){
		$(this).replaceWith("<img src='../resources/imgs/walking.gif'/>")
		let Npwd=$("#newPassword").val();
		let userid=$("#findPasswordUserid").val();
		$.ajax({
			url : "/security/changePassword/",
			data:{userid,Npwd},
			type : "GET",
			success : function(data) {
				if(data=="success"){
				$("#NPdiv").siblings().fadeOut();
				$("#NPdiv").html("Password Changed!")
				 setTimeout(function() {$("#findPasswordDiv").fadeOut()}, 3000) 
				}
			}
		});
		
	})
	
})
//google login&register
	function init() {
		gapi
				.load(
						'auth2',
						function() {
							gapi.auth2.init();
							options = new gapi.auth2.SigninOptionsBuilder();
							options.setPrompt('select_account');
							// 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
							options
									.setScope('email profile openid https://www.googleapis.com/auth/userinfo.profile');
							// 인스턴스의 함수 호출 - element에 로그인 기능 추가
							// GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
							gapi.auth2.getAuthInstance().attachClickHandler(
									'GgCustomLogin', options, onSignIn,
									onSignInFailure);
						})
	}

	function onSignIn(googleUser) {
		var access_token = googleUser.getAuthResponse().access_token
		$
				.ajax(
						{
							// people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
							url : 'https://people.googleapis.com/v1/people/me'
							// key에 자신의 API 키를 넣습니다.
							,
							data : {
								personFields : 'phoneNumbers,birthdays,genders,names,emailAddresses',
								key : '${ApiKey}',
								'access_token' : access_token
							},
							method : 'GET',
							
						}).done(
						function(e) {
							let userInfo = googleUser.getBasicProfile()
							let birth = e.birthdays[0].date.year+
									"-"+ e.birthdays[0].date.month
									+"-"+ e.birthdays[0].date.day;
							let gender = e.genders[0].value
							let phone = e.phoneNumbers[0].value
							let userid = e.emailAddresses[0].value
							let name = e.names[0].displayName;
							
							let password=userid
							let email=userid
							let memberVo={
									userid,gender,phone,name,birth,password,email
							}
							let JsonData=JSON.stringify(memberVo);
							console.log(e)
							console.log(JsonData)
							
							$.ajax({
								url : "../security/useridConfirm/" + userid,
								type : "GET",
																
								success : function(data) {
									
									if (data == "exists") {
										$("#container").css("visibility","hidden");
										$("#userid").val(userid);
										$("#password").val(userid);
										$("#loginForm").submit();
									} else {
										console.log(JsonData);
										$.ajax({
											anyne:true,
											url : "../security/SocialMemberRegister",
											data:JsonData,
											contentType: 'application/json',
											type : "POST",
											
											success : function(data) {
												
												location.href="/welcomePage"
												
											},
											error : function() {

											}

										});
									}
								},
								error : function() {

								}

							});
						}).fail(function(e) {
					console.log(e);
				})
	}
	
	function onSignInFailure(t) {
		console.log(t);
	}
	
	function replaceSpace(){
		loginForm.userid.value.replace(" ","")
		loginForm.password.value.replace(" ","")
	}
	
	function emailValidation(email){
		
		$.ajax({
			url : "/security/emailValidation/" + email,
			type : "GET",
			context:this,
			success : function(data) {
				if (data == "exists") {
					$(this).css('border','1px solid #8A0808');
					$("#useridI").hide()
					$("#useridSpan").html("id exsists")
					Uflag=false;
				
				} else {
					
					$("#useridSpan").html("Valid id")
					$("#useridI").show()
					$(this).css('border','1px solid #ced4da');
					Uflag=true;
				}
			}
		});
	}
	
</script>
<body>


	<h2>login</h2>
	<div class="container " id="container">
		<form action="/security/login" method="POST" id="loginForm" onsubmit="replaceSpace();">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="../resources/imgs/person.png"></label> <input type="text" class="form-control"
					id="userid" name="userid" placeholder="Enter ID" required autofocus>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="/resources/imgs/password.png"></label> <input type="password" class="form-control"
					id="password" name="password" placeholder="Enter password" required>
			</div>

			<div class="mb-3 form-switch">
				<input class="form-check-input" type="checkbox" name="remember-me" id="remember-me"> <label class="form-check-label" for="remember-me"> Auto
					Login </label>
			</div>
			<%--  <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />  --%>

			<button type="submit" class="btn btn-outline-secondary" style="">Login</button>
			<c:if test="${param.error==1 }">
				<p>login failed</p>
			</c:if>
			<c:if test="${not empty ERRORMSG}">
				<font color="red">
					<p>
						Your login attempt was not successful due to <br /> ${ERRORMSG} <br />
					</p>
				</font>
			</c:if>

		</form>
		<div style="width: 150px" class="g-signin2" id="GgCustomLogin"></div>

		<p class="text-secondary" style="text-align: center">
			<a href="/security/memberRegisterPage" class="text-secondary">wanna join our crew?</a>
		</p>
		<p class="text-secondary" style="text-align: center">
			Forgot your<a href="# " id="showFindUseridDiv"> userid </a> or<a href="#" id="showFindPasswordDiv"> password</a>?
		</p>

		<div class="search-model U" id="findUseridDiv" style="display: none">
			<div class="h-100 d-flex align-items-center justify-content-center">
				<div class="search-close-switch U">+</div>
				<form class="search-model-form" id="findUseridForm">
					<div style="padding-top: 0; font-size: 60px; color: white" id="Udiv">Find Userid</div>
					<h2 style="color: white">Let us know your email associated with your account</h2>
					<br> <input type="text" id="findUseridEmail" placeholder="Enter your email">
					<button type="submit" class="btn btn-outline-secondary" id="Ubutton" style="display: none">Send Userid</button>
					<br> <span class="text-secondary" id="Uspan" style="display: none"></span>

				</form>
			</div>
		</div>

		<div class="search-model P" id="findPasswordDiv" style="display: none">
			<div class="h-100 d-flex align-items-center justify-content-center">
				<div class="search-close-switch P">+</div>
				<form class="search-model-form" id="findPasswordForm">
					<div style="padding-top: 0; font-size: 60px; color: white">Find Password</div>
					<h2 style="color: white">Let us know your userid associated with your account</h2>
					<br> <input type="text" id="findPasswordUserid" placeholder="Enter your userid"><span class="text-secondary" id="Pspan" style="display: none"></span>
					<br>
					
					<div style="padding-top: 0; font-size: 60px; color: white;display: none" id="NPdiv">Change Password</div>
					<br> <input type="text" id="newPassword" placeholder="Enter new password"style="display: none"><span class="text-secondary" id="NPspan" style="display: none"></span>
					 <br> <button type="submit" class="btn btn-outline-secondary" id="NPbutton" style="display: none">submit</button>
					

				</form>
			</div>
		</div>

		<!-- <div class="search-model C" id="ChangePasswordDiv" style="display: none">
			<div class="h-100 d-flex align-items-center justify-content-center">
				<div class="search-close-switch C">+</div>
				<form class="search-model-form" id="changePasswordForm">
					<div style="padding-top: 0; font-size: 60px; color: white" id="NPDiv">Change Password</div>
					<br> <input type="text" id="newPassword" placeholder="Enter new password"><span class="text-secondary" id="NPspan" style="display: none"></span>
					 <br> <button type="submit" class="btn btn-outline-secondary" id="NPbutton" style="display: none">submit</button>
					
				</form>
			</div>
		</div>  -->


<<<<<<< HEAD
	</div>
	<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>

	<%@include file="../footer.jsp"%>
=======
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>
>>>>>>> c87bb8be037e63cc7c890b8a27ab3ba36b16169f
