<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@include file="../navBar.jsp"%>

<style>
</style>

<meta name="google-signin-client_id" content="496061673952-gifocktg13nj7qq8kf7r8vhcev3g9o01.apps.googleusercontent.com">
<script>
$(function(){
	$("#showFindUseridDiv, #U").click(function(){
		console.log("asd")
		$("#findUseridDiv").fadeToggle("slow")
		
	})
	$("#showFindPasswordDiv, #P").click(function(){
		$("#findPasswordDiv").fadeToggle("slow")
		
	})
	
	$("#findUseridEmail, #findPasswordEmail").on("propertychange change keyup paste input",function() {
		console.log(this.value)
			$.ajax({
				url : "/security/memberExistance/",
				data:{param:this.value},
				type : "GET",
				context:this,
				success : function(data) {
					console.log(data)
					if (data == "exists") {
						
					
					} else {
					
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
								key : 'AIzaSyD7NhSWF8BizwFbb1Td7YxnLu0tzHERTow',
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
									console.log(data)
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
												console.log(data)
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
			Forgot your<a id="showFindUseridDiv"> userid </a> or<a id="showFindPasswordDiv"> password</a>?
		</p>

		<div class="search-model" id="findUseridDiv" style="display: none">
			<div class="h-100 d-flex align-items-center justify-content-center">
				<div class="search-close-switch U" id="U">+</div>
				<form class="search-model-form" id="findUseridForm">
					<h2 style="text-align: center">Let us know your email associated with your account</h2>
					<br> <input type="text" id="findUseridEmail" placeholder="Enter your email">
					<button type="submit" class="btn btn-outline-secondary" style="">Email Me</button>
				</form>
			</div>
		</div>

		<div class="search-model" id="findPasswordDiv" style="display: none">
			<div class="h-100 d-flex align-items-center justify-content-center">
				<div class="search-close-switch P" id="P">+</div>
				<form class="search-model-form" id="findPasswordForm">
					<h2 style="text-align: center">Let us know your userid and email associated with your account</h2>
					<br> <input type="text" id="findPasswordUserid" placeholder="Enter your userid"> <br> <input type="text" id="findPasswordEmail"
						placeholder="Enter your email">
					<button type="submit" class="btn btn-outline-secondary" style="">Email Me</button>
				</form>
			</div>
		</div>

	</div>
	<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>

	<%@include file="../footer.jsp"%>