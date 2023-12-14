<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Color Selection Page</title>
    <style>
        body {
        	position: relative;
            background-image: url('/project_H/img/pa.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            z-index: -1; 
        } 
        

        .color-button {
            display: inline-block;
            width: 50px;
            height: 50px;
            margin: 5px;
            cursor: pointer;
            border: 1px solid #000;
        }
    </style>
</head>
<body>
	<%@ include file="../common/top.jsp" %>
    <h2>기분에 따른 색깔을 골라 보세요 !</h2>

    <form action="/project_H/diary/color" method="post">
        <label for="color">색깔 선택하기:</label>

        <div>
            <div class="color-button" style="background-color: #c88f80;" onclick="selectColor('r')"></div>
            <div class="color-button" style="background-color: #d3a570;" onclick="selectColor('o')"></div>
            <div class="color-button" style="background-color: #dedab9;" onclick="selectColor('y')"></div>
            <div class="color-button" style="background-color: #c2d18c;" onclick="selectColor('g')"></div>
            <div class="color-button" style="background-color: #c5cfcc;" onclick="selectColor('bl')"></div>
            <div class="color-button" style="background-color: #bbb8cc;" onclick="selectColor('pu')"></div>
            <div class="color-button" style="background-color: #d0adb4;" onclick="selectColor('pi')"></div>
            <div class="color-button" style="background-color: #d2c49b;" onclick="selectColor('br')"></div>
            <div class="color-button" style="background-color: #b1b6b2;" onclick="selectColor('a')"></div>
        </div>

        <br><br>

        <input type="hidden" name="color" id="selectedColor" value="">

        <button type="submit">제출하기</button>
    </form>

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