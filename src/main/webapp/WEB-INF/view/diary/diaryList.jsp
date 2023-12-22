<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../common/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 일기 목록</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.2/css/bootstrap.min.css">
    
        <!-- 부트스트랩 JS 및 Popper.js, jQuery CDN 추가 -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.2/js/bootstrap.min.js"></script>
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
            transition: transform 0.2s;
        }

        .card:hover {
            transform: scale(1.02);
        }

        .card-title {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #343a40;
        }

        .card-subtitle {
            font-size: 1.5rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }

        .card-text {
            font-size: 1.2rem;
            color: #495057;
        }

        .card-text:last-child {
            margin-bottom: 0;
        }
        .happy-image {
        background-image: url('/project_H/img/happy.png');
        /* 이미지 크기 및 스타일 조정 */
        width: 30px;
        height: 30px;
        display: inline-block;
	    }
	
	    .sad-image {
	        background-image: url('/project_H/img/sad.png');
	        width: 30px;
	        height: 30px;
	        display: inline-block;
	    }
	
	    .neutral-image {
	        background-image: url('/project_H/img/neutral.png');
	        width: 30px;
	        height: 30px;
	        display: inline-block;
	    }
		.scroll-to-top {
		    display: none;
		    position: fixed;
		    bottom: 20px;
		    right: 20px;
		    background-color: #c3adec;
		    color: #black;
		    padding: 10px 15px;
		    border-radius: 5px;
		    text-decoration: none;
		}
		
		.scroll-to-top:hover {
		    background-color: #c3adec;
		}
		
		/* 스크롤 위치에 따라 버튼 표시/숨김 */
		body {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}
		
		html {
		    scroll-behavior: smooth;
		}
		
		.scroll-to-top.visible {
		    display: block;
		}
		
    </style>
</head>
<body>
<%@ include file="../common/top.jsp" %>
    <div class="container mt-5">
        <h1 class="mb-4 text-center text-white">나의 일기 목록</h1>

    <c:forEach var="userDiary" items="${userDiaryList}">
    <div class="diary-entry">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">
                    <a href="${pageContext.request.contextPath}/diary/view/${userDiary.ucid}"
                        style="text-decoration: none; color: #343a40;">
                        ${userDiary.nickname}님의 '${userDiary.title}' 색 일기
                    </a>
                </h5>
                  <!-- 기분에 따라 이미지 표시 -->
                <h6 class="card-subtitle mb-2 text-muted">
                    <c:choose>
                        <c:when test="${userDiary.sentiment eq 'positive'}">
                            <img src="/project_H/img/happy.png" alt="Happy" width="30" height="30" />
                        </c:when>
                        <c:when test="${userDiary.sentiment eq 'negative'}">
                            <img src="/project_H/img/sad.png" alt="Sad" width="30" height="30" />
                        </c:when>
                        <c:when test="${userDiary.sentiment eq 'neutral'}">
                            <img src="/project_H/img/neutral.png" alt="Neutral" width="30" height="30" />
                        </c:when>
                        <c:otherwise>
                            <!-- 기분이 Happy, Sad, Neutral이 아닌 경우에 대한 처리 -->
                            기분을 표시할 이미지가 없음
                        </c:otherwise>
                    </c:choose>
                </h6>
                <p class="card-text">내용 : ${userDiary.content}</p>
                <p class="card-text">수정 시간: <fmt:formatDate value="${userDiary.modTime}" pattern="yyyy-MM-dd HH:mm" /></p>
            </div>
        </div>
    </div>
</c:forEach>
    </div>
	<!-- Scroll to Top Button -->
	<a href="#top" class="scroll-to-top">맨 위로 이동</a>
	  <!-- 스크립트를 HTML 문서의 끝 부분에 추가 -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var scrollBtn = document.querySelector('.scroll-to-top');

            window.addEventListener('scroll', function () {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    scrollBtn.classList.add('visible');
                } else {
                    scrollBtn.classList.remove('visible');
                }
            });
        });
    </script>
    
</body>
</html>
