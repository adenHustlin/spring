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

<title>Insert title here</title>
<script type="text/javascript">
	let urlPath = "http://localhost:8081/";
	$(function() {

		viewAllReplies();

	})

	function viewAllReplies() {
		let bno = '${param.no}';
		console.log(bno);
		$.ajax({
			url : urlPath + "replies/viewReplies/" + bno,
			dataType : "JSON",
			type : "GET",
			success : function(data) {
				console.log(data)
				 showReplyList(data); 
			},
			error : function() {

			}

		});
	}

	function addReply() {
		let bno = '${param.no}';
		bno = parseInt(bno);
		let writer = "${loginMember.userid}";
		let content = $("#replyContents").val();
		let isSecret = "N";
		if ($("#isSecret").is(":checked")) {
			isSecret = "Y";
		}
		let sendData = JSON.stringify({
			bno : bno,
			replyer : writer,
			contents : content,
			isSecret : isSecret
		});
		console.log(sendData);
		$.ajax({
			url : "../replies/addReply", // ajax와 통신 할 곳
			data : sendData, // 서블릿에 보낼 데이터
			dataType : "text", // 수신될 데이터의 타입
			type : "POST", // 통신 방식
			contentType : "application/json",//서블릿에 보낼 데이터 타입

			success : function(data) { // 통신 성공시 수행될 콜백 함수
				if (data == 'success') {
					alert("댓글등록완료");
				}
				viewAllReplies();
				$("")

			},
			error : function() { // 통신 실패시 수행될 콜백 함수

			}

		});
	}
 function showReplyList(data) {
		console.log(data)
		let output = "";
		if(data.length==0){
			output+='<hr><p class="text-secondary" style="text-align:center;">be the FIRST ONE!</p>';
			}
		$.each(data,function(i, e) {
			let regDate = new Date(e.registerDate);
			let today= new Date();
			
			console.log(timeGap);
		
		if (e.isSecret == 'Y') {
			if (e.replyer == "${loginMember.userid}"|| "${loginMember.userid}" == "${board.writer}") {
			output+='<div class="list-group-item list-group-item-action" aria-current="true"><div class="d-flex w-100 justify-content-between"><h2 >'+e.replyer+'</h2><small>'+e.registerDate+'</small></div><p class="mb-1">'+e.contents+'</p><a href="#"><img src="../resources/imgs/delete.png"></a>'
				if(e.replyer == "${loginMember.userid}"){
					output+='<a href="#"><img src="../resources/imgs/edit.png"></a>';
				}
									
				} else {
					output += '<div class="list-group-item list-group-item-action active" aria-current="true"><img src="../resources/imgs/lock.png"></div>';
				}
				output+='</div>'
		} else {
			output+='<div class="list-group-item list-group-item-action" aria-current="true"><div class="d-flex w-100 justify-content-between"><h2 >'+e.replyer+'</h2><small>'+e.registerDate+'</small></div><p class="mb-1">'+e.contents+'</p><a href="#">'
				if (e.replyer == "${loginMember.userid}"|| "${loginMember.userid}" == "${board.writer}"){
					output+='<a href="#"><img src="../resources/imgs/delete.png"></a>';
					if (e.replyer == "${loginMember.userid}"){
						output+='<a href="#"><img src="../resources/imgs/edit.png"></a>';
					}
				}
				output+='</div>';
		}
})

		$("#replyList").empty();
		$("#replyList").html(output);
	} 
	/* function modifyReply(td) {

		let prevReply = $(td).parent().parent().find("td:eq(1)").css
		console.log(prevReply);
		$(td)
				.parent()
				.parent()
				.find("td:eq(1)")
				.html(
						"<td><textarea rows='6' cols='150' value='this.contents'></textarea><button>edit</button><button onclick='modifyReplyCancel(this);'>cancel</button></td>");

	} */
	/* function modifyReplyCancel(td, prevReply) {
		console.log(prevReply)
		$(td).parent().parent().find("td:eq(1)").html(
				"<td>" + prevReply + "</td>")

	} */
</script>
</head>
<body>


	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private, no-store, must-revalidate");
	%>

	<jsp:include page="../navBar.jsp"></jsp:include>
	<div class="container">

		${replyList }

		<figure>
			<blockquote class="blockquote">
				<p>${board.title }</p>
			</blockquote>
			<figcaption class="blockquote-footer" id="writer">writer &emsp; ${board.writer}</figcaption>
			<figcaption class="blockquote-footer" id="readcount">views &emsp; ${board.readcount}</figcaption>
			<figcaption class="blockquote-footer" id="likecount">likes &emsp; ${board.likecount}</figcaption>
		</figure>


		<div class="form-group">
			<label for="content"></label>
			<div>${board.content }</div>

			<c:choose>
				<c:when test="${board.image == '' }">
				</c:when>
				<c:when test="${board.image != null }">
					<img src="../resources/${board.image }" />
				</c:when>
				<c:when test="${board.notimage != null }">
					<a href='../resources/${board.notimage }'>${board.notimage }</a>
				</c:when>

			</c:choose>

		</div>


		<c:if test="${board.writer==loginMember.userid }">
			<a href="#"><img src="../resources/imgs/edit.png"></a>
			<a href="#"><img src="../resources/imgs/delete.png"></a>
		</c:if>
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='listAll?pageNo=1'">목록으로</button>

		<c:if test="${loginMember!=null }">
			<div class="list-group">
				<div class="input-group">
					<textarea class="form-control" aria-label="With textarea" id="replyContents"></textarea>
					<button type="button" class="btn btn-outline-secondary" onclick="addReply()">send</button>
					<input class="form-check-input" type="checkbox" value="" id="isSecret"> <label class="form-check-label"> Secret
						Comment</label>
				</div>
					<div id="replyList"></div>				
			</div>
		</c:if>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>