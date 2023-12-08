<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        body {
            background-image: url('/project_H/img/pa.jpg'); /* 실제 이미지 파일 경로로 변경해주세요 */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed; /* 스크롤시 배경 이미지 고정 (선택사항) */
            margin: 0; /* body의 기본 margin 제거 */
            padding: 0; /* body의 기본 padding 제거 */
        }

        .layout {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            margin-top: 120px;
            display: flex;
            flex-direction: row; /* 레이아웃을 가로로 배치합니다 */
        }

        .left-section {
            flex: 1; /* 왼쪽 섹션이 레이아웃의 1/3만큼 차지하도록 설정 */
            padding-right: 20px; /* 오른쪽 패딩을 추가하여 오른쪽과의 간격 조절 */
            text-align: center; /* 가운데 정렬 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* 입력 창 크기 조정을 위한 추가 스타일 */
        #content {
            height: 600px; /* 원하는 높이로 조절하세요 */
            width: 500px; /* 100%로 설정하여 전체 가로 길이 차지 */
            resize: none; /* 사용자가 크기를 조절하지 못하도록 설정 (선택사항) */
        }

        /* h2 요소를 가운데 정렬하는 스타일 추가 */
        .left-section h2 {
            margin: 0; /* 기본 마진 제거 */
            font-size: 32px; /* 원하는 글자 크기로 조절하세요 */
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
                    data: {contentIn: val},
                    success: function(result) {
                        $('#content-out').html(result);
                    }
                });
            }
        }
    </script>
</head>

<body>
    <div class="layout">
        <div class="left-section">	
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th width="10%">색상 코드</th>
                        <th width="20%">제목</th>
                        <th width="30%">부제목</th>
                        <th width="30%">설명</th>
                        <th width="10%">질문</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="color" items="${todayColors}" varStatus="status">
                        <tr>
                            <td>${color.color_code2}</td>
                            <td>${color.title}</td>
                            <td>${color.subTitle}</td>
                            <td>${color.explan}</td>
                            <td>${color.question}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <form action="/project_H/diary/diaryWrite" method="post">
            <textarea class="form-control" rows="5" name="content" id="content" onkeyup="checkContentAndRead()"></textarea> 
            <br>
            <div class="form-check">
                <input type="checkbox" id="share" name="share" class="form-check-input"> 
                <input type="hidden" name="_share" value="on"/>
                <label>공유게시판에 포스팅하기</label>
                <br>
            </div>
            <button type="submit">제출하기</button>
        </form>
    </div>
</body>
</html>
