<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            text-align: left;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        label {
            margin-bottom: 10px;
            font-weight: bold;
            color: #555;
            text-align: left;
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
        .update-btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #FFA500;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        text-decoration: none;
	    }
	
	    /* btn-warning 스타일 덮어쓰기 */
	    .update-btn.btn-warning {
	        background-color: #FFA500;
	        border-color: #FFA500;
	        color: #fff;
	    }
	
	    .update-btn.btn-warning:hover {
	        background-color: #FF8C00;
	        border-color: #FF8C00;
	        color: #fff;
	    }
    </style>
</head>

<body>

    <div class="container">

        <h2>게시글 수정</h2>

        <form action="${pageContext.request.contextPath}/board/update" method="post">
            <input type="hidden" name="bid" value="${board.bid}" />
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="${board.title}" />
            <label for="content">내용:</label>
            <textarea id="content" name="content">${board.content}</textarea>
            <button type="submit" class="update-btn btn btn-warning" onclick="updateTimestamp()">수정</button>

            
        </form>

        <script>
            function updateTimestamp() {
                var currentDate = new Date();
                var formattedDate = currentDate.toISOString();
                document.getElementById('timestamp').value = formattedDate;
            }
        </script>

    </div>

</body>

</html>
