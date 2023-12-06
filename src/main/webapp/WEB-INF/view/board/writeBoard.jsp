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
            background: url('/project_H/img/pa.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0; /* 페이지 전체의 margin을 0으로 설정하여 꽉 차게 배경 이미지를 표시합니다. */
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 50px auto;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        label {
            font-weight: bold;
        }

        button {
            padding: 10px;
            background-color: #2E64FE;
            color: white;
            border: none;
            cursor: pointer;
        }

        /* 폼 필드 크기 조절 비활성화 */
        #title,
        #content {
            resize: none;
            height: 1cm;
        }

        #content {
            height: 500px;
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
            <form:textarea path="title" id="title" required="true"></form:textarea>

            <label for="content">내용:</label>
            <form:textarea path="content" id="content" rows="4" required="true"></form:textarea>

            <!-- bid와 custId는 hidden 필드로 전송 -->
            <form:hidden path="bid" />
            <form:hidden path="custId" value="${session.getAttribute('custId')}" />

            <div style="display: flex; gap: 10px;">
                <button type="submit">글 등록</button>
                <button type="button" onclick="cancel()">취 소</button>
            </div>
        </form:form>
        <a href="${pageContext.request.contextPath}/board/list/1">게시글 목록으로
            돌아가기</a>
    </div>
    <script>
        function cancel() {
            window.location.href = "${pageContext.request.contextPath}/board/list/1"; // 취소 시 이동할 페이지
        }
    </script>
</body>
</html>
