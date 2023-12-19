<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판</title>
    
 	
    <style>
    
        #container {
            width: 70%;
            margin: 0 auto 0; /* 가로로 중앙에 배치 */

		#list img {
		    max-width: 100%;
		    display: block;
		    margin: auto;
			margin-top: 0cm;
		}	


        #write {
            text-align: right;
        }

        #write a {
            text-decoration: none;
            color: #007BFF;
        }

        #write i {
            margin-right: 5px;
        }

        /* 게시판 라인 */
        .table > thead {
            background-color: #FE9A2E;
        }
        .table > thead > tr > th {
            text-align: center;
        }
        .table-hover > tbody > tr:hover {
            background-color: #F3E2A9;
        }
        .table > tbody > tr > td {
            text-align: center;
        }
        .table > tbody > tr > #title {
            text-align: left;
        }

        /* 번호, 작성자, 작성일, 조회수, 공감수 각각의 너비 설정 */
        .table > thead > tr > th:nth-child(1),
        .table > tbody > tr > td:nth-child(1),
        .table > thead > tr > th:nth-child(3),
        .table > tbody > tr > td:nth-child(3),
        .table > thead > tr > th:nth-child(5),
        .table > tbody > tr > td:nth-child(5),
        .table > thead > tr > th:nth-child(6),
        .table > tbody > tr > td:nth-child(6) {
            width: 10%;
        }
        
		.table > thead > tr > th:nth-child(4),
		.table > tbody > tr > td:nth-child(4) {
		    width: 20%; 
		}

        /* 제목 너비 조정 */
        .table > thead > tr > th:nth-child(2),
        .table > tbody > tr > td:nth-child(2) {
            width: 35%;
        }

        /* Paging 처리 위치 조정 */
        #paging {
            text-align: center;
            margin-top: 20px;
        }

        .pagination {
            display: inline-block;
        }

        .pagination li {
            display: inline;
            margin: 0 5px;
        }

        .pagination a {
            text-decoration: none;
            padding: 8px 16px;
            border: 1px solid #007BFF;
            color: #007BFF;
            border-radius: 5px;
        }

        .pagination .active {
            background-color: #007BFF;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }

        .pagination li.disabled a {
            color: #ddd;
            pointer-events: none;
        }
        
        
        
	    #list {
	        margin-bottom: -100px; /* 이미지와 하단의 간격을 조절합니다. */
	    }
	
		.table {
	    background-color: rgba(255, 255, 255, 0);
	    margin-top: -50px;
		}
		
			 	
	    
		#write {
	        position: relative;
	        top: -1.5cm; /* 원하는 만큼 위로 올립니다. */
	    }

    </style>
</head>
<body>
<%@ include file="../common/top.jsp" %>
    <div id="container">
        <div align="right">
            <!-- Login 검증 -->
            <!-- jstl의 if문은 else가 없어서 따로 검증해야함. -->
            <c:if test="${id != null}">
                <%-- <%@include file="loginOk.jsp" %> --%>
            </c:if>
            <c:if test="${id == null}">
                <%-- <%@include file="login.jsp" %> --%>
            </c:if>
        </div>

			<div id="list">
			    <img src="/project_H/img/누끼책.gif" alt="게시판 이미지" style=margin-top:-80px;>
			</div>

        <div id="write">
            <a href="/project_H/board/write">
                <i class="fa-solid fa-pen" >글 쓰기</i>
            </a>
        </div>

        <div>
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th width="5%">번호</th>
                        <th width="35%">제목</th>
                        <th width="10%">작성자</th>
                        <th width="40%">작성일</th>
                        <th width="5%">조회수</th>
                        <th width="5%"><i class="fa-regular fa-thumbs-up"></i></th>
                    </tr>
                </thead>
                <tbody>
                   <c:forEach var="board" items="${boardList}" varStatus="status">
    <tr>
        <td>${board.bid}</td>
        <td id="title">
            <a href="/project_H/board/view/${board.bid}">
                ${board.title}
                <!-- 20회 이상 조회수일 때 이미지 표시 -->
                <c:if test="${board.viewCount >= 20}">
                    <img src="/project_H/img/hit.jpg"  style="width: 20px; height: 20px;">
                </c:if>
			            </a>
			        </td>
			        <td>${board.nickname}</td>
			        <!-- fmt:formatDate를 사용하여 시간:분 형식으로 표시 -->
			        <td>
			            <fmt:formatDate value="${board.modTime}" pattern="yyyy-MM-dd HH:mm"/>
			        </td>
			        <td>${board.viewCount}</td>
			        <td>${board.hitCount}</td>
    </tr>
</c:forEach>
                </tbody>
            </table>

            <!-- Paging 처리 -->
            <ul class="pagination">
                <c:if test="${pageList.size() > 1}">
                    <c:forEach var="pageNum" items="${pageList}">
                        <li class="<c:if test='${pageNum eq pageMaker.currentPage}'>active</c:if>">
                            <a href="/project_H/board/list/${pageNum}${pageMaker.makeQuery(pageNum)}">${pageNum}</a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
</body>
</html>