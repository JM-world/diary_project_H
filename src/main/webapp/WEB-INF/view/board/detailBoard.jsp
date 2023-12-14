<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <!-- 최신 버전의 CSS 파일 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <script src="https://kit.fontawesome.com/fdb840a8cc.js" crossorigin="anonymous"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('/project_H/img/pa.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            width: 60%;
            margin: 50px auto;
        }

        #content {
            resize: none;
            height: 450px; 
        }

        #header {
            text-align: center;
            color: white;
            padding: 10px;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .form-group-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap; /* 여러 행에 걸쳐 정렬 */
            margin-bottom: 10px; /* 아래쪽 여백 조절 가능 */
        }

        .form-group-title label {
            margin-right: 20px; /* 오른쪽 여백 조절 가능 */
        }

        .form-group-hitcount {
            display: flex;
            align-items: center; /* 가운데 정렬 */
        }

        .form-group-hitcount label {
            margin-left: 10px; /* 왼쪽 여백 조절 가능 */
        }

        .form-group-author {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px; /* 윗쪽 여백 조절 가능 */
            margin-bottom: 10px; /* 아래쪽 여백 조절 가능 */
        }

        .form-group-author label {
            margin-right: 20px; /* 오른쪽 여백 조절 가능 */
        }

        .form-group {
            margin-bottom: 10px;
            border: none;
            display: flex;
            justify-content: space-between; /* 좌우로 간격을 벌립니다. */
            align-items: center; /* 세로 중앙 정렬을 유지합니다. */
        }

        .form-group label {
            margin-bottom: 5px; /* 라벨 아래 여백 조절 */
            margin-left: auto; /* 라벨을 오른쪽으로 이동시킵니다. */
        }
        
        .form-group-buttons {
            display: flex;
            justify-content: flex-end;
        }

        .form-group-buttons button {
            margin-left: 10px;
        }
    </style>

    <title>상세 내용</title>
</head>

<body>
    <div class="container">
        <div class="form-group-title">
            <label for="title">제목: ${board.title}</label>
            <div class="form-group-hitcount">
                <label for="viewCount">조회수: ${board.viewCount}</label>
                <i class="far fa-thumbs-up">:  ${board.hitCount}</i>
            </div>
        </div>
        <div class="form-group-author">
            <label for="writer">작성자: <c:out value="${board.nickname}" /></label>
        </div>
      
        <label for="content">내용</label>
        <textarea id="content" name="content" class="form-control" readonly="readonly"><c:out value="${board.content}" /></textarea>
 
        <div class="form-group">
            <label for="regdate">작성날짜: </label>
            <fmt:formatDate value="${board.modTime}" pattern="yyyy-MM-dd" />
        </div>
        <div class="form-group-buttons">
            <a href="${pageContext.request.contextPath}/board/update/${board.bid}" class="update_btn btn btn-warning">수정</a>
            <a href="${pageContext.request.contextPath}/board/delete/${board.bid}" class="delete_btn btn btn-danger">삭제</a>
            <a href="${pageContext.request.contextPath}/board/list/1" class="list_btn btn btn-primary">목록</a>
            <button id="likeBtn" class="btn btn-success" onclick="likeButtonClicked('${board.bid}')">공감</button>
            <div id="hitCount">좋아요: ${board.hitCount}</div>         
        </div>
    </div>
    <script>
        function likeButtonClicked(boardId) {
            // 서버로 공감 수 업데이트 요청 보내기
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "${pageContext.request.contextPath}/board/like/" + boardId, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var hitCount = parseInt(xhr.responseText);
                    if (!isNaN(hitCount) && hitCount >= 0) {
                        // 성공적으로 공감이 증가하면 화면 갱신
                        document.getElementById("hitCount").innerText = "좋아요: " + hitCount;

                        // 공감 여부에 따라 버튼 비활성화
                        if (hitCount > 0) {
                            document.getElementById("likeBtn").disabled = true;
                        }

                        // 성공 후 상세 페이지로 이동
                        var url = "${pageContext.request.contextPath}/board/view/" + boardId;
                        window.location.href = url;
                    } else {
                        console.log("Error: Invalid hit Count received from the server.");
                    }
                }
            };
            xhr.send();
        }

        // 페이지 로딩 시 공감 여부에 따라 버튼 비활성화
        var initialHitCount = ${board.hitCount};
        if (initialHitCount > 0) {
            document.getElementById("likeBtn").disabled = true;
        }
    </script>
</body>
</html>
