<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="../resources/ckeditor/ckeditor.js"></script>

<title>Insert title here</title>
<script type="text/javascript">
	
	$(function() {

		viewAllReplies();
		editForm();
		editReply();
		deleteReply();
		deleteBoard();
		NestedReplyForm();
		addNestedReply()
		getCsLikeVo()
		editBoardForm()
		
	})
	//댓글리스트받아오기 댓글좋아요 수 댓글 싫어요수,현재유저가 좋아요인지 싫어요인지
	function viewAllReplies() {
		let bno = '${param.no}';
		let userid="${loginMember.userid}";
		console.log(bno);
		$.ajax({
			url :"../CSreplies/viewReplies/"+bno+"/"+userid,
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
		$("#replyList").html('')
		let output = "";
		if (data.length == 0) {
			output += '<hr><p class="text-secondary" style="text-align:center;">be the FIRST ONE!</p>';
			$("#replyList").append(output);
			return
		}
							$.each(data,function(i, e) {
							console.log(e)
							let regDate = new Date(e.date);
							let replyTime = moment(regDate).fromNow()
							let contents = e.contents
							if (e.isSecret == 'Y') {
								if (e.replyer == "${loginMember.userid}"
										|| "${loginMember.userid}" == "${board.writer}") {
									output += '<div class="list-group-item list-group-item-action" aria-current="true" id="'+e.no+'"><div class="d-flex w-100 justify-content-between" ><h3>'
											+ e.replyer
											+ '</h3><small>'
											+ replyTime
											+ '</small></div><p class="mb-1">'
											+ e.contents
											+'</p><a href="javascript:void(0);" ><img src="../resources/imgs/nestedReply.png" id="nestedReplyForm"></a>'
											+ '<a href="javascript:void(0);"><img src="../resources/imgs/delete.png" id="deleteReply"></a>'										
									if (e.replyer == "${loginMember.userid}") {
										output += '<a href="javascript:void(0);" ><img src="../resources/imgs/edit.png" id="editForm" ></a>';
												
									}

								} else {
									output += '<div class="list-group-item list-group-item-action" aria-current="true">secret comment<img src="../resources/imgs/lock.png"></div>';
								}
								if(e.likeordislike==1){
									output +='<span><img src="/resources/imgs/like.png" /></span><span>'+e.likecount+'</span>'
									output +='<span><img src="/resources/imgs/emptyDislike.png" /></span><span>'+e.dislikecount+'</span>'
									
								}else if(e.likeordislike==-1){
									output +='<span><img src="/resources/imgs/emptyLike.png" /></span><span>'+e.likecount+'</span>'
									output +='<span><img src="/resources/imgs/dislike.png" /></span><span>'+e.dislikecount+'</span>'
								}else{
									output +='<span><img src="/resources/imgs/emptyLike.png" /></span><span>'+e.likecount+'</span>'
									output +='<span><img src="/resources/imgs/emptyDislike.png" /></span><span>'+e.dislikecount+'</span>'
								} 
								output += '</div>'
							} else {
								output += '<div class="list-group-item list-group-item-action" aria-current="true" id="'+e.no+'"><div class="d-flex w-100 justify-content-between"><h3>'
										+ e.replyer
										+ '</h3><small>'
										+ replyTime
										+ '</small></div><p class="mb-1">'
										+ e.contents + '</p>'
										+'<a href="javascript:void(0);" ><img src="../resources/imgs/nestedReply.png" id="nestedReplyForm"></a>'
								if (e.replyer == "${loginMember.userid}"
										|| "${loginMember.userid}" == "${board.writer}") {
									output += '<a href="javascript:void(0);"><img src="../resources/imgs/delete.png" id="deleteReply"></a>';
									if (e.replyer == "${loginMember.userid}") {
										output += '<a href="javascript:void(0);" ><img src="../resources/imgs/edit.png" id="editForm"></a>';
									}
								}
								if(e.likeordislike==1){
									output +='<span onclick="processReplyLike(this)"><img src="/resources/imgs/like.png" /></span><span>'+e.likecount+'</span>'
									output +='<span onclick="processReplyDislike(this)"><img src="/resources/imgs/emptyDislike.png" /></span><span>'+e.dislikecount+'</span>'
									
								}else if(e.likeordislike==-1){
									output +='<span onclick="processReplyLike(this)"><img src="/resources/imgs/emptyLike.png" /></span><span>'+e.likecount+'</span>'
									output +='<span onclick="processReplyDislike(this)"><img src="/resources/imgs/dislike.png" /></span><span>'+e.dislikecount+'</span>'
								}else{
									output +='<span onclick="processReplyLike(this)"><img src="/resources/imgs/emptyLike.png" /></span><span>'+e.likecount+'</span>'
									output +='<span onclick="processReplyDislike(this)"><img src="/resources/imgs/emptyDislike.png" /></span><span>'+e.dislikecount+'</span>'
								} 
								output += '</div>';
							}
							if(e.parentno==0){
								$("#replyList").append(output);
								output=''
							}else{
								 $("#replyList").find("#"+e.parentno).last().append(output)
								 output=''
							}
							
						})				

		/* $("#replyList").html(output);	 */					
	}
	//댓글추가
	function addReply() {
		
		let bno = '${param.no}';
		bno = parseInt(bno);
		let writer = "${loginMember.userid}";
		let content = $("#replyContents").val();
		if(content==""){
			return
		}
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
	//댓글 수정 폼
	function editForm() {
		$("body").on("click","#editForm",function() {
				let prevContent = $(this).parent().parent().find("p").html();
				let rno = $(this).parent().parent().attr("id");					
				$(this).parent().prev().prev().html('')	
				$(this).parent().prev().html("<img src='../resources/imgs/check.png' id='editReply'>");			
				$(this).parent().prev().prev().prev().html("<textarea class='form-control' aria-label='With textarea'id='editedContent' required>"+ prevContent+ "</textarea>");			
				$(this).parent().html("<img src='../resources/imgs/cancel.png' onclick='viewAllReplies();'>");					
		})							
	}					
	
	//댓글수정한거 서브밋
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
	//대댓글 폼
	function NestedReplyForm() {
		$("body").on("click","#nestedReplyForm",function() {
		    let referingTo=$(this).parent().parent().find("h3").html()
		    let parentNo=$(this).parent().parent().attr("id")
		    console.log(referingTo+","+parentNo)
						
				$(this).parent().parent().append("<div class='form-control' aria-label='With textarea'id='' contentEditable='true'><a href='#'contentEditable='false'>"+referingTo+"&emsp;</a></div>"
				+"<img src='../resources/imgs/check.png' id='addNestedReply' class='"+parentNo+"'>"
				+"<img src='../resources/imgs/cancel.png' onclick='viewAllReplies();'>")
				$("#addNestedReply").focus()
				$(this).replaceWith('')
		})
	}
	
	
	//대댓글 서브밋
	function addNestedReply(){
		$("body").on("click","#addNestedReply", function() {
			let bno = '${param.no}';
			bno = parseInt(bno);
			let replyer = "${loginMember.userid}";
		    let parentno=parseInt($(this).attr('class'));
		    let contents=$(this).prev().html()
		   
			let sendData = JSON.stringify({
			bno,
			replyer,
			contents,
			parentno
		});

		    console.log(sendData)
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

		})
		
	}
	//글삭제
	function deleteBoard(){
		
		$("body").on("click","#deleteBoard", function() {
			let bno="${param.no}"
			console.log(bno)
			 location.href="../cs/deleteBoard?bno="+bno

		})
	}
	
	//좋아요 
	function getCsLikeVo(){
		
		let bno="${param.no}"
		let userid="${loginMember.userid}"
		let sendData={bno,userid};
		
			 $.ajax({
					url : "../cs/getCSLikeVo",
					data : JSON.stringify(sendData), 
					dataType : "json", 
					type : "POST", 
					contentType:"application/json",
					success : function(data) {
						console.log(typeof(data))
							
						
						if(data.likeordislike==0){
							
							$("#likeDiv").html('<img src="/resources/imgs/emptyLike.png" />')			
							$("#dislikeDiv").html('<img src="/resources/imgs/emptyDislike.png" />')
							
						}
						else if(data.likeordislike==1){
							
							$("#likeDiv").html('<img src="/resources/imgs/like.png" />')			
							$("#dislikeDiv").html('<img src="/resources/imgs/emptyDislike.png" />')		
							
						}
						else if(data.likeordislike==-1){
							
							$("#likeDiv").html('<img src="/resources/imgs/emptyLike.png" />')			
							$("#dislikeDiv").html('<img src="/resources/imgs/dislike.png" />')		
							
						}
						$("#likeSpan").html(data.countlike)
						$("#dislikeSpan").html(data.countdislike)

					},
					error : function() { 

					}

				}); 
		
	}
	//cs 좋아요수 process
	function processLike(){
		let bno="${param.no}"
			let userid="${loginMember.userid}"
			let sendData={bno,userid};
		$.ajax({
			url : "../cs/processLike",
			data : JSON.stringify(sendData),  
			type : "POST", 
			contentType:"application/json",
			success : function(data) {
				console.log(data)
				if(data=="insertLike"){
					$("#likeDiv").html('<img src="/resources/imgs/like.png" />')			
					$("#likeSpan").html(parseInt($("#likeSpan").html())+1)
			
				}else if(data=="deleteLike"){
					$("#likeDiv").html('<img src="/resources/imgs/emptyLike.png" />')
					$("#likeSpan").html(parseInt($("#likeSpan").html())-1)
					
				}else if(data=="increaseLike"){
					$("#likeDiv").html('<img src="/resources/imgs/like.png" />')			
					$("#likeSpan").html(parseInt($("#likeSpan").html())+1)
					$("#dislikeDiv").html('<img src="/resources/imgs/emptyDislike.png" />')			
					$("#dislikeSpan").html(parseInt($("#dislikeSpan").html())-1)
				}
			},
			error : function() { 

			}

		}); 
	}
	//cs싫어요수 process
	function processDislike(){
		let bno="${param.no}"
			let userid="${loginMember.userid}"
			let sendData={bno,userid};
			$.ajax({
				url : "../cs/processDislike",
				data : JSON.stringify(sendData), 
				type : "POST", 
				contentType:"application/json",
				success : function(data) {
					console.log(data)
					if(data=="insertDislike"){
						$("#dislikeDiv").html('<img src="/resources/imgs/dislike.png" />')			
						$("#dislikeSpan").html(parseInt($("#dislikeSpan").html())+1)
						
					}else if(data=="deleteDislike"){
						$("#dislikeDiv").html('<img src="/resources/imgs/emptyDislike.png" />')
						$("#dislikeSpan").html(parseInt($("#dislikeSpan").html())-1)
						
					}else if(data=="increaseDislike"){
						$("#dislikeDiv").html('<img src="/resources/imgs/dislike.png" />')			
						$("#dislikeSpan").html(parseInt($("#dislikeSpan").html())+1)
						$("#likeDiv").html('<img src="/resources/imgs/emptyLike.png" />')			
						$("#likeSpan").html(parseInt($("#likeSpan").html())-1)
					}
			},
			error : function() { 

			}

		}); 
	}
	function processReplyLike(e){
		let rno=$(e).parent().attr("id")
			let userid="${loginMember.userid}"
			let sendData={rno,userid};
		$.ajax({
			url : "../CSreplies/processLike",
			data : JSON.stringify(sendData),  
			type : "POST", 
			contentType:"application/json",
			success : function(data) {
				console.log(data)
				if(data=="insertLike"){
					$(e).html('<img src="/resources/imgs/like.png" />')			
					$(e).next().html(parseInt($(e).next().html())+1)
					
				}else if(data=="deleteLike"){
					$(e).html('<img src="/resources/imgs/emptyLike.png" />')
					$(e).next().html(parseInt($(e).next().html())-1)
					
				}else if(data=="increaseLike"){
					$(e).html('<img src="/resources/imgs/like.png" />')			
					$(e).next().html(parseInt($(e).next().html())+1)
					$(e).next().next().html('<img src="/resources/imgs/emptyLike.png" />')
					$(e).next().next().next().html(parseInt($(e).next().next().next().html())-1)
				}
			},
			error : function() { 

			}

		}); 
	}
	function processReplyDislike(e){
		let rno=$(e).parent().attr("id")
			let userid="${loginMember.userid}"
			let sendData={rno,userid};
			$.ajax({
				url : "../CSreplies/processDislike",
				data : JSON.stringify(sendData), 
				type : "POST", 
				contentType:"application/json",
				success : function(data) {
					console.log(data)
					if(data=="insertDislike"){
						$(e).html('<img src="/resources/imgs/dislike.png" />')			
						$(e).next().html(parseInt($(e).next().html())+1)
						
					}else if(data=="deleteDislike"){
						$(e).html('<img src="/resources/imgs/emptyDislike.png" />')
						$(e).next().html(parseInt($(e).next().html())-1)
						
					}else if(data=="increaseDislike"){
						$(e).html('<img src="/resources/imgs/dislike.png" />')			
						$(e).next().html(parseInt($(e).next().html())+1)
						$(e).prev().prev().html('<img src="/resources/imgs/emptyLike.png" />')			
						$(e).prev().html(parseInt($(e).prev().html())-1)
					}
			},
			error : function() { 

			}

		}); 
	}
	//글수정
	function editBoardForm(){
		
		$("body").on("click","#editBoard", function() {
			console.log("editBoard")
			$("#title").replaceWith('<div class="mb-3" id="titleDiv" style="padding-top:100px">'
					+'<label class="form-label">title</label> <input type="text" value="${board.title}" class="form-control" id="newtitle" name="title" required>'
					+'</div>')
					
			let bno="${param.no}"
			
			let ckeditor_config = {

			resize_enaleb : true,
			height : 800,
			enterMode : CKEDITOR.ENTER_BR,

			shiftEnterMode : CKEDITOR.ENTER_P,

			filebrowserUploadUrl : '<c:url value="/cs/imageUpload" />?${_csrf.parameterName}=${_csrf.token}'

		};

		CKEDITOR.replace('content', ckeditor_config);
		$("#editSubmit").show()	
		$(this).replaceWith("<img src='/resources/imgs/cancel.png' id='cancelEdit' onclick='editBoardCancel()'>")
		})
	}
function editBoardCancel(newtitle){
		
		
			$("#editSubmit").hide();
			$("#titleDiv").replaceWith('<h2 id="title">'+newtitle+'</h2>')
					
		CKEDITOR.instances['content'].destroy()
				
		$('#cancelEdit').replaceWith('<img src="../resources/imgs/edit.png" id="editBoard">')
		
	
	}
	function submitEditedArticle(){
		let no="${param.no}"
		let title=$("#newtitle").val();
		let issecret = "N";
		if ($("#isSecretBoard").is(":checked")) {
			issecret = "Y";
		}
		let newcontent= CKEDITOR.instances['content'].getData();
		sendData={
				no,title,content:newcontent,issecret
		}
		 $.ajax({
			url : "../cs/editBoard",
			data:JSON.stringify(sendData),
			type : "POST", 
			contentType:"application/json",
			success : function(data) {
				console.log(data)
				editBoardCancel(title)
			},
			error : function() { 

			}

		}); 
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




		<h2 id="title">${board.title }</h2>

		<figure>
			<figcaption class="blockquote-footer" id="writer">writer &emsp; ${board.writer}</figcaption>
			<figcaption class="blockquote-footer" id="readcount">views &emsp; ${board.readcount}</figcaption>
		</figure>

		<span id="likeDiv" onclick="processLike()"></span><br> <span id="likeSpan"></span> <br> <span id="dislikeDiv" onclick="processDislike()"></span><br>
		<span id="dislikeSpan"></span>

		<div class="form-group">
			<label for="content"></label>
			<div id="content">${board.content }</div>

		</div>


		<c:if test="${board.writer==loginMember.userid }">
			<a href="javascript:void(0);"><img src="../resources/imgs/edit.png" id="editBoard"></a>
			<a href="javascript:void(0);"><img src="../resources/imgs/delete.png" id="deleteBoard"></a>
		</c:if>
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='listAll?pageNo=1'">To Lists</button>

		<div style="padding: 50px; display: none;" id="editSubmit">
			<c:choose>
				<c:when test="${board.issecret==Y}">
					<label class="form-check-label"> Secret Article</label>
					<input type="checkbox" id="isSecretBoard" checked>
				</c:when>
				<c:otherwise>
					<label class="form-check-label"> Secret Article</label>
					<input type="checkbox" id="isSecretBoard">
				</c:otherwise>
			</c:choose>
			<button class="btn btn-outline-secondary" type="button" onclick="submitEditedArticle()">Submit Edited Article</button>

		</div>

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
	<%-- <%@include file="../liveChat/index.html"%> --%>
	<%@include file="../footer.jsp"%>