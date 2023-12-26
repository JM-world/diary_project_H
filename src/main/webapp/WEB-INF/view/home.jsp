<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="common/head.jsp" %>
	
	<!-- Chart.js CDN-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-datalabels/2.2.0/chartjs-plugin-datalabels.min.js" integrity="sha512-JPcRR8yFa8mmCsfrw4TNte1ZvF1e3+1SdGMslZvmrzDYxS69J7J49vkFL8u6u8PlPJK+H3voElBtUCzaXj+6ig==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
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
        .hidden {
		    display: none;
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
				        <div style='color:${sessionScope.homeColor.mainColor_code}; font-weight: bold;
				        text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black; margin: 0; font-size: 2.0em; text-align: center;'>오늘의 긍정의 한 마디</div>
				    </div>
				    <div class="card-body1" style="padding: 20px;">
				        <h5 class="card-word" id="dynamicWord" style="text-align: center; font-size: 2.5em; margin: 0;">"${sessionScope.homeColor.todayWord}"</h5>
				    </div>
				    <div class="card-footer" style="font-size: 1.3em; background-color: #f8f9fa; padding: 15px; border-top: 1px solid #ddd; border-radius: 0 0 10px 10px;">
				        <div style='color:${sessionScope.homeColor.mainColor_code}; float: left; font-weight: bold;
				        text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;'>오늘의 색: ${sessionScope.homeColor.mainColor}</div>
				        <div style='color:white; float: right; font-weight: bold;
				        text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;'>이 달의 총 일기 제출 수: ${sessionScope.count}</div>
				        <div style="clear: both;"></div>
				    </div>
				</div>
			</div>
			
			<div class="col-2">
		        
	        </div>
	    
			<div class="col-5">
		        <!-- Bootstrap Card 2 -->
		        <div class="card" style="width: 440px; height: 420px; margin-left: 30px; margin-bottom: 40px;">
					<div class="card-header" style='background-color:${sessionScope.homeColor.mainColor_code}; height: 50px;'>
                        <h5 class="card-title">유저들이 가장 많이 선택한 색</h5>
                    </div>
		            <div class="card-body2 ms-5" style="width: 80%; height: 30;">
		                <!-- Add card content here -->
						<canvas id="ColorChart" style='width="80%" height="20"'></canvas>
		            </div>
		        </div>
			</div>
			<div class="col-5">
				<!-- Bootstrap Card 3 -->
		        <div class="card" style="width: 440px; height: 420px; margin-left: 90px; margin-bottom: 40px;">
					<div class="card-header" style='background-color:${sessionScope.homeColor.mainColor_code}; height: 50px;'>
                        <h5 class="card-title">이 달의 회원 감정 비율</h5>
                    </div>
		            <div class="card-body3 ms-5" style="width: 80%; height: 30;">
		                <!-- Add card content here -->
						<canvas id="SentiChart" width="80%" height="20"></canvas>
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
				    <div class="card-body1" style='background-color:${sessionScope.homeColor.mainColor_code};'>
				    	<br>
				    	<h5 class="card-word" style="text-align: center; font-size: 2.0em;">
				    		<img src="/project_H/img/crown.gif" width="30" height="30"/> 회원 랭킹 <img src="/project_H/img/crown.gif" width="30" height="30"/> <br>공감수 TOP 10</h5>
				    	<br>
			    	</div>
					    <div class="card-footer" style="font-size: 1.3em;">
					    	<table class="table table-striped table-bordered table-hover" style="background-color: rgba(255, 255, 255, 0.7); border: 0;">
				                <thead style="background-color: rgba(255, 255, 255, 0.7); border: 0;">
				                    <tr>
				                        <th width="20%">  </th>
				                        <th width="45%">닉네임</th>
				                        <th width="35%">공감수</th>
				                    </tr>
				                </thead>
				                <tbody style="background-color: rgba(255, 255, 255, 0.7); border: 0;">
				                    <c:forEach var="item" items="${userColor}" varStatus="loopStatus">
				                        <tr>
				                        	<c:choose>
					                        	<c:when test="${loopStatus.index eq 0}">
					                        		<td><img src="${pageContext.request.contextPath}/img/gold.png"
					                        		width="30" height="30"/></td>
					                        	</c:when>
					                        	<c:when test="${loopStatus.index eq 1}">
					                        		<td><img src="${pageContext.request.contextPath}/img/silver.png"
					                        		width="30" height="30"/></td>
					                        	</c:when>
					                        	<c:when test="${loopStatus.index eq 2}">
					                        		<td><img src="${pageContext.request.contextPath}/img/bronze.png"
					                        		width="30" height="30"/></td>
					                        	</c:when>
					                        	<c:otherwise>
					                            	<td style="font-size: 15px;">${loopStatus.index+1} 등</td>
					                        	</c:otherwise>
				                            </c:choose>
					                            <td style="font-size: 15px;">${item.nickname}</td>
				                            	<td style="font-size: 17px;">${item.hitCount}</td>
				                        </tr>
				                    </c:forEach>
				                </tbody>
				            </table>
			    		</div>
			        </div>
		    </div>
		</div>
	</div>
	<script src="/project_H/js/sentiCat.js"></script>
	<script src="/project_H/js/selecCol.js"></script>
	<script src="/project_H/js/uhit.js"></script>
	<script>
		let sentiCatVar = ${sentiCatJson};
		getSentiCatProc(sentiCatVar);
		let selecColVar = ${selcColorJson};
		selecColProc(selecColVar);
		let hitVar = ${hitJson};
		getHitChart(hitVar);
	</script>
	
	
</body>
</html>