<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BBS List</title>
    <script src="https://kit.fontawesome.com/fdb840a8cc.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-image: url('/project_H/img/CCC.PNG');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }

        #container {
            width: 70%;
            margin: 0 auto;
            position: relative;
        }

        #list {
            text-align: center;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
            margin-bottom: 5cm;
        }

        #list img {
            display: inline-block;
            margin: auto;
        }

        .table {
            background-color: rgba(255, 255, 255, 0.8);
            z-index: 2;
            position: relative;
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .table th {
            background-color: #f2f2f2;
        }

        .table tbody tr:hover {
            background-color: #f5f5f5;
        }

        .table-container {
            position: relative;
            z-index: 2;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: -8cm;
        }

		#write {
		    position: relative;
		    top: -19cm; /* 수정된 부분: 음수 값으로 조절 */
		    z-index: 1;
		    text-align: right;
		    color: white;
		}
    </style>
</head>
<body>
    <div id="container">
        <div align="right">
            <c:if test="${id != null}">
                <%-- <%@include file="loginOk.jsp" %> --%>
            </c:if>
            <c:if test="${id == null}">
                <%-- <%@include file="login.jsp" %> --%>
            </c:if>
        </div>

        <div id="list">
            <img src="/project_H/img/누끼책.gif" alt="게시판 이미지">
        </div>

        <div class="table-container">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th width="5%">번호</th>
                        <th width="35%">제목</th>
                        <th width="10%">작성자</th>
                        <th width="10%">조회수</th>
                        <th width="20%">작성일</th>
                        <th width="10%"><i class="fa-regular fa-thumbs-up"></i></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="board" items="${boardList}" varStatus="status">
                        <tr>
                            <td>${board.bid}</td>
                            <td id="title">
                                <a href="/project_H/board/view/${board.bid}">${board.title}</a>
                                <c:if test="${board.hitCount >= 20}">
                                    <span class="hitCount">hit!</span>
                                </c:if>
                            </td>
                            <td>${board.nickname}</td>
                            <td>${board.viewCount}</td>
                            <td>
                                <fmt:formatDate value="${board.modTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td>${board.hitCount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div id="write">
            <a href="/project_H/board/write">
                <i class="fa-solid fa-pen">글 쓰기</i>
            </a>
        </div>
    </div>
</body>
</html>
