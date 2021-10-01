<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>


<title>Insert title here</title>
<script type="text/javascript">
	
	$(function() {

		viewAllReplies();
		editForm();
		editReply();
		deleteReply();
	})
	//댓글리스트받아오기
	function viewAllReplies() {
		let bno = '${param.no}';
		console.log(bno);
		$.ajax({
			url :"../CSreplies/viewReplies/" + bno,
			dataType : "JSON",
			type : "GET",
			success : function(data) {
				showReplyList(data);
			},
			error : function() {

			}

		});
	}

	//리스트 출력
	function showReplyList(data) {
		let output = "";
		if (data.length == 0) {
			output += '<hr><p class="text-secondary" style="text-align:center;">be the FIRST ONE!</p>';
		}
		$.each(data,function(i, e) {
			
							let regDate = new Date(e.date);
							let replyTime = moment(regDate).fromNow()
							let contents = e.contents
							/* if(timeGap<60){
								replyTime=timeGap+"mins ago"
							}else{
								replyTime=moment(regDate).format('YYYY MM DD')
							} */

							if (e.isSecret == 'Y') {
								if (e.replyer == "${loginMember.userid}"
										|| "${loginMember.userid}" == "${board.writer}") {
									output += '<div class="list-group-item list-group-item-action" aria-current="true" id="'+e.no+'"><div class="d-flex w-100 justify-content-between" ><h3>'
											+ e.replyer
											+ '</h3><small>'
											+ replyTime
											+ '</small></div><p class="mb-1">'
											+ e.contents
											+ '</p><a href="javascript:void(0);"><img src="../resources/imgs/delete.png" id="deleteReply"></a>'
									if (e.replyer == "${loginMember.userid}") {
										output += '<a href="javascript:void(0);" ><img src="../resources/imgs/edit.png" id="editForm" ></a>';
									}

								} else {
									output += '<div class="list-group-item list-group-item-action" aria-current="true">secret comment<img src="../resources/imgs/lock.png"></div>';
								}
								output += '</div>'
							} else {
								output += '<div class="list-group-item list-group-item-action" aria-current="true" id="'+e.no+'"><div class="d-flex w-100 justify-content-between"><h3>'
										+ e.replyer
										+ '</h3><small>'
										+ replyTime
										+ '</small></div><p class="mb-1">'
										+ e.contents + '</p>'
								if (e.replyer == "${loginMember.userid}"
										|| "${loginMember.userid}" == "${board.writer}") {
									output += '<a href="javascript:void(0);"><img src="../resources/imgs/delete.png" id="deleteReply"></a>';
									if (e.replyer == "${loginMember.userid}") {
										output += '<a href="javascript:void(0);" ><img src="../resources/imgs/edit.png" id="editForm"></a>';
									}
								}
								output += '</div>';
							}
						})				

		$("#replyList").html(output);						
	}
	//댓글추가
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
			url : "../CSreplies/addReply",
			data : sendData, 
			dataType : "text", 
			type : "POST", 
			contentType : "application/json",

			success : function(data) {
				console.log(data)
				if (data == 'success') {
					$("#replyContents").val('');
				}
				viewAllReplies();
				

			},
			error : function() { 

			}

		});
	}

	function modifyReplyCancel() {
		viewAllReplies();
	}
	//댓글삭제
	function deleteReply(rno) {
		$("body").on("click", "#deleteReply", function() {
			let rno = parseInt($(this).parent().parent().attr("id"));
			console.log(rno)
			$.ajax({
				url : "../CSreplies/deleteReply?rno=" + rno,
				type : "delete",
				success : function(data) {
					console.log(data)
					viewAllReplies();
				},
				error : function(e) {
					console.log(e)
				}

			})

		})
	}
	//댓글 수정
	function editForm() {
		$("body").on("click","#editForm",function() {
				let prevContent = $(this).parent().parent().find("p").html();
				let rno = $(this).parent().parent().attr("id");					
					
				$(this).parent().prev().html("<img src='../resources/imgs/check.png' id='editReply'>");			
				$(this).parent().prev().prev().html("<textarea class='form-control' aria-label='With textarea'id='editedContent' required>"+ prevContent+ "</textarea>");			
				$(this).parent().html("<img src='../resources/imgs/cancel.png' onclick='viewAllReplies();'>");					
		})							
	}								
	function editReply() {
		$("body").on("click","#editReply", function() {
			let rno = $(this).parent().parent().attr("id");
			let editedContent = $("#editedContent").val();
			console.log(rno + editedContent);
			$.ajax({
				url : "../CSreplies/editReply",
				data : JSON.stringify({
					contents : editedContent,
					no : rno
				}),
				contentType : "application/json",
				type : "put",
				success : function(data) {
					console.log(data)
					viewAllReplies();
				},
				error : function(e) {
					console.log(e)
				}

			})

		})
	}				
	function deleteBoard(){
		$("body").on("click","#deleteBoard", function() {
			let bno="${param.no}"
			console.log(bno)
			$.ajax({
				url : "../CSreplies/editReply",
				data : JSON.stringify({
					contents : editedContent,
					no : rno
				}),
				contentType : "application/json",
				type : "put",
				success : function(data) {
					console.log(data)
					viewAllReplies();
				},
				error : function(e) {
					console.log(e)
				}

			})

		})
	}
</script>
</head>
<style>
.list-group {
	padding: 50px
}
</style>
<body>

	<div class="container" id="container">

		<figure>
			<blockquote class="blockquote">
				<h2>${board.title }</h2>
			</blockquote>
			<figcaption class="blockquote-footer" id="writer">writer &emsp; ${board.writer}</figcaption>
			<figcaption class="blockquote-footer" id="readcount">views &emsp; ${board.readcount}</figcaption>
			<figcaption class="blockquote-footer" id="likecount">likes &emsp; ${board.likecount}</figcaption>
		</figure>


		<div class="form-group">
			<label for="content"></label>
			<div>${board.content }</div>

		</div>


		<c:if test="${board.writer==loginMember.userid }">
			<a href="javascript:void(0);"><img src="../resources/imgs/edit.png" id="editBoard"></a>
			<a href="javascript:void(0);"><img src="../resources/imgs/delete.png" id="deleteBoard"></a>
		</c:if>
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='listAll?pageNo=1'">To Lists</button>

		<c:if test="${loginMember!=null }">
			<div class="list-group">
				<div class="input-group">
					<textarea class="form-control" aria-label="With textarea" id="replyContents" required></textarea>
					<button type="button" class="btn btn-outline-secondary" onclick="addReply()">send</button>
					<input type="checkbox" value="" id="isSecret"> <label class="form-check-label"> Secret Comment</label>
				</div>
				<div id="replyList"></div>
			</div>
		</c:if>
	</div>
<%@include file="../liveChat/index.html"%>
	<%@include file="../footer.jsp"%>