<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="common/head.jsp" %>
	<style>

    body {
        margin: 0;
        font-family: 'Hi Melody', sans-serif;
        overflow: hidden;
    }
    
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

        .card-container {
            display: flex;
            justify-content: space-around;
            padding: 20px;
        }

        .card {
            width: 12rem; /* Adjust the width as needed */
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }
        
        .card-title {
        	text-align: center;
        	font-size: 2.0em;
        }
   

</style>
 <script>
	 //리소스 로딩(예: 자원 로딩)을 시뮬레이트하여 콘텐츠를 표시하기 전에 지연
	 setTimeout(function() {
	   var loadingScreen = document.getElementById('loading-screen');
	   var content = document.getElementById('content');
	   var cards = document.querySelectorAll('.card');
	
	   // 로딩 화면을 서서히 사라지게 함
	   loadingScreen.style.opacity = 0;
	
	   // 콘텐츠를 서서히 나타나게 함
	   content.style.opacity = 1;
	   
	   // Make cards appear gradually
       cards.forEach(function (card) {
           card.style.opacity = 1;
       });
	
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
      <h1 style="font-family: 'Silkscreen', sans-serif;">Today's diary</h1>
    </div>
	<%@ include file="common/top.jsp" %>
	
	<div class="card-container" style="margin-top:20px; margin-left:-20px;">
		<div class="row">
			<div class="col-10">
		        <!-- Bootstrap Card 1 -->
		        <div class="card" style="width: 900px; margin-left: 30px; background-color: ${sessionScope.homeColor.mainColor_code}; border: 1px solid #ccc; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
				    <div class="card-header" style="background-color: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 10px 10px 0 0;">
				        <h5 class="card-title" style="margin: 0; font-size: 1.5em;">&lt; 오늘의 긍정의 한 마디 &gt;</h5>
				    </div>
				    <div class="card-body1" style="padding: 20px;">
				        <h5 class="card-word" style="text-align: center; font-size: 2.5em; margin: 0;">"${sessionScope.homeColor.todayWord}"</h5>
				    </div>
				    <div class="card-footer" style="font-size: 1.3em; background-color: #f8f9fa; padding: 15px; border-top: 1px solid #ddd; border-radius: 0 0 10px 10px;">
				        <div style='color:${sessionScope.homeColor.mainColor_code}; float: left;'>오늘의 색: ${sessionScope.homeColor.mainColor}</div>
				        <div style="float: right;">이 달의 총 일기 제출 수: ${sessionScope.count}</div>
				        <div style="clear: both;"></div>
				    </div>
				</div>
			</div>
		
			
			<div class="col-2">
		        
	        </div>
	    
			<div class="col-5">
		        <!-- Bootstrap Card 2 -->
		        <div class="card" style="width: 440px; height: 440px; margin-left: 30px;">
		            <div class="card-body2">
		                <h5 class="card-title">유저가 가장 많이 선택한 메인 컬러 TOP 3</h5>
		                <!-- Add card content here -->
		            </div>
		        </div>
			</div>
			<div class="col-5">
				<!-- Bootstrap Card 3 -->
		        <div class="card" style="width: 440px; height: 440px; margin-left: 90px;">
		            <div class="card-body3">
		                <h5 class="card-title">감정 비율 3가지(긍정, 중립, 부정)</h5>
		                <!-- Add card content here -->
		            </div>
		        </div>
			</div>
			<div class="col-2">
			</div>
	    </div>
	    <div class="card-container" style="margin-left:20px;">
		    <div class="row">
		    	
		    		<!-- Bootstrap Card 4 -->
			        <div class="card" style="width: 280px; height: 720px; margin-bottom: 40px; margin-top: -20px;" >
			                <h5 class="card-title"></h5>
			            <div class="card-header">
		            	<h5 class="card-title">날씨</h5>
		            </div>
				    <div class="card-body1">
				    	<br>
				    	<h5 class="card-word" style="text-align: center; font-size: 2.5em;">회원랭킹 <br>(공감수) TOP 10</h5>
				    	<br>
			    	</div>
					    <div class="card-footer" style="font-size: 1.3em;">
			    		</div>
			        </div>
		    </div>
		</div>
	</div>
	    

</body>
</html>