<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Color Selection Page</title>
    <style>
        body {
            background-image: url('/project_H/img/pa.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
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

    <h2>기분에 따른 색깔을 골라 보세요 !</h2>

    <form action="processColor.jsp" method="post">
        <label for="color">색깔 선택하기:</label>

        <div>
            <div class="color-button" style="background-color: #c88f80;" onclick="selectColor('빨간색')"></div>
            <div class="color-button" style="background-color: #d3a570;" onclick="selectColor('주황색')"></div>
            <div class="color-button" style="background-color: #dedab9;" onclick="selectColor('노란색')"></div>
            <div class="color-button" style="background-color: #c2d18c;" onclick="selectColor('초록색')"></div>
            <div class="color-button" style="background-color: #c5cfcc;" onclick="selectColor('파란색')"></div>
            <div class="color-button" style="background-color: #bbb8cc;" onclick="selectColor('보라색')"></div>
            <div class="color-button" style="background-color: #d0adb4;" onclick="selectColor('분홍색')"></div>
            <div class="color-button" style="background-color: #d2c49b;" onclick="selectColor('갈색')"></div>
            <div class="color-button" style="background-color: #b1b6b2;" onclick="selectColor('무채색')"></div>
        </div>

        <br><br>

        <input type="hidden" name="color" id="selectedColor" value="">

        <input type="submit" value="Submit">
    </form>

    <script>
        function selectColor(color) {
            document.getElementById("selectedColor").value = color;
        }
    </script>

</body>
</html>
