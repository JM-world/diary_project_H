<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background: url('/project_H/img/CCC.png') no-repeat center center fixed;
	/* 이미지 경로에 따라 수정하세요 */
	background-size: cover;
	color: white;
}

body {
	font-family: 'Arial', sans-serif;
}

.container {
	width: 60%;
	margin: 50px auto;
	color: white;
}

form {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

label {
	font-weight: bold;
	color: white;
}

button {
	padding: 10px;
	background-color: #2E64FE;
	color: white;
	border: none;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		<h2>글 쓰기</h2>
		<!-- Spring의 form 태그를 사용 -->
		<form:form action="${pageContext.request.contextPath}/board/write"
			method="post" modelAttribute="board">
			<!-- 폼 필드 -->
			<label for="title">제목:</label>
			<form:textarea path="title" id="title" required="true"
				style="height: 1cm;"></form:textarea>

			<label for="content">내용:</label>
			<form:textarea path="content" id="content" rows="4" required="true"
				style="height: 5cm;"></form:textarea>

			<!-- bid와 custId는 hidden 필드로 전송 -->
			<form:hidden path="bid" />
			<form:hidden path="custId" value="${session.getAttribute('custId')}" />
			<form:form action="${pageContext.request.contextPath}/board/write"
				method="post" modelAttribute="board">

				<div style="display: flex; gap: 10px;">
					<button type="submit">글 등록</button>
					<button type="button" onclick="cancel()">취 소</button>
				</div>
			</form:form>
		</form:form>
		<a href="${pageContext.request.contextPath}/board/list/1"style="color: white;">게시글 목록으로
			돌아가기</a>
	</div>
	<script>
		function cancel() {
			window.location.href = "${pageContext.request.contextPath}/board/list/1"; // 취소 시 이동할 페이지
		}
	</script>
</body>
</html>
