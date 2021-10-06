<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
	integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous"
>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link rel="stylesheet" href="/resources/liveChat/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>

<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css" /> -->
<script>
	function readBoard(no) {
		location.href='../cs/readBoard?no=' + no;
	}
	$(function(){
			search();
			showlist();
	})
	
	function search(){
		$("#searchWord, #searchWith, #sortwith").on("change keyup ",function(){
			showlist();
		})
	}
	
	
	function showlist(){
		
		let searchwith=$("#searchWith").val()
		let searchword=$("#searchWord").val()
		let userid="${loginMember.userid}"
		let sortwith=$("#sortwith").val()
		let sendData={
			searchword,searchwith,userid,sortwith
		}
		$.ajax({
			url : "../cs/getList",
			type : "POST", 
			data:JSON.stringify(sendData),
			contentType : "application/json",
			success : function(data) {
				
				 let container = $('#pagination');
			        container.pagination({
			            dataSource: data,
			            ulClassName:"pagination",
			            callback: function (data, pagination) {
			        
			                var dataHtml;	
			                
			                console.log(data)
			                if(data.length==0){
			                	
			                    dataHtml += '<td></td>';
			                    dataHtml += '<td></td>';
			                    dataHtml += '<td></td>';
			                    dataHtml += '<td><p class="text-secondary" style="text-align:center;">Nothing Found</p></td>';
			                    dataHtml += '<td></td>';
			                    dataHtml += '<td></td>';
			                    dataHtml += '<td></td>';
			                }
			                $.each(data, function (index, item) {
			                	
			                	let tmp=new Date(item.postdate)
			                	let postdate = moment(tmp).calendar();
			                	
			                	if(item.issecret=="N" || item.writer=="${loginMember.userid}"|| "${loginMember.authority}"=="ROLE_ADMIN"){
			                		
			                	dataHtml += '<tr onclick="readBoard('+item.no+');">';
			                    dataHtml += '<td>' + item.no + '</td>';
			                    dataHtml += '<td>'+"[" +item.solved+"] " + item.title + '</td>';
			                    dataHtml += '<td>' + item.writer + '</td>';
			                    dataHtml += '<td>' + postdate + '</td>';
			                    dataHtml += '<td>' + item.readcount + '</td>';
			                    dataHtml += '<td>' + item.likecount + '</td>';
			                    dataHtml += '<td>' + item.dislikecount + '</td></tr>';
			                    
			                	}
			     
			                	else{
			           
			                		dataHtml += '<tr>';
				                    dataHtml += '<td>' + item.no + '<img src="/resources/imgs/lock.png" style="width:30px"></td>';
				                    dataHtml += '<td>'+"[" +item.solved+"] " + item.title + '</td>';
				                    dataHtml += '<td>' + item.writer + '</td>';
				                    dataHtml += '<td>' + postdate + '</td>';
				                    dataHtml += '<td>' + item.readcount + '</td>';
				                    dataHtml += '<td>' + item.likecount + '</td>';
				                    dataHtml += '<td>' + item.dislikecount + '</td></tr>';
				                   
			                		
			                	}
			                });

			          
			                
							 $(".pagination").children("li").attr("class","paginationjs-page J-paginationjs-page page-item") 
							
							 /* $(".page-item").children("a").addClass("page-link")  */
							 $(".pagination").find("a").addClass("page-link")
			                $("#boardlists").html(dataHtml);
			            }
			        })
			
			},
			error : function() { 

			}

		});
		
	}
</script>

<style>
</style>
<body>

	<h2>Customer Service</h2>





	<div class="container" id="container">



		<select class="form-select" id="searchWith" style="width: 300px">
			<option value="title+content" selected>title+content</option>
			<option value="writer">writer</option>
		</select> <input type="text" class="form-control" style="width: 300px" id="searchWord"> <select class="form-select" id="sortwith" style="width: 300px">
			<option value="no" selected>date</option>
			<option value="readcount">most viewed</option>
			<option value="likecount">likes</option>
			<option value="dislikecount">dislikes</option>
		</select>

		<c:choose>
			<c:when test="${listBoard != null }">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">글번호</th>
							<th scope="col">글제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
							<th scope="col">좋아요</th>
							<th scope="col">싫어요</th>
							
						</tr>
					</thead>
					<tbody id="boardlists">
						<%-- <c:forEach var="board" items="${listBoard}">
							<tr onclick="readBoard(${board.no});">
								<th>${board.no }</th>
								<td>${board.title }</td>
								<td>${board.writer }</td>
								<td>${board.postdate }</td>
								<td>${board.readcount }</td>
								<td>${board.likecount }</td>
							</tr>
						</c:forEach> --%>
					</tbody>
				</table>
			</c:when>
		</c:choose>





		<div style="float: right">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='../cs/createBoard';">Write</button>
		</div>

		<div id="pagination"></div>
		<%-- <div style="margin-top: 15px; clear: right;" id="pagelist">

			<ul class="pagination">
				<c:if test="${param.pageNo > 1 }">
					<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=1&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&laquo;</a></li>
				</c:if>
				<c:if test="${param.pageNo > 1 }">
					<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=${param.pageNo - 1}&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&lt;</a>
				</c:if>
				<c:forEach var="i" begin="${pagingInfo.startPageNoOfBlock }" end="${pagingInfo.endPageNoOfBlock }" step="1">
					<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=${i }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">${i }</a></li>
				</c:forEach>
				<c:if test="${param.pageNo < pagingInfo.totalPage }">
					<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=${param.pageNo + 1 }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&gt;</a></li>
				</c:if>
				<c:if test="${param.pageNo < pagingInfo.totalPage }">
					<li class="page-item"><a class="page-link"
						href="../cs/listAll?pageNo=${pagingInfo.totalPage }&searchBy=${param.searchBy}&searchWord=${param.searchWord}"
					>&raquo;</a></li>
				</c:if>
			</ul>

		</div> --%>


		<!--chatroom  -->
		<section class="avenue-messenger">
			<div class="menu">
				<div class="items">
					<span> <a href="#" title="Minimize">&mdash;</a><br> <!--     
     <a href="">enter email</a><br>
     <a href="">email transcript</a><br>--> <a href="#" title="End Chat">&#10005;</a>

					</span>
				</div>
				<div class="button">...</div>
			</div>
			<div class="agent-face">
				<div class="half">
					<img class="agent circle" src="http://askavenue.com/img/17.jpg" alt="Jesse Tino">
				</div>
			</div>
			<div class="chat">
				<div class="chat-title">
					<h1>Jesse Tino</h1>
					<h2>RE/MAX</h2>
					<!--  <figure class="avatar">
      <img src="http://askavenue.com/img/17.jpg" /></figure>-->
				</div>
				<div class="messages">
					<div class="messages-content"></div>
				</div>
				<div class="message-box">
					<textarea type="text" class="message-input" placeholder="Type message..."></textarea>
					<button type="submit" class="message-submit">Send</button>
				</div>
			</div>
	</div>
	</section>
</body>
<%--
<input type="text" id="sessionId" value="${sessionScope.loginMember.userid}" style="display:none"></input>

</body>

	<audio id='audio' src='/resources/liveChat/alarm.mp3'></audio>
	<script  src="/resources/liveChat/script.js"></script> --%>
<%-- <%@include file="../liveChat/livechat.jsp"%> --%>
<%@include file="../footer.jsp"%>