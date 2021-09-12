<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="../resources/ckeditor/ckeditor.js"></script>
</head>
<script>
	function readBoard(no) {
		location.href='readBoard?no=' + no;
		
	}
</script>
<body>
${ replyList}
	<jsp:include page="../navBar.jsp"></jsp:include>
	
<div class="container">
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
		<button type="button" class="btn btn-success" onclick="location.href='register';">글 등록</button>
	</div>

	<div style="margin-top: 15px; clear: right;">
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<c:if test="${param.pageNo > 1 }">
					<li class="page-item"><a class="page-link" href="listAll?pageNo=1&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&laquo;</a></li>
				</c:if>
				<c:if test="${param.pageNo > 1 }">
					<li class="page-item"><a class="page-link" href="listAll?pageNo=${param.pageNo - 1}&searchBy=${param.searchBy}&searchWord=${param.searchWord}">previous</a>
				</c:if>
				<c:forEach var="i" begin="${pagingInfo.startPageNoOfBlock }" end="${pagingInfo.endPageNoOfBlock }" step="1">
					<li class="page-item"><a class="page-link" href="listAll?pageNo=${i }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">${i }</a></li>
				</c:forEach>
				<c:if test="${param.pageNo < pagingInfo.totalPage }">
					<li class="page-item"><a class="page-link" href="listAll?pageNo=${param.pageNo + 1 }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">next</a></li>
				</c:if>
				<c:if test="${param.pageNo < pagingInfo.totalPage }">
					<li class="page-item"><a class="page-link" href="listAll?pageNo=${pagingInfo.totalPage }&searchBy=${param.searchBy}&searchWord=${param.searchWord}">&raquo;</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
</html>