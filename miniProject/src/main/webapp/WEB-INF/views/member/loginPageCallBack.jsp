<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="No-Cache">
<meta http-equiv="Pragma" content="No-Cache">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-client_id" content="496061673952-gifocktg13nj7qq8kf7r8vhcev3g9o01.apps.googleusercontent.com">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<title>Insert title here</title>
</head>
<script>
	//처음 실행하는 함수
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
								personFields : 'phoneNumbers,birthdays,ageRanges,genders,clientData,locations,biographies',
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
							let userid = userInfo.Ht
							let name = userInfo.Pe
							let password=userid
							let email=userid
							let memberVo={
									userid,gender,phone,name,birth,password,email
							}
							let JsonData=JSON.stringify(memberVo);
							console.log(e)
							console.log(googleUser.getBasicProfile())
							$.ajax({
								url : "../security/useridConfirm/" + userid,
								type : "GET",
																
								success : function(data) {
									console.log(data)
									if (data == "exists") {
										$("#loginForm").css("display","none");
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
	//naver
	 var naver_id_login = new naver_id_login("h18VTmg1TLJLG46iZaOw", "http://localhost:8081/security/loginPageCallBack");
  // 접근 토큰 값 출력
  alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    alert(naver_id_login.getProfileData('email'));
    alert(naver_id_login.getProfileData('nickname'));
    alert(naver_id_login.getProfileData('age'));
  }
</script>
<body>


	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private, no-store, must-revalidate");
	%>
	<jsp:include page="../navBar.jsp"></jsp:include>
	<h2>
		<c:out value="${error }" />
	</h2>
	<h2>
		<c:out value="${logout }" />
	</h2>

	<h2 style="text-align: center">login</h2>
	<div class="container">
		<form action="/security/login" method="POST" id="loginForm">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="../resources/imgs/person.png"></label> <input type="text" class="form-control"
					id="userid" name="userid" placeholder="Enter ID" required autofocus>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="/resources/imgs/password.png"></label> <input type="password" class="form-control"
					id="password" name="password" placeholder="Enter password" required>
			</div>

			<div class="form-check form-switch">
				<input class="form-check-input" type="checkbox" name="remember-me" id="remember-me"> <label class="form-check-label" for="remember-me"> Auto
					Login </label>
			</div>
			<%--  <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />  --%>


			<button type="submit" class="btn btn-outline-secondary">Login</button>
			<c:if test="${param.error==1 }">
				<p>login failed</p>
			</c:if>
			<c:if test="${not empty ERRORMSG}">
				<font color="red">
					<p>
						Your login attempt was not successful due to <br /> ${ERRORMSG} <br />userid&emsp;"${userid}"&emsp;does not exists
					</p>
				</font>
			</c:if>




		</form>
		<div class="g-signin2" id="GgCustomLogin"></div>
		<div id="naver_id_login"></div>
		<p class="text-secondary">
			<a href="/security/memberRegisterPage" class="text-secondary">wanna join our crew?</a>
		</p>
	</div>


	<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>