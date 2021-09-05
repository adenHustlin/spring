<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
<script>
	$(function(){
		$(".fileDrop").on("dropenter dragover", function(evt){
			evt.preventDefault();
		});
		
		$(".fileDrop").on("drop", function(evt) {
			evt.preventDefault(); // 이벤트 전파를 막음(drop된 파일이 열리는 것을 방지)
			
			let files = evt.originalEvent.dataTransfer.files; // 드래그 된 파일을 얻어옴
			console.log(files);
		});
		
	});
	
	function openArea() {
		$(".fileDrop").show();
	}
</script>
</head>
<style>
	.fileDrop  {
		width:100%;
		height:400px;
		border: 1px dotted blue;
		display: none;
		
	}
	.fileDrop .fileContent {
		padding : 20px;
		text-align: center;
		margin : 10px auto;
	}
</style>
<body>
	<h3>FileUpload Test using Ajax</h3>
	<button type="button" class="btn btn-default" onclick="openArea();">파일 업로드</button>
	<div class="fileDrop">
		<div class="fileContent">이 영역에 업로드 할 파일을 드래그 드롭 해 주세요!</div>
	</div>
	<div class="fDropList"></div>
</body>
</html>