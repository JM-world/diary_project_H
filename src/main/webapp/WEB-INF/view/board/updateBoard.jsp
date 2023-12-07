<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: url('/project_H/img/pa.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            width: 60%;
            margin: 50px auto;
            background-color: rgba(255, 255, 255, 0.7);
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: left; /* 왼쪽 정렬 추가 */
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* 왼쪽 정렬 추가 */
        }

        label {
            margin-bottom: 10px;
            font-weight: bold;
            color: #555;
            text-align: left; /* 왼쪽 정렬 추가 */
        }

        input#title {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }

       
        textarea#content {
            width: 100%; 
   			min-height: 500px; 
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
            resize: none; 
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>게시글 수정</h2>

    <form action="${pageContext.request.contextPath}/board/update" method="post">
        <input type="hidden" name="bid" value="${board.bid}" />
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="${board.title}" /><br/>
        <label for="content">내용:</label>
        <textarea id="content" name="content">${board.content}</textarea><br/>
        <input type="submit" value="수정" onclick="updateTimestamp()" />
    </form>

    <script>
        function updateTimestamp() {
            // 현재 시간을 가져와서 hidden 필드에 설정
            var currentDate = new Date();
            var formattedDate = currentDate.toISOString();
            document.getElementById('timestamp').value = formattedDate;
        }
    </script>

</div>

</body>
</html>
