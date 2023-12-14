<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-light fixed-bottom">
	        <ul class="navbar-nav">
	            <c:if test="${not empty sessNickname}">
	                <span class="navbar-text me-3">${sessNickname}님 환영합니다.</span>
	            </c:if>
	          <li>
	            <span class="navbar-text me-3">임시문구입니다.</span>
	          </li>
	        </ul>
    </nav>
</body>
</html>