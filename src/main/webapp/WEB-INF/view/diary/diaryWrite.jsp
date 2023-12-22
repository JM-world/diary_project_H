<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘의 일기</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Hi Melody', cursive; 
            background: url('/project_H/img/pa.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .layout {
            display: flex;
            flex-direction: row; /* 내부 요소를 수직으로 정렬하기 위해 추가 */
            max-width: 1000px;
            margin: 0 auto; /* 변경된 부분: 오른쪽 여백 20px */
            
        }
        

       	.info {
        flex: 1;
        box-sizing: border-box;
        border: 2px solid #ddd;
        padding: 10px;
        border-radius: 5px;
        /* 그라데이션 효과 추가 */
        background: linear-gradient(to right, ${not empty sessionScope.todayColor.color_code2 ? sessionScope.todayColor.color_code2 : ''}, ${not empty sessionScope.todayColor.mainColor_code1 ? sessionScope.todayColor.mainColor_code1 : ''});
        text-align: center;
        display: flex;
        flex-direction: column;
    	}
        .info div {
            margin-bottom: 10px;
        }

        .input-container {
            flex: 1;
            box-sizing: border-box;
            border: 2px solid #ddd;
            padding: 10px;
            border-radius: 5px;
           	background-color: ${not empty sessionScope.todayColor ? sessionScope.todayColor.mainColor_code1 : ''};
            position: relative;
        }

        #content {
            width: 100%;
            box-sizing: border-box;
           	background-color: ${not empty sessionScope.todayColor ? sessionScope.todayColor.mainColor_code1 : ''};
            resize: none;
        }

        .form-check {
            position: absolute;
            bottom: 0;
            left: 0;
            padding: 10px;
        }
        
    </style>
    <script>
        function checkContentAndRead() {
            let val = $('#content').val();

            if (val !== null && val !== undefined) {
                read();
            }
        }

        function read() {
            let val = $('#content').val();

            if (val.length % 10 == 0) {
                $.ajax({
                    type: 'GET',
                    url: '/project_H/diary/write_in',
                    data: { contentIn: val },
                    success: function (result) {
                        $('#content-out').html(result);
                    }
                });
            }
        }

        function wordCheck() {
            let val = $('#content').val();

            if (val.length < 30) {
                alert("30자 이상 써주세요.")
                return false;
            }
            return true;
        }

        let msg = '${msg}';
        alert(msg);
    </script>
</head>

<body>
    <div class="layout" style="margin-top:80px; height:650px;">
        <div class="info">
            <c:choose>
                <c:when test="${not empty sessionScope.todayColor}">
                    <div>
                        <p style="font-size: 48px;">${sessionScope.todayColor.title}</p>
                        <p style="font-size: 32px;">-${sessionScope.todayColor.subTitle}-</p>
                        <p style="font-size: 18px;">${sessionScope.todayColor.explan}</p>
                        <p style="font-size: 32px;">오늘의 질문</p>
                        <p style="font-size: 18px;"> ${sessionScope.todayColor.question}</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>세션에 오늘의 색 정보가 없습니다.</p>
                </c:otherwise>
            </c:choose>
            
                    <div id="content-out"></div>
        </div>
	        <div class="input-container" style="position: relative;">
            <form action="/project_H/diary/diaryWrite" method="post" onsubmit="return wordCheck()">
            
	            <div class="form-check" style="position: absolute; padding: 10px; left: 0; ">
	                <input type="checkbox" id="share" name="share" class="form-check-input" style="margin-left:5px;">
	                <input type="hidden" name="_share" value="on" />
	                <label style="float:left; margin-left:5px;">공유게시판에 포스팅하기</label>
	                <br>
	            </div>

                <textarea class="form-control" rows="40" name="content" id="content"  onkeyup="checkContentAndRead()"
                	style="height:590px;"> ${content} </textarea>
        		<button style="float:right" onclick="location.href='/project_H/home'" 
        			class="btn btn-secondary mt-2 p-1">홈으로</button>
                <button type="submit" style="margin-right:10px; float:right" class="btn btn-primary mt-2 p-1">제출하기</button>
                
            </form>
        </div>
    </div>
</body>
</html>