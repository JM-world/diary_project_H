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
	            border: 1px solid gray;
	            transition: border-color 0.3s;
	        }

        .color-button:hover,
	    .color-button.clicked {
	        border-color: white;
	    }
	
	    .color-button.clicked {
	        border-width: 3px; 
	        border-color: black; 
	    }

        button[type="submit"] {
            background-color: #c3adec;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
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
				    <div class="color-button" id="color-r" style="background-color: #c88f80;" onclick="selectColor1('r')"></div>
				    <div class="color-button" id="color-o" style="background-color: #d3a570;" onclick="selectColor1('o')"></div>
				    <div class="color-button" id="color-y" style="background-color: #dedab9;" onclick="selectColor1('y')"></div>
				    <div class="color-button" id="color-g" style="background-color: #c2d18c;" onclick="selectColor1('g')"></div>
				    <div class="color-button" id="color-bl" style="background-color: #c5cfcc;" onclick="selectColor1('bl')"></div>
				    <div class="color-button" id="color-pu" style="background-color: #bbb8cc;" onclick="selectColor1('pu')"></div>
				    <div class="color-button" id="color-pi" style="background-color: #d0adb4;" onclick="selectColor1('pi')"></div>
				    <div class="color-button" id="color-br" style="background-color: #d2c49b;" onclick="selectColor1('br')"></div>
				    <div class="color-button" id="color-a" style="background-color: #b1b6b2;" onclick="selectColor1('a')"></div>
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
		function selectColor1(color) {
	        // Reset border for all color buttons
	        var colorButtons = document.querySelectorAll('.color-button');
	        colorButtons.forEach(function(button) {
	            button.classList.remove('clicked'); // Remove the 'clicked' class from all buttons
	        });
	
	        // Set border for the selected color button
	        document.getElementById("selectedColor").value = "";
	        var selectedColorButton = document.getElementById('color-' + color);
	        
	        if (selectedColorButton) {
	            selectedColorButton.classList.add('clicked'); // Add the 'clicked' class to the selected button
	            document.getElementById("selectedColor").value = selectedColorButton.style.backgroundColor;
	        }
	            selectColor(color);
	            console.log(color);
		}
			
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