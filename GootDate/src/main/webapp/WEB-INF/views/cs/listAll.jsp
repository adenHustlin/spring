<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
	integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous"
> <link rel="stylesheet" href="/resources/liveChat/style.css">
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.3/jquery.mCustomScrollbar.min.css'>

<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.3/jquery.mCustomScrollbar.concat.min.js'></script>  -->
<script>
	function readBoard(no) {
		location.href='../cs/readBoard?no=' + no;
	}
	$(function(){
			
	})

	
</script>

<style>
</style>
<body>

	<h2>Customer Service</h2>
	<div class="container" id="container">
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
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${listBoard}">
							<tr onclick="readBoard(${board.no});">
								<th scope="row">${board.no }</th>
								<td>${board.title }</td>
								<td>${board.writer }</td>
								<td>${board.postdate }</td>
								<td>${board.readcount }</td>
								<td>${board.likecount }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
		</c:choose>

		<div style="float: right">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='../cs/createBoard';">Write</button>
		</div>

		<div style="margin-top: 15px; clear: right;">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<c:if test="${param.pageNo > 1 }">
						<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=1&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&laquo;</a></li>
					</c:if>
					<c:if test="${param.pageNo > 1 }">
						<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=${param.pageNo - 1}&searchBy=${param.searchBy}&searchWord=${param.searchWord}">previous</a>
					</c:if>
					<c:forEach var="i" begin="${pagingInfo.startPageNoOfBlock }" end="${pagingInfo.endPageNoOfBlock }" step="1">
						<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=${i }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">${i }</a></li>
					</c:forEach>
					<c:if test="${param.pageNo < pagingInfo.totalPage }">
						<li class="page-item"><a class="page-link" href="../cs/listAll?pageNo=${param.pageNo + 1 }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">next</a></li>
					</c:if>
					<c:if test="${param.pageNo < pagingInfo.totalPage }">
						<li class="page-item"><a class="page-link"
							href="../cs/listAll?pageNo=${pagingInfo.totalPage }&searchBy=${param.searchBy}&searchWord=${param.searchWord}"
						>&raquo;</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	
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