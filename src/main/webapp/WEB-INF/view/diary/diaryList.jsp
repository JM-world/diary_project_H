<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나의 일기 목록</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Hi Melody', cursive;
	background-image: url('/project_H/img/pa.jpg');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: auto;
}

.diary-entry {
	margin-bottom: 20px;
}

.card {
	border: 1px solid #dee2e6;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-title {
	font-size: 1.8rem; /* 조절된 폰트 크기 */
	margin-bottom: 0.5rem;
}

.card-subtitle {
	font-size: 1.5rem; /* 조절된 폰트 크기 */
	color: #6c757d;
	margin-bottom: 0.5rem;
}

.card-text {
	font-size: 1.2rem; /* 조절된 폰트 크기 */
	color: #495057;
}

.card-text:last-child {
	margin-bottom: 0;
}
</style>
</head>
<body>
	<div class="container mt-5">
		<h1 class="mb-4">나의 일기 목록</h1>

		<!-- 일기 목록 반복 출력 -->
		<c:forEach var="userDiary" items="${userDiaryList}">
			<div class="diary-entry">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">
							<a href="${pageContext.request.contextPath}/diary/view/${userDiary.ucid}">
								${userDiary.nickname}님의 '${userDiary.title}' 색 일기 </a>
						</h5>
						<h6 class="card-subtitle mb-2 text-muted">기분:${userDiary.emotion}</h6>
						<p class="card-text">내용 : ${userDiary.content}</p>
						<p class="card-text">수정 시간: <fmt:formatDate value="${userDiary.modTime}" pattern="yyyy-MM-dd HH:mm" /></p>
						
					</div>
				</div>
			</div>
		</c:forEach>
	</div>


	<!-- 부트스트랩 JS 및 Popper.js, jQuery CDN 추가 -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
