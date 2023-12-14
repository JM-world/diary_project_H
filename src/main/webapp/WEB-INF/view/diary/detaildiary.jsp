<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일기 작성</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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

        .layout {
            max-width: 700px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        #todayHeader {
            font-size: 1.7em;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }

        #todayColor {
            font-size: 1.2em;
            font-weight: bold;
            text-align: left;
            margin-bottom: 20px;
        }

        #todayDiary {
            font-size: 1.2em;
            font-weight: bold;
            text-align: left;
            margin-bottom: 10px;
        }

        #content {
            resize: none;
            width: 100%;
            min-height: 300px;
            padding: 20px;
            border: 2px solid #c3adec; 
            border-radius: 0;
            margin-bottom: 20px;
            display: block;
            margin: 30px auto; 
            margin-left: auto;
            margin-right: auto;
            transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        
         #todayContent {
            font-size: 1.2em;
            text-align: left;
            margin-bottom: 20px;
        }

        #content:focus {
            outline: none;
            border-color: #ced4da;
        }

        #selectedDate {
            width: 30%;
            padding: 5px;
            margin-bottom: 10px;
            border: 2px solid #c3adec;
            border-radius: 0;
        }
		
	 	.form-check {
	        text-align: right; /* 변경된 부분: 체크박스를 오른쪽 정렬합니다. */
	    }
		
        .form-check label {
            font-weight: normal;
    		 display: inline-block; /* 변경된 부분: 라벨을 한 줄에 표시하도록 설정합니다. */
    		 margin-bottom: 50px; /* 라벨을 위로 올립니다. 조절 가능한 값으로 조정하세요. */
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: -30px; /* 버튼을 위로 조금 올립니다. */
            float: right; /* 변경된 부분: 버튼을 오른쪽으로 이동시킵니다. */
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
  

<body>
    <div class="layout">
        <!-- 일기 상세 정보 표시 -->
        <h2>${userColor.nickname}님의 '${userColor.title}색' 일기</h2>
        <hr style="border-top: 2px solid #c3adec; width: 100%; margin: 10px 0;">
        <div id="todayColor">
            <p>작성자: ${userColor.nickname}</p>
        </div> 
        <div id="todayContent">
            <p>내용: ${userColor.content}</p>
        </div>   
        <div id="todayColor">
            <p>조회수: ${userColor.viewCount}</p>
        </div>
        <div id="todayDiary">
            <p>작성일: <fmt:formatDate value="${userColor.modTime}" pattern="yyyy-MM-dd HH:mm" /></p>
            <p>좋아요 수: ${userColor.hitCount}</p>
        </div>


    </div>
</body>

</html>
