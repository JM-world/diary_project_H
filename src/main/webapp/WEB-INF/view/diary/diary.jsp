<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>감정일기</title>
    <!-- 부트스트랩 CDN 추가 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <!-- Spectrum 라이브러리 CDN 추가 -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/spectrum/1.8.1/spectrum.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/spectrum/1.8.1/spectrum.min.js"></script>

    <!-- 부트스트랩 JS 및 Popper.js, jQuery CDN 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #007bff;
        }

        form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="date"],
        input[type="text"],
        textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        /* 아래 부분을 추가하여 textarea의 크기 조절 비활성화 및 고정 높이 설정 */
        textarea {
            resize: none; /* 크기 조절 비활성화 */
            height: 500px !important; /* 고정 높이 설정 */
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        #selectedColor {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
    </style>

    <!-- Spectrum 초기화 -->
    <script>
        jQuery(document).ready(function ($) {
            $("#emotion").spectrum({
                type: "color", // 동그라미 모양으로 색상 선택
                showPalette: true,
                showSelectionPalette: true,
                palette: [
                    ["#c88f80", "#d3a570", "#dedab9"],
                    ["#c2d18c", "#c5cfcc", "#d2c49b"],
                    ["#bbb8cc", "#d0adb4", "#b1b6b2"]
                ],
                change: function(color) {
                    showSelectedColor(color);
                }
            });
        });

        function showSelectedColor(color) {
            // 색상 이름 매핑 객체
            const colorNames = {
                "#c88f80": "빨간색",
                "#d3a570": "주황색",
                "#dedab9": "노란색",
                "#c2d18c": "초록색",
                "#c5cfcc": "파란색",
                "#d2c49b": "갈색",
                "#bbb8cc": "보라색",
                "#d0adb4": "분홍색",
                "#b1b6b2": "무채색"
            };

            const colorName = colorNames[color.toHexString()] || "알 수 없는 색상";
            $("#selectedColor").text("선택된 색상: " + colorName);
        }
    </script>
</head>
<body>

<div class="container mt-5">
    <h1 class="mb-4">새로운 일기 쓰기</h1>

    <!-- 날짜 선택 폼 -->
    <form action="diary/list" method="post">
        <div class="form-group">
            <label for="diaryDate">날짜 선택:</label>
            <input type="date" class="form-control" id="diaryDate" name="diaryDate" required>
        </div>

        <!-- 감정(색) 입력 폼 -->
        <div class="form-group">
            <label for="emotion">오늘의 색:</label>
            <input type="text" class="form-control" id="emotion" name="emotion" placeholder="색을 선택하세요">
            <!-- 선택된 색상을 보여줄 부분 -->
        	<div id="selectedColor"></div>
        </div>

        <div class="form-group">
            <label for="diary">일기 내용:</label>
            <textarea class="form-control" id="diary" rows="3" placeholder="오늘 있었던 일을 기록하세요"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">일기 작성</button>

     
    </form>
</div>

</body>
</html>
