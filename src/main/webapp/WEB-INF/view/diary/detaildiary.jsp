<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../common/head.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일기장</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
    margin-top: 50px;
    flex: 1;
    box-sizing: border-box;
    border: 2px solid #ddd;
    padding: 10px;
    border-radius: 5px;
    text-align: center;
    display: flex;
    flex-direction: column;
   	background: linear-gradient(to right, ${userColor.color_code2}, ${userColor.color_code2}, ${userColor.mainColor_code1});
}

#todayHeader {
	font-size: 1.7em;
	font-weight: bold;
	text-align: center;
}

#todaytitle {
	font-size: 1.2em;
	font-weight: bold;
	text-align: right;
	margin-bottom: 20px;
}

#todayColor {
	font-size: 1.7em;
	font-weight: bold;
	text-align: center;
	margin-bottom: 20px;
}

#todayContent {
	font-size: 1.2em;
	font-weight: bold;
	text-align: left;
	margin-bottom: 20px;
}

#todayDiaryInfo {
	font-size: 1.2em;
	font-weight: bold;
	text-align: right;
	margin-bottom: 10px;
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

.button-container {
	text-align: right;
	margin-top: 20px;
}

.button-container button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
	margin-left: 10px;
	transition: background-color 0.3s ease-in-out;
}

.button-container button:hover {
	background-color: #0056b3;
}
</style>
<script>
    function updateDiary() {
        var confirmUpdate = confirm('게시글을 수정하시겠습니까?');
        if (confirmUpdate) {
            window.location.href = '/project_H/diary/update/${userColor.ucid}';
        }
    }

    function deleteDiary() {
        var confirmDelete = confirm('게시글을 삭제하시겠습니까?');
        if (confirmDelete) {
            alert('게시글이 삭제 되었습니다.');
            // 삭제를 위한 URL로 이동 또는 필요한 동작 수행
           	window.location.href = '/project_H/diary/delete/${userColor.ucid}';
        }
    }
    
   
    function likeButtonClicked(ucid) {
        var likeUrl = "${pageContext.request.contextPath}/diary/like/" + ucid;
        window.location.href = likeUrl;
    }

</script>
</head>
<body>
<%@ include file="../common/top.jsp" %>
	<div class="layout">
		<!-- 일기 상세 정보 표시 -->
		<div id="todayHeader">
			<h2>${userColor.nickname}님의'${userColor.title}'색일기</h2>
		</div>
		<hr
			style="border-top: 2px solid #000000; width: 100%; margin: 10px 0;">
		<div id="todaytitle">
			<p>작성자: ${userColor.nickname}</p>
		</div>
		<div id="todayColor">
			<p>오늘의 색: ${userColor.title}</p>
			<p>오늘의 기분: ${userColor.sentiment}</p>

    <c:choose>
        <c:when test="${userColor.sentiment eq 'positive'}">
            <img src="/project_H/img/happy.png" alt="Happy" width="30" height="30" />
        </c:when>
        <c:when test="${userColor.sentiment eq 'negative'}">
            <img src="/project_H/img/sad.png" alt="Sad" width="30" height="30" />
        </c:when>
        <c:when test="${userColor.sentiment eq 'neutral'}">
            <img src="/project_H/img/neutral.png" alt="Neutral" width="30" height="30" />
        </c:when>
        <c:otherwise>
            <!-- 기분이 Happy, Sad, Neutral이 아닌 경우에 대한 처리 -->
            <p>이미지가 없음</p>
        </c:otherwise>
    </c:choose>
		</div>
		<hr
			style="border-top: 2px solid #000000; width: 100%; margin: 10px 0;">
		<div id="todayContent">
			<p>내용: ${userColor.content}</p>
		</div>

		<hr
			style="border-top: 2px solid #000000; width: 100%; margin: 10px 0;">
		<div id="todayDiaryInfo">
			<p>조회수: ${userColor.viewCount}</p>
			<p>공감수: ${userColor.hitCount}</p>
			<p>작성일: <fmt:formatDate value="${userColor.modTime}" pattern="yyyy-MM-dd HH:mm" /></p>
		</div>
		
		<div class="button-container">
		    <%-- 수정 버튼은 작성자와 현재 사용자 ID가 일치할 때만 보이도록 처리 --%>
		    <c:if test="${userColor.custId eq sessionScope.sessCustId}">
		        <button id="updateBtn" onclick="updateDiary()">수정</button>
		    </c:if>
		    <%-- 삭제 버튼도 작성자와 현재 사용자 ID가 일치할 때만 보이도록 처리 --%>
		    <c:if test="${userColor.custId eq sessionScope.sessCustId}">
		        <button id="deleteBtn" onclick="deleteDiary()">삭제</button>
		    </c:if>
		   <c:if test="${userColor.custId ne sessionScope.sessCustId}">
	    <button id="likeBtn" onclick="likeButtonClicked('${userColor.ucid}')">공감</button>
	</c:if>

</div>
		
		
	<div style="margin-top: 20px;">
    <a href="/project_H/diary/diarylist">돌아가기</a>
</div>
	</div>
</body>

</html>
