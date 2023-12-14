<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<script src="https://kit.fontawesome.com/fdb840a8cc.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>
body {
	background-image: url('/project_H/img/pa.jpg');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	margin: 0;
	padding: 0;
}

#container {
	width: 70%;
	margin: 0 auto 0;
}

#list img {
	max-width: 100%;
	display: block;
	margin: auto;
	margin-top: 0cm;
}

#write {
	text-align: right;
}

#write a {
	text-decoration: none;
	color: #007BFF;
}

#write i {
	margin-right: 5px;
}

.table>thead {
	background-color: #FE9A2E;
}

.table>thead>tr>th {
	text-align: center;
}

.table-hover>tbody>tr:hover {
	background-color: #F3E2A9;
}

.table>tbody>tr>td {
	text-align: center;
}

.table>tbody>tr>#title {
	text-align: left;
}

.table>thead>tr>th:nth-child(1), .table>tbody>tr>td:nth-child(1), .table>thead>tr>th:nth-child(3),
	.table>tbody>tr>td:nth-child(3), .table>thead>tr>th:nth-child(4),
	.table>tbody>tr>td:nth-child(4), .table>thead>tr>th:nth-child(5),
	.table>tbody>tr>td:nth-child(5), .table>thead>tr>th:nth-child(6),
	.table>tbody>tr>td:nth-child(6) {
	width: 10%;
}

.table>thead>tr>th:nth-child(2), .table>tbody>tr>td:nth-child(2) {
	width: 35%;
}

#paging {
	text-align: center;
	margin-top: 20px;
}

.pagination {
	display: inline-block;
}

.pagination li {
	display: inline;
	margin: 0 5px;
}

.pagination a {
	text-decoration: none;
	padding: 8px 16px;
	border: 1px solid #007BFF;
	color: #007BFF;
	border-radius: 5px;
}

.pagination .active {
	background-color: #007BFF;
	color: white;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}

.pagination li.disabled a {
	color: #ddd;
	pointer-events: none;
}

#list {
	margin-bottom: -100px;
}

.table {
	background-color: rgba(255, 255, 255, 0.3);
	margin-top: -50px;
}

#write {
	position: relative;
	top: -1.5cm;
}
</style>
</head>
<body>
	<div id="container">
		<div align="right">
			<!-- Login 검증 -->
			<c:if test="${id != null}">
				<%-- <%@include file="loginOk.jsp" %> --%>
			</c:if>
			<c:if test="${id == null}">
				<%-- <%@include file="login.jsp" %> --%>
			</c:if>
		</div>

		<div id="list">
			<img src="/project_H/img/누끼책.gif" alt="게시판 이미지"
				style="margin-top: -80px;">
		</div>



		<div>
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th width="5%">번호</th>
						<th width="35%">제목</th>
						<th width="10%">작성자</th>
						<th width="10%">조회수</th>
						<th width="20%">작성일</th>
						<th width="10%"><i class="fa-regular fa-thumbs-up"></i></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="sharedBoard" items="${userColorList}"
						varStatus="status">
						<tr>
							<td>${sharedBoard.ucid}</td>
							<td><a href=${pageContext.request.contextPath}/diary/view/${sharedBoard.ucid}>
									${sharedBoard.nickname}님의 '${sharedBoard.title}색' 일기 </a></td>
							<td>${sharedBoard.nickname}</td>
							<td>${sharedBoard.viewCount}</td>
							<td><fmt:formatDate value="${sharedBoard.modTime}"
									pattern="yyyy-MM-dd HH:mm" /></td>
							<td>${sharedBoard.hitCount}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			<!-- Paging 처리 -->
			<ul class="pagination">
				<c:if test="${pageList.size() > 1}">
					<c:forEach var="pageNum" items="${pageList}">
						<li
							class="<c:if test='${pageNum eq pageMaker.currentPage}'>active</c:if>">
							<a
							href="/project_H/diary/list/${pageNum}${pageMaker.makeQuery(pageNum)}">${pageNum}</a>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>
