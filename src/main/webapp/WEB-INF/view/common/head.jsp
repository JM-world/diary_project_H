<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&family=Noto+Sans+KR&family=Silkscreen&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/fdb840a8cc.js" crossorigin="anonymous"></script>

    <style>
        body {
            position: relative;
            background-image: url('/project_H/img/pa.jpg');
            background-size: cover;
            background-position: center center;
            background-repeat: no-repeat;
            height: 200vh;
            margin: 0;
            padding: 0;
            z-index: -1;
        }

        .tooltip-light-pink .tooltip-inner {
            background-color: #FFD9EB;
            color: #000;
        }

        .tooltip-light-pink .tooltip-arrow {
            border-bottom-color: #FFD9EB;
        }

        .nav-link.btn:hover {
            background-color: transparent !important;
        }

        #content h4 a {
            text-decoration: none;
        }

        #content h4 a:hover {
            text-decoration: none;
        }
    </style>
</head>
<body>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // data-bs-toggle="tooltip" 속성을 가진 모든 엘리먼트에 대한 툴팁 초기화
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // 버튼 엘리먼트에 대한 툴팁 초기화
        var buttonTooltipTriggerList = [].slice.call(document.querySelectorAll('button[data-bs-toggle="tooltip"]'));
        var buttonTooltipList = buttonTooltipTriggerList.map(function (buttonTooltipTriggerEl) {
            var tooltip = new bootstrap.Tooltip(buttonTooltipTriggerEl);

            // 마우스가 버튼을 벗어날 때 툴팁을 숨기도록 이벤트 리스너 추가
            buttonTooltipTriggerEl.addEventListener('mouseleave', function () {
                tooltip.hide();
            });

            return tooltip;
        });

        // Write a Diary 버튼 클릭 시 모달 열기
        var writeDiaryButton = document.getElementById('writeDiaryButton');
        var logoutModal = new bootstrap.Modal(document.getElementById('logoutModal'));

        writeDiaryButton.addEventListener('click', function () {
            logoutModal.show();
        });

    });
</script>

</body>
</html>
