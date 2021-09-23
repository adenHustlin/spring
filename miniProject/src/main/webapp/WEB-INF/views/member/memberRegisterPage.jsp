<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
</head>
<script type="text/javascript">
let phoneCode;
let Uflag=false;
let PWflag=false;
let PWCflag=false;
let Nflag=false;
let Eflag=false;
let Pflag=false;
let PCflag=false;
let Bflag=false;
let Gflag=false;
	$(function() {
		
	 			//userid validation
			$("#userid").on("propertychange change keyup paste input",function() {
					let userid = this.value;
					if (userid.search(/\s/g) == -1 && userid.length<=12 && userid.length>=6) {
						$.ajax({
							url : "/security/useridConfirm/" + userid,
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
					}  else if(userid.search(/\s/g) != -1){
						$(this).val('')
						$(this).css('border','1px solid #8A0808');
						$("#useridI").hide()
						$("#useridSpan").html("blank space not allowed ")
						Uflag=false;
					
						}else {
						$(this).css('border','1px solid #8A0808');
						$("#useridI").hide()
						$("#useridSpan").html("Userid must be of length 6 to 12  ")
						Uflag=false;
					} 
					
					console.log(Uflag)
				})
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
						$(this).css('border','1px solid #8A0808');
						$("#passwordI").hide()
						$("#pwdSpan").html('password must be of length 6 to 12')
						$("#CpasswordDiv").hide(300)
						PWflag=false;
					}
					}else{
						$(this).val('')
						$("#passwordI").hide()
						$("#CpasswordDiv").hide(300)
						$(this).css('border','1px solid #8A0808');
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
						$(this).css('border','1px solid #8A0808');
						$("#CpasswordI").hide()
						$("#pwdSpan2").html('Does not match')
						PWCflag=false;
					}
					}else{
						$(this).val('')
						$("#CpasswordI").hide()
						$(this).css('border','1px solid #8A0808');
						$("#pwdSpan2").html('blank space not allowed');
						PWCflag=false;
					}
					console.log(PWCflag)
				})
				//name
				$("#name").on("propertychange change keyup paste input",function(){
					let name=form.name.value;
					if(!name.includes(" ")){
					if(name.length>=2 && name.length<=10){
						$(this).css('border','1px solid #ced4da');
						$("#nameI").show()
						$("#nameSpan").html('valid name')
						Nflag=true;
					}else{
						$(this).css('border','1px solid #8A0808');
						$("#nameI").hide()
						$("#nameSpan").html('name must be of length 2 to 10')
						Nflag=false;
					}
					}else{
						$(this).val('')
						$("#nameI").hide()
						$(this).css('border','1px solid #8A0808');
						$("#nameSpan").html('blank space not allowed');
						Nflag=false;
					}
					console.log(Nflag)
				})
				//email
				 $("#email").on("propertychange change keyup paste input",function(){
					let emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
					let email=form.email.value
					if(!email.includes(" ")){
					if(emailRegExp.test(email)){
						$(this).css('border','1px solid #ced4da');
						$("#emailI").show()			
						$("#emailSpan").html('valid email format');
						Eflag=true;
					}else{
						$(this).css('border','1px solid #8A0808');
						$("#emailI").hide();
						$("#emailSpan").html('Invalid email format');
						Eflag=false;
					}
					}else{
						$(this).val('')
						$("#emailI").hide();
						$(this).css('border','1px solid #8A0808');
						$("#emailSpan").html('blank space not allowed');
						Eflag=false;
					}
					console.log(Eflag)
				})
				 $("#phone").on("propertychange change keyup paste input",function(){
					
					let phone=form.phone.value
					if(!phone.includes(" ")){
					if(phone.length==11){
						$(this).css('border','1px solid #ced4da');
						$("#phoneI").show()
						$("#phoneCbutton").show(300);
						$("#phoneSpan").html('');
						Pflag=true;
					}else{
						$(this).css('border','1px solid #8A0808');
						$("#phoneI").hide();
						$("#phoneCbutton").hide(300);
						$("#phoneSpan").html('Phone Number must be 11 digits');
						Pflag=false;
					}
					}else{
						$(this).val('')
						$("#phoneI").hide();
						$(this).css('border','1px solid #8A0808');
						$("#phoneSpan").html('blank space not allowed');
						Pflag=false;
					}
					console.log(Pflag)
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
						$(this).css('border','1px solid #8A0808');
						$("#CphoneI").hide();
						$("#phoneCSpan").html('Does not match');
						PCflag=false;
					}
					}else{
						
						$("#CphoneI").hide();
						$(this).css('border','1px solid #8A0808');
						$("#phoneCSpan").html('blank space not allowed');
						$(this).val('')
						PCflag=false;
					}
					console.log(PCflag)
				})
				
	})
	function checkAll() {
		console.log(Uflag+","+PWflag+","+PWCflag+","+Nflag+","+Eflag+","+Pflag+","+PCflag)
		
		 if(!Uflag){
			$("#userid").focus()
		}
		if(!PWflag){
			$("#password").focus()
		}
		if(!PWCflag){
			$("#Cpassword").focus()
		}
		if(!Nflag){
			$("#name").focus()
		}
		if(!Eflag){
			$("#email").focus()
		}
		if(!Pflag){
			$("#phone").focus()
		}
		if(!PCflag){
			$("#Cphone").focus()
		} 
		if(Uflag&&PWflag&&PWCflag&&Nflag&&Eflag&&Pflag&&PCflag){
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
</style>
<body>
	
	<h2>Register</h2>
	<div class="container">
		<form action="/security/memberRegister" name="form" method="post" autocomplete="off" onsubmit="return checkAll();">
			<!--userid  -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">id</label> <input type="text" class="form-control" id="userid" name="userid" placeholder="Enter ID"
					required><i id="useridI"><img src="../resources/imgs/check.png"></i><span class="form-text" id="useridSpan">Userid must be of length 6
					to 12</span>
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
					required><i id="nameI"><img src="../resources/imgs/check.png"></i> <span class="form-text" id="nameSpan">name must be of length 2 to
					10</span>
			</div>
			<!-- email -->
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">email</label> <input type="text" class="form-control" id="email" name="email"
					placeholder="Enter email" required><i id="emailI"><img src="../resources/imgs/check.png"></i> <span class="form-text" id="emailSpan"></span>
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
