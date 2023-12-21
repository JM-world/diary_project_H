<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Color Selection Page</title>
	<%@ include file="../common/head.jsp"%>
	<style>
	.color-button {
		display: inline-block;
		width: 50px;
		height: 50px;
		margin: 5px;
		cursor: pointer;
		border: 1px solid #000;
		transition: border-color 0.3s;
	}
	
	.color-button:hover {
	    border-color: white; 
	  }
	
	button[type="submit"] {
		background-color: #c3adec; /* 배경색 설정 */
		color: white; /* 텍스트 색상 설정 */
		padding: 10px 20px; /* 내부 여백 설정 */
		font-size: 16px; /* 폰트 크기 설정 */
		border-radius: 5px; /* 둥근 테두리 설정 */
		border: none; /* 테두리 없애기 */
		cursor: pointer;
	}


	</style>
</head>
<body>
	<%@ include file="../common/top.jsp"%>
	<div class="container mt-3" style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
	  <h2 style="text-align: center; margin-top: 200px;"></h2>
	  <div class="card" style="text-align: center; width: 700px; margin-left:auto; margin-right:auto;">
	  	<form action="/project_H/diary/color" method="post">
		    <div class="card-header" style="background-color:#ddc0dc;">
		    	<h2 style="text-align: center;"> 마음에 드는 색을 선택하세요! </h2>
		    </div>
		    <div class="card-body" style="height:150px; background-color:#dae9f0;" >
		    	<div>
		    		신중히 선택하세요! 한 번 선택하면 오늘은 변경할 수 없어요 :)
		    	</div> <br>
				<div>
					<div class="color-button" style="background-color: #c88f80;"
						onclick="selectColor('r')"></div>
					<div class="color-button" style="background-color: #d3a570;"
						onclick="selectColor('o')"></div>
					<div class="color-button" style="background-color: #dedab9;"
						onclick="selectColor('y')"></div>
					<div class="color-button" style="background-color: #c2d18c;"
						onclick="selectColor('g')"></div>
					<div class="color-button" style="background-color: #c5cfcc;"
						onclick="selectColor('bl')"></div>
					<div class="color-button" style="background-color: #bbb8cc;"
						onclick="selectColor('pu')"></div>
					<div class="color-button" style="background-color: #d0adb4;"
						onclick="selectColor('pi')"></div>
					<div class="color-button" style="background-color: #d2c49b;"
						onclick="selectColor('br')"></div>
					<div class="color-button" style="background-color: #b1b6b2;"
						onclick="selectColor('a')"></div>
				</div>
				<br> <br> <input type="hidden" name="color" id="selectedColor" value="">
			</div> 
		    <div class="card-footer" style="background-color:#c4b0f0;">
		    	<button type="submit" style="font-size: 1.5em; padding:3px">선택하기</button>
		    </div>
		</form>
	  </div>
	</div>


			

			

		<script>
			
			function selectColor(color) {
				if (color == "r")
					document.getElementById("selectedColor").value = "#c88f80";
				else if (color == "o")
					document.getElementById("selectedColor").value = "#d3a570";
				else if (color == "y")
					document.getElementById("selectedColor").value = "#dedab9";
				else if (color == "g")
					document.getElementById("selectedColor").value = "#c2d18c";
				else if (color == "bl")
					document.getElementById("selectedColor").value = "#c5cfcc";
				else if (color == "pu")
					document.getElementById("selectedColor").value = "#bbb8cc";
				else if (color == "pi")
					document.getElementById("selectedColor").value = "#d0adb4";
				else if (color == "br")
					document.getElementById("selectedColor").value = "#d2c49b";
				else if (color == "a")
					document.getElementById("selectedColor").value = "#b1b6b2";

			}
			
		</script>
</body>
</html>