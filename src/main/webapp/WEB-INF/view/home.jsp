<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <script>
	 //리소스 로딩(예: 자원 로딩)을 시뮬레이트하여 콘텐츠를 표시하기 전에 지연
	 setTimeout(function() {
	   var loadingScreen = document.getElementById('loading-screen');
	   var content = document.getElementById('content');
	
	   // 로딩 화면을 서서히 사라지게 함
	   loadingScreen.style.opacity = 0;
	
	   // 콘텐츠를 서서히 나타나게 함
	   content.style.opacity = 1;
	
	   // 애니메이션이 완료된 후에 로딩 화면을 숨김
	   setTimeout(function() {
	     loadingScreen.style.display = 'none';
	   }, 1000); 
	 }, 2000);
 </script>
 <style>
 	#loading-screen {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: #ffffff;
        display: flex;
        justify-content: center;
        align-items: center;
        opacity: 1;
        transition: opacity 1s ease-in-out;
    }
    
    #content {
        opacity: 0;
        transition: opacity 1s ease-in-out;
    }
 </style>
</head>
<body>
	<!-- 서서히 보여지는 화면 -->
    <div id="loading-screen">
      <h1>Today's diary</h1>
    </div>
	<%@ include file="common/top.jsp" %>
	<h1>gg</h1>
	<%@ include file="common/bottom.jsp" %>
</body>
</html>