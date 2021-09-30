<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../navBar.jsp"%>
</head>
<script>
	function readBoard(no) {
		location.href='../cs/readBoard?no=' + no;
	}
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
				<ul class="pagination" >
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
							href="../cs/listAll?pageNo=${pagingInfo.totalPage }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&raquo;</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	
	<%@include file="../footer.jsp"%>
