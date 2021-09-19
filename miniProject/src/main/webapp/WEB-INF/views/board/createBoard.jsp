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
<script src="../resources/ckeditor/ckeditor.js"></script>


<title>Insert title here</title>
<script>
	$(function() {
		console.log(CKEDITOR)
		$(".fileDrop").on("dropenter dragover", function(evt) { // 드롭엔터는 파일을 놓을때 발생되는 이벤트.. dragover는 드롭할때
			evt.preventDefault();
		});

		$(".fileDrop")
				.on(
						"drop",
						function(evt) { // ondrop.. 매개변수 evt를 가짐..이대로 하면 브라우저에 이미지를 올리더라도 새창이 열려버림
							evt.preventDefault(); // 이벤트 전파를 막는것이다(drop된 파일이 열리는것을 방지)....32_eventCancel.html에 했다..

							let files = evt.originalEvent.dataTransfer.files; // 드래그된 파일을 얻어올 수 있다
							console.log(files);

							let formData = new FormData(); // form 객체를 생성.
							formData.append("upFile", files[0]); // append 갖다 붙이는거.. form 객체에 파일 첨부
							let url = '/board/uploadFile'
							$
									.ajax({
										url : url, // ajax와 통신 할 곳
										data : formData, // 서블릿에 보낼 데이터
										dataType : "text", // 수신될 데이터의 타입
										type : "POST", // 통신 방식
										processData : false, // 전송하는 데이터를 쿼리스트링 형태로 변환하는지를 결정
										contentType : false, // true일 때, 기본값(application/x-www-form-urlencoded).. 밑의 form에 enctype을 안쓸경우 디폴트값이 나가게 된다
										success : function(data) { // 통신 성공시 수행될 콜백 함수
											console.log(data);
											let ext = data.substr(
													data.lastIndexOf('.') + 1)
													.toLowerCase();
											console.log(ext);

											let isImg = false;
											let output = '';
											let imgAr = [ "jpg", "png", "jpeg",
													"gif" ];
											for (let i = 0; i < imgAr.length; i++) {
												if (ext == imgAr[i]) { //이미지 파일이면\
													output += "<img src='../resources/uploads" + data + "' />";
													isImg = true; // 이미지 파일인지 확인해주는거
													$("#upfileNameThumb").val(
															data); // 이미지 파일이면 썸네일 이미지 파일을 여기에 넣어주고
													let origin1 = data
															.substring(
																	0,
																	data
																			.lastIndexOf("/") + 1); // 파일에서 슬러시를 찾아서 2021/07/13"/" 이부분을 짤라준다.
													let origin2 = data
															.split("thumb_")[1]; // thum_뒷부분부터...
													// 							origin1과 2를 쓰는 이유는 썸네일의 thumb을 지우고 원본 파일을 찾기 위해

													let origin = origin1
															+ origin2;
													$("#upfileNameOrigin").val(
															origin);
													break;
												}
											}
											if (!isImg) {
												//이미지 파일이 아니면 
												output += "<a href='../resources/uploads" + data + "'>"
														+ data + "</a>";
												$("#upfileName").val(data);
											}

											output += "<span id='"
													+ data
													+ "' onclick='delFile(this);'>"
													+ "<img src='../resources/imgs/close.png' width='10px' />"
													+ "</span>";
											$(".fDropList").html(output);

										},
										error : function() { // 통신 실패시 수행될 콜백 함수

										}

									});
						});

		let ckeditor_config = {

			resize_enaleb : true,
			height : 800,
			enterMode : CKEDITOR.ENTER_BR,

			shiftEnterMode : CKEDITOR.ENTER_P,

			filebrowserUploadUrl : '<c:url value="/board/imageUpload" />?${_csrf.parameterName}=${_csrf.token}'

		};

		CKEDITOR.replace('content', ckeditor_config);
	});

	/* function delFile(obj) {
		let origin = $("#upfileNameOrigin").val();
		let thumb = $("#upfileNameThumb").val();
		let notImg = $("#upfileName").val();

		let url = '/board/delFile'
		$.ajax({
			url : url, // ajax와 통신 할 곳
			data : {
				origin : origin,
				thumb : thumb,
				notImg : notImg
			}, // 서블릿에 보낼 데이터
			dataType : "text", // 수신될 데이터의 타입
			type : "POST", // 통신 방식
			success : function(data) { // 통신 성공시 수행될 콜백 함수
				$(".fDropList").empty(); // 파일 업로드 리스트 초기화
				// input type hidden 초기화
				$origin = $("#upfileNameOrigin").val('');
				$thumb = $("#upfileNameThumb").val('');
				$notImg = $("#upfileName").val('');

			},
			error : function() { // 통신 실패시 수행될 콜백 함수

			}

		});
	} */

	function openArea() {
		$(".fileDrop").show();

	}
</script>
</head>
<style>
.fileDrop {
	width: 100%;
	height: 400px;
	border: 2px dotted blue;
	display: none;
}

.fileDrop .fileContent {
	padding: 20px;
	text-align: center;
	margin: 10px auto;
}
</style>

<body>
	<h2>글쓰기 에디터</h2>
	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private, no-store, must-revalidate");
	%>
	<jsp:include page="../navBar.jsp"></jsp:include>

	<div class="container">
		<form action="/board/createBoard" method="post">
			<div class="mb-3">
				<label class="form-label">title</label> <input type="text" class="form-control" id="title" name="title" placeholder="Enter Title">
			</div>
			<input type="text" name="writer" value="${loginMember.userid }" style="display: none;">
			<textarea id="content" name="content"></textarea>
			<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />
			<button type="submit" class="btn btn-outline-secondary">Write</button>
		</form>

		<%-- <h2>글 쓰기 페이지</h2>
		<form action="createBoard" method="post">
			<div class="form-group">
				<label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title"> <span id="titleError" class="error"></span>
			</div>

			<div class="form-group">
				<label for="pwd">수정/삭제 비밀번호 :</label> <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd"><span
					id="pwdError" class="error"></span>
			</div>


			<div class="form-group">
				<label for="writer">작성자 :</label> <input type="text" class="form-control" id="writer" name="writer" value="${sessionScope.loginMember.userid }"><span
					id="writerError" class="error"></span>
			</div>

			<div class="form-group">
				<label for="content">내용 :</label>
				<textarea rows="20" cols="150" id="content" name="content"></textarea>

			</div>

			<div class="form-group">
				<button type="button" class="btn btn-default" onclick="openArea();">파일 업로드</button>
				<div class="fileDrop">
					<div class="fileContent">이 영역에 업로드 할 파일을 드래그드롭 해주세요!</div>
				</div>
				<div class="fDropList"></div>
			</div>



			<input type="hidden" name="thumbimage" id="upfileNameThumb" /> <input type="hidden" name="image" id="upfileNameOrigin" /> <input type="hidden"
				name="notimage" id="upfileName" />


			<button type="submit" class="btn btn-success">저장</button>
			<button type="reset" class="btn btn-warning">취소</button>
		</form>  --%>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>