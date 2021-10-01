<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<style>
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>

	
	//google end
	//로그인폼 공백 없애기
	function replaceSpace(){
		loginForm.userid.value.replace(" ","")
		loginForm.password.value.replace(" ","")
	}
	

	
</script>

<body>


	<div class="container " id="container" style="display: none">
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



	</div>
	<script type="text/javascript">
	
	//naver
	
var naverLogin = new naver.LoginWithNaverId(
		{
		  clientId: "${NaverClientIdPrac}",
			 callbackUrl: "http://localhost:8081/security/loginPageCallback", 
			   clientId: "${NaverClientId}",  			
			 callbackUrl: "http://gootacademy.cafe24.com/security/loginPageCallback", 
			   /* clientId: "${NaverClientIdAws}",   
			  callbackUrl: "http://3.34.86.169:8080/security/loginPageCallback",   */
			isPopup: false,
			callbackHandle: true,
			
		}
	);	

naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			let naverProfile=naverLogin.user
			let birth;
			let gender;
			let phone;
			let userid;
			let name;
			let email;
			let password;
			let memberVo;
			name=naverProfile.name
			userid=naverProfile.email
			let jsonData
				
			$.ajax({
				
				url : "../security/useridConfirm/" + userid,
				type : "GET",
				success:function(data){
					console.log(data)
					if(data=="exists"){//디비에 있을경우 바롤로그인
						$("#container").css("visibility","hidden");
						$("#userid").val(userid);
						$("#password").val(userid);
						$("#loginForm").submit();
					}else{//디비에 계정정보 없을경우 바로 회원가입
						try{
							 birth=naverProfile.birthyear+naverProfile.birthday         
				            gender=naverProfile.gender
				            phone=naverProfile.mobile.replaceAll("-","");         
				             email=userid
				             password=email
				            
				            memberVo={
									userid,gender,phone,name,birth,password,email
							}
				            JsonData=JSON.stringify(memberVo);
				            console.log(JsonData)
						}catch(e){
							location.href="../security/SocialMemberRegisterPage?name="+name+"&userid="+userid;
							return;
						}
						
						
						
						$.ajax({
							
							url : "../security/SocialMemberRegister",
							data:JsonData,
							contentType: 'application/json',
							type : "POST",
							
							success : function(data) {
								console.log(data)
								
								location.href="/welcomePage?message=since you joined through naver, no need to confirm your email. Enjoy!&name="+name;
								
							},
							error : function() {

							}

						});
					}
				},error:function(e){
					console.log(e)
				}
            })
            
           
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});

	//naver ends

	
	</script>


</body>
</html>

