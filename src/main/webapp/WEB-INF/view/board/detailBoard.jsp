<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/fdb840a8cc.js"
	crossorigin="anonymous"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%@ include file="../common/head.jsp"%>
<style>
.container {
	width: 60%;
	margin: -250px auto;
	background-color: rgba(255, 255, 255, 0.9);
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

#header {
	text-align: center;
	color: white;
	padding: 10px;
	background-color: rgba(0, 0, 0, 0.5);
}

.form-group-title, .form-group-author {
	margin-bottom: 10px;
}

.form-group-hitcount i {
	margin-left: 5px;
}

#content {
	resize: none;
	height: 450px;
}

.form-group, .form-group-title, .form-group-author, .form-group-hitcount
	{
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.form-group-buttons {
	display: flex;
	justify-content: flex-end;
	margin-top: 10px;
}

.form-group-buttons a, .form-group-buttons button {
	margin-left: 10px;
}

.btn {
	border-radius: 5px;
}

#hitCount {
	font-weight: bold;
	font-size: 16px;
}

.form-group-date {
	text-align: right;
}
</style>

<title>상세 내용</title>
</head>

<body>
	<%@ include file="../common/top.jsp"%>

	<div class="container">
		<div class="form-group-title">
			<label for="title">제목: ${board.title}</label>
			<div class="form-group-hitcount">
				<label for="viewCount">조회수: ${board.viewCount}</label> <i
					class="far fa-thumbs-up">: ${board.hitCount}</i>
			</div>
		</div>
		<div class="form-group-author">
			<label for="writer">작성자: <c:out value="${board.nickname}" /></label>
		</div>

		<label for="content">내용</label>
		<textarea id="content" name="content" class="form-control"
			readonly="readonly"><c:out value="${board.content}" /></textarea>

		<div class="form-group-date">
			<label for="regdate">작성날짜: </label>
			<fmt:formatDate value="${board.modTime}" pattern="yyyy-MM-dd" />
		</div>
		<div class="form-group-buttons">
			<%-- 수정 버튼은 작성자와 현재 사용자 ID가 일치할 때만 보이도록 처리 --%>
			<c:if test="${board.custId eq sessionScope.sessCustId}">
				<button id="likeBtn" class="btn btn-primary" onclick="updateDiary()">수정</button>
			</c:if>
			<%-- 삭제 버튼도 작성자와 현재 사용자 ID가 일치할 때만 보이도록 처리 --%>
			<c:if test="${board.custId eq sessionScope.sessCustId}">
				<button id="likeBtn" class="btn btn-primary" onclick="deleteDiary()">삭제</button>
			</c:if>
			<button id="likeBtn" class="btn btn-primary"
				onclick="likeButtonClicked('${board.bid}')">공감</button>
			<div
				style="margin-top: 20px; text-align: left; display: inline-block;">
				<a href="javascript:history.back()">← 뒤로가기</a>
			</div>

		</div>

	</div>

	<script>
		function updateDiary() {
			var confirmUpdate = confirm('게시글을 수정하시겠습니까?');
			if (confirmUpdate) {
				window.location.href = '/project_H/board/update/${board.bid}';
			}
		}

		function deleteDiary() {
			var confirmDelete = confirm('게시글을 삭제하시겠습니까?');
			if (confirmDelete) {
				alert('게시글이 삭제 되었습니다.');
				// 삭제를 위한 URL로 이동 또는 필요한 동작 수행
				예: window.location.href = '/project_H/board/delete/${board.bid}';
			}
		}

		function likeButtonClicked(boardId) {
			// 서버에 좋아요 수 업데이트를 요청하는 URL
			var likeUrl = "${pageContext.request.contextPath}/board/like/"
					+ boardId;

			window.location.href = likeUrl;
		}
	</script>





</body>
</html>