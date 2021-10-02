<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="../navBar.jsp"%>


<meta name="google-signin-client_id" content='${GoogleClientId}'>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
$(function(){
	//비번 아이디찾기
	naverLogin.init();
	$("input").attr("autocomplete","off")
	$("#showFindUseridDiv, #closeU").click(function(){
		console.log("asdsa")
		$("#findUseridDiv").fadeToggle("slow")
		
	})
	$("#showFindPasswordDiv, #closeP").click(function(){
		$("#findPasswordDiv").fadeToggle("slow")
		
	})
	
	$("#findUseridEmail").on("input",function() {
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
	$("#findPasswordUserid").on("input",function() {
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

	$("#newPassword").on("input",function() {
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
//비번아이디찾기 끝
//google login&register
	function init() {
		gapi.load('auth2',function() {
							gapi.auth2.init();
							options = new gapi.auth2.SigninOptionsBuilder();
							options.setPrompt('select_account');							
							options.setScope('email profile openid https://www.googleapis.com/auth/userinfo.profile');							
							gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn,onSignInFailure);
						})
	}

	function onSignIn(googleUser) {
		var access_token = googleUser.getAuthResponse().access_token
		$.ajax({
			url : 'https://people.googleapis.com/v1/people/me',
			data : {personFields : 'phoneNumbers,birthdays,genders,names,emailAddresses',key : '${GoogleApiKey}','access_token' : access_token},
			method : 'GET',					
								
		})					
		.done(function(e) {
							let userInfo = googleUser.getBasicProfile()
							console.log(e)
							let birth;
							let gender;
							let phone;
							let userid=userInfo.getEmail();
							let name;
							let email;
							let password;
							let memberVo;
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
										try{//일단 정보충분한지 확인함
											birth = e.birthdays[0].date.year+
													"-"+ e.birthdays[0].date.month
													+"-"+ e.birthdays[0].date.day;
											 gender = e.genders[0].value
											 phone = e.phoneNumbers[0].value.replaceAll("-","")
										 	 userid = e.emailAddresses[0].value
											 name = e.names[0].displayName;
											
											 password=userid
											 email=userid
											 memberVo={
													userid,gender,phone,name,birth,password,email
											 }
											
											}catch (error) {//정보불충분 회원가입페이지이동
												console.log("정보불충분 회원가입페이지이동")
												name = userInfo.getName ()
												userid = userInfo.getEmail ()
												location.href="../security/SocialMemberRegisterPage?name="+name+"&userid="+userid;
												return;
											}
											let JsonData=JSON.stringify(memberVo);
											console.log(memberVo)
											console.log(JsonData)
											$.ajax({
												
												url : "../security/SocialMemberRegister",
												data:JsonData,
												contentType: 'application/json',
												type : "POST",
												
												success : function(data) {
													console.log(data)
													
													location.href="/welcomePage?message=since you joined through google, no need to confirm your email. Enjoy!&name="+name;
													
												},
												error : function() {

												}

											});
										}
									}
								})
								

							}).fail(function(e) {
							console.log(e);	
						
						})
				
										
						
	}
	
	function onSignInFailure(t) {
		console.log(t);
	}
	//google end
	//로그인폼 공백 없애기
	function replaceSpace(){
		loginForm.userid.value.replace(" ","")
		loginForm.password.value.replace(" ","")
	}
	

	//
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
<style>
body {
	margin: 0;
}

.btn-social-login {
	transition: all .2s;
	outline: 0;
	border: 1px solid transparent;
	padding: .5rem !important;
	border-radius: 50%;
	color: #fff;
	height: 50px;
	width: 50px;
}

.btn-social-login:focus {
	box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .25);
}

.text-dark {
	color: #343a40 !important;
}

body {
	height: 60%;
	width: 100%;
}

.search-model {
	/* Set rules to fill background */
	min-height: 100%;
	min-width: 100%;
	/* Set up proportionate scaling */
	width: 100%;
	height: auto;
	display: none;
	/* Set up positioning */
	position: fixed;
	top: 0;
	left: 0;
	background-color: black;
	opacity: 0.8;
	z-index:1000000;
 


}
.btn-close{
position: fixed;
z-index:1000000;
top: 0;
	text-align: center;
	size: 50px;
	width:50px;
	height: 50px;
}
#findPasswordForm{

height: 500px;

}
</style>
<body>


	<h2>login</h2>
	<div class="container " id="container">
		<form action="/security/login" method="POST" id="loginForm" onsubmit="replaceSpace();">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="../resources/imgs/person.png"></label> <input type="text" class="form-control"
					id="userid" name="userid" placeholder="Enter ID" required autofocus
				>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label"><img src="/resources/imgs/password.png"></label> <input type="password" class="form-control"
					id="password" name="password" placeholder="Enter password" required
				>
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
		<p class="text-secondary" style="text-align: center">소셜버튼으로 회원가입시 소셜버튼으로 로그인해주세요</p>
		<hr>
		<button class='btn-social-login' style='background: #D93025' id="GgCustomLogin">
			<i class="xi-2x xi-google"></i>
		</button>

		<button class='btn-social-login' style='background: #1FC700' id="naverIdLogin_loginButton">
			<i class="xi-2x xi-naver"></i>
		</button>


		<button class='btn-social-login' style='background: #FFEB00' onclick="kakaoLogin();">
			<i class="xi-2x xi-kakaotalk text-dark"></i>
		</button>

		<p class="text-secondary" style="text-align: center">
			<a href="/security/memberRegisterPage" class="text-secondary">wanna join our crew?</a>
		</p>
		<p class="text-secondary" style="text-align: center">
			Forgot your<a href="# " id="showFindUseridDiv"> userid </a> or<a href="#" id="showFindPasswordDiv"> password</a>?
		</p>

	</div>
	<!--아이디 비번찾기  -->
	<div class="search-model U" id="findUseridDiv">
		<div class="h-100 d-flex align-items-center justify-content-center" >
			<a class="btn-close"  id="closeU"></a>
			<form class="search-model-form" id="findUseridForm" style="margin:auto;margin-top: 100px">
				<div style="vertical-align:middle; font-size: 60px; color: white" id="Udiv">Find Userid</div>
				<h2 style="color: white">Let us know your email associated with your account</h2>
				<br> <input class="form-control" aria-describedby="inputGroup-sizing-lg" type="text" id="findUseridEmail" placeholder="Enter your email">
				<button type="submit" class="btn btn-outline-secondary" id="Ubutton" style="display: none">Send Userid</button>
				<br> <span class="text-secondary" id="Uspan" style="display: none"></span>

			</form>
		</div>
	</div>

	<div class="search-model P" id="findPasswordDiv">
		<div class="h-100 d-flex align-items-center justify-content-center" style="margin:auto;margin-top: 100px">
			<a class="btn-close"  id="closeP"></a>
			<form class="search-model-form" id="findPasswordForm" style="vertical-align: middle;">
				<div style="vertical-align:middle; font-size: 60px; color: white">Change Password</div>
				<h2 style="color: white">Let us know your userid associated with your account</h2>
				<br> <input class="form-control" type="text" id="findPasswordUserid" placeholder="Enter your userid"><span class="text-secondary" id="Pspan" style="display: none"></span>
				<br>

				<div style="padding-top: 0; font-size: 60px; color: white; display: none" id="NPdiv">Change Password</div>
				<br> <input class="form-control" aria-describedby="inputGroup-sizing-lg" type="text" id="newPassword" placeholder="Enter new password" style="display: none"><span class="text-secondary" id="NPspan"
					style="display: none"
				></span> <br>
				<button type="submit" class="btn btn-outline-secondary" id="NPbutton" style="display: none">submit</button>


			</form>
		</div>
	</div>
	<script type="text/javascript">
	
	//naver
	
var naverLogin = new naver.LoginWithNaverId(
		{
			   /* clientId: "${NaverClientIdPrac}",   
			  callbackUrl: "http://localhost:8081/security/loginPageCallback",  */
			     clientId: "${NaverClientId}",   	
			  callbackUrl: "http://gootacademy.cafe24.com/security/loginPageCallback",  
			   /* clientId: "${NaverClientIdAws}",   
			  callbackUrl: "http://3.34.86.169:8080/security/loginPageCallback",	 */
			  isPopup: false,
			callbackHandle: true,
			
		}
	);	

naverLogin.init();



	//naver ends
	//kakaoStart
	
	Kakao.init('${KakaoClientId}'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
        	  
        	  let userid=response.kakao_account.email
        	  let name=response.kakao_account.profile.nickname
        	  console.log(userid+name)
        	  
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
						}else{
							location.href="../security/SocialMemberRegisterPage?name="+name+"&userid="+userid;
						}
					}
        	  })
        	  
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }

	//kakao ends
	
	</script>

	<%@include file="../footer.jsp"%>

</body>
</html>

