<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
</head>
<script type="text/javascript">
let phoneCode;
let PWflag=false;
let PWCflag=false;
let Pflag=false;
let PCflag=false;
let Bflag=false;
let Gflag=false;
	$(function() {
		
	 			
			
				//password
			$("#password").on("propertychange change keyup paste input",function(){
					let password=this.value
					if(!this.value.includes(" ")){
					if(password.search(/\s/g)==-1 && password.length<=12 && password.length>=6){
						$(this).css('border','1px solid #ced4da');
						$("#passwordI").show()
						$("#pwdSpan").html('valid password')
						$("#CpasswordDiv").show(300)
						PWflag=true;
						
					}else{
						$(this).css('border','1px solid red');
						$("#passwordI").hide()
						$("#pwdSpan").html('password must be of length 6 to 12')
						$("#CpasswordDiv").hide(300)
						PWflag=false;
					}
					}else{
						$(this).val('')
						$("#passwordI").hide()
						$("#CpasswordDiv").hide(300)
						$(this).css('border','1px solid red');
						$("#pwdSpan").html('blank space not allowed');
						PWflag=false;
					}
					console.log(PWflag)
				})
				
				//password confirm
			$("#Cpassword").on("propertychange change keyup paste input",function(){
					if(!this.value.includes(" ")){
					if(form.password.value==form.Cpassword.value){
						$(this).css('border','1px solid #ced4da');
						$("#CpasswordI").show()
						$("#pwdSpan2").html('Password Confirmed')
						PWCflag=true;
					}else{
						$(this).css('border','1px solid red');
						$("#CpasswordI").hide()
						$("#pwdSpan2").html('Does not match')
						PWCflag=false;
					}
					}else{
						$(this).val('')
						$("#CpasswordI").hide()
						$(this).css('border','1px solid red');
						$("#pwdSpan2").html('blank space not allowed');
						PWCflag=false;
					}
					console.log(PWCflag)
				})
				//name
				
				//email
				
				//phone
				  $("#phone").on("propertychange change keyup paste input",function(){
					
					let phone=form.phone.value
					if(!phone.includes(" ")){
					if(phone.length==11){
						$.ajax({
							url:"../security/memberVoListExistance",
							data:{searchType:"phone",keyword:phone},
							type : "GET",
							context:this,
							success:function(data){
								console.log(data)
								if(data=="exists"){						
									$(this).css('border','1px solid red');
									$("#phoneI").hide();
									$("#phoneCbutton").hide(300);
									$("#phoneSpan").html('this phone number alread exists');
									Pflag=false;
								}
								else{
									$(this).css('border','1px solid #ced4da');
									$("#phoneI").show()
									$("#phoneCbutton").show(300);
									$("#phoneSpan").html('valid phone number');
									Pflag=true;
								}
									
							}
						})
						
					}else{
						$(this).css('border','1px solid red');
						$("#phoneI").hide();
						$("#phoneCbutton").hide(300);
						$("#phoneSpan").html('Phone Number must be 11 digits');
						Pflag=false;
					}
					}else{
						$(this).val('')
						$("#phoneI").hide();
						$(this).css('border','1px solid red');
						$("#phoneSpan").html('blank space not allowed');
						Pflag=false;
					}
					
				})
				$("#phoneCbutton").click(function(){
					console.log(form.phone.value)
					$.ajax({
						url : "../security/phoneConfirm",
						data:{toNumber:form.phone.value},
						type : "POST",
						// context:this, 
						success : function(data) {
							console.log(data)
							phoneCode=data;
							$("#phoneCDiv").show(300)
							$("#phoneCSpan").html("if you don't recieve confirmation message in a minute please check your phone number and try again");
						}
					});
				})
				
				$("#Cphone").on("propertychange change keyup paste input",function(){
					
					let Cphone=form.Cphone.value
					if(!Cphone.includes(" ")){
					if(Cphone==phoneCode){
						$(this).css('border','1px solid #ced4da');
						$("#CphoneI").show()
						$("#phoneCSpan").html('confirmed!');
						PCflag=true;
					}else{
						$(this).css('border','1px solid red');
						$("#CphoneI").hide();
						$("#phoneCSpan").html('Does not match');
						PCflag=false;
					}
					}else{
						
						$("#CphoneI").hide();
						$(this).css('border','1px solid red');
						$("#phoneCSpan").html('blank space not allowed');
						$(this).val('')
						PCflag=false;
					}
					console.log(PCflag)
				})
				
	})
	function checkAll() {
		console.log(+PWflag+","+PWCflag+","+Pflag+","+PCflag)
		
		 
		if(!PWflag){
			$("#password").focus()
		}
		if(!PWCflag){
			$("#Cpassword").focus()
		}
		
		if(!Pflag){
			$("#phone").focus()
		}
		if(!PCflag){
			$("#Cphone").focus()
		} 
		if(PWflag&&PWCflag&&Pflag&&PCflag){
			return true;
		}else{
			return false;
		}
		
	}

</script>
<style>

div {
	position: relative;
}

.mb-3 i {
	position: absolute;
	right: 20px;
	top: 36px;
	display: none;
}
h5 {
	text-align: center;
	padding:50px 0px 100px 0px;
} 
</style>
<body>
	
	<h2>Social Member Register</h2>
	<h5>We couldn't get enough information form the platform you used<br>Please fill up the form</h5>
	<div class="container" id="container">
		<form action="/security/memberRegister" name="form" method="post" autocomplete="off" onsubmit="return checkAll();">
			<!--userid  -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">id</label> <input type="text" class="form-control" id="userid" name="userid" placeholder="Enter ID"
					value="${userid }"readonly>
			</div>
			<!--password  -->

			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">password</label> <input type="password" class="form-control" id="password" name="password"
					placeholder="Enter password" required><i id="passwordI"><img src="../resources/imgs/check.png"></i> <span class="form-text" id="pwdSpan">password
					must be of length 6 to 12</span>
			</div>

			<div class="mb-3" style="display: none" id="CpasswordDiv">
				<label for="exampleFormControlInput1" class="form-label">confirm password</label> <input type="password" class="form-control" id="Cpassword"
					name="Cpassword" placeholder="confirm password"><i id="CpasswordI"><img src="../resources/imgs/check.png"></i> <span class="form-text"
					id="pwdSpan2"></span>
			</div>
			<!-- name -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">name</label> <input type="text" class="form-control" id="name" name="name" placeholder="Enter name"
					value="${name}" readonly>
			</div>
			<!-- email -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">email</label> <input type="text" class="form-control" id="email" name="email"
					placeholder="Enter email" value="${userid}" readonly>
			</div>
			<!--phone  -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">phone</label> <input type="text" class="form-control" id="phone" name="phone"
					placeholder="Enter phone" required><i id="phoneI"><img src="../resources/imgs/check.png"></i> <span class="form-text" id="phoneSpan"></span>
				<button style="display: none" type="button" id="phoneCbutton" class="btn btn-outline-secondary">confirm phone</button>
			</div>
			<div class="mb-3" style="display: none" id="phoneCDiv">
				<label for="exampleFormControlInput1" class="form-label">confirm phone</label> <input type="text" class="form-control" id="Cphone" name="Cphone"
					placeholder="confirm phone"><i id="CphoneI"><img src="../resources/imgs/check.png"></i> <span class="form-text" id="phoneCSpan"></span>
			</div>
			<!--birth  -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">birth</label> <input type="date" class="form-control" id="birth" name="birth" required>
			</div>
			<!--gender  -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">gender</label> <select class="form-select" id="gender" name="gender" required>
					<option value="" selected>genders</option>
					<option value="male">male</option>
					<option value="female">female</option>
					<option value="others">others</option>
				</select>
			</div>

			<button type="submit" class="btn btn-outline-secondary">register</button>

		</form>
	</div>
	<%@include file="../footer.jsp"%>
