<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/fdb840a8cc.js" crossorigin="anonymous"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <%@ include file="../common/head.jsp" %>
    <style>
        .container {
            width: 60%;
            margin: 50px auto;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #header {
            text-align: center;
            color: white;
            padding: 10px;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .form-group-title,
        .form-group-author {
            margin-bottom: 10px;
        }

        .form-group-hitcount i {
            margin-left: 5px;
        }

        #content {
            resize: none;
            height: 450px;
        }

        .form-group,
        .form-group-title,
        .form-group-author,
        .form-group-hitcount {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-group-buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }

        .form-group-buttons a,
        .form-group-buttons button {
            margin-left: 10px;
        }

        .btn {
            border-radius: 5px;
        }

        #hitCount {
            font-weight: bold;
            font-size: 16px;
        }
    </style>

    <title>상세 내용</title>
</head>

<body>	
 <%@ include file="../common/top.jsp" %>

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
