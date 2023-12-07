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
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .color-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
        }

        .color-button {
            position: relative;
            width: 50px;
            height: 50px;
            margin: 5px;
            cursor: pointer;
            border: none;
            border-radius: 50%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            outline: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .color-checkbox {
            opacity: 1;
            cursor: pointer;
            position: absolute;
            top: 50%;
            left: 150%;
            transform: translate(-50%, -50%);
        }

        .checkmark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #fff;
            font-size: 12px;
            display: none;
        }

        .color-label {
            text-align: center;
        }

        h2 {
            margin-top: 160px;
            position: absolute;
            top: 0;
        }

        .submit-button,
        .btn-3d {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-button {
            background-color: #c88f80;
            color: #fff;
            border: none;
        }

        .btn-container {
            text-align: center;
            margin-top: 30px;
        }

        .btn-3d {
            background-color: cyan;
            color: #fff;
            border: none;
            display: inline-block;
        }

        .btn-3d:hover {
            background-color: #0a7f8e;
        }
    </style>
</head>
<body>

<h2>기분에 따라 색깔을 선택하세요</h2>

<form action="processColor.jsp" method="post">

    <div class="color-container">
        <!-- 빨간색 -->
        <div class="color-button" style="background-color: #c88f80;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="빨간색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">빨간색</div>

        <!-- 주황색 -->
        <div class="color-button" style="background-color: #d3a570;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="주황색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">주황색</div>

        <!-- 노란색 -->
        <div class="color-button" style="background-color: #dedab9;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="노란색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">노란색</div>

        <!-- 초록색 -->
        <div class="color-button" style="background-color: #c2d18c;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="초록색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">초록색</div>

        <!-- 파란색 -->
        <div class="color-button" style="background-color: #c5cfcc;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="파란색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">파란색</div>

        <!-- 보라색 -->
        <div class="color-button" style="background-color: #bbb8cc;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="보라색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">보라색</div>

        <!-- 분홍색 -->
        <div class="color-button" style="background-color: #d0adb4;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="분홍색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">분홍색</div>

        <!-- 갈색 -->
        <div class="color-button" style="background-color: #d2c49b;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="갈색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">갈색</div>

        <!-- 무채색 -->
        <div class="color-button" style="background-color: #b1b6b2;">
            <input type="checkbox" class="color-checkbox" name="selectedColors" value="무채색">
            <div class="checkmark">&#10003;</div>
        </div>
        <div class="color-label">무채색</div>
	</div>
  

    <br><br>

    <input type="hidden" name="color" id="selectedColor" value="">
    <div class="btn-container">
        <a href="#" class="btn-3d cyan">일기 쓰러 가기</a>
    </div>
</form>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const colorButtons = document.querySelectorAll('.color-button');

        colorButtons.forEach(function (button) {
            const checkbox = button.querySelector('.color-checkbox');
            const checkmark = button.querySelector('.checkmark');

            button.addEventListener('click', function () {
                checkbox.checked = !checkbox.checked;
                checkmark.style.display = checkbox.checked ? 'flex' : 'none';
                updateSelectedColor();
            });
        });
    });


</script>

</body>
</html>
