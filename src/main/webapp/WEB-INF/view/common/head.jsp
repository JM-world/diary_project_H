<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&family=Silkscreen&display=swap" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<style>
    h1 {
        font-family: 'Silkscreen', sans-serif;
    }

    h4 {
        font-family: 'Hi Melody', sans-serif;
    }

    body {
        margin: 0;
        font-family: 'Arial', sans-serif;
        overflow: hidden;
    }

    a {
        text-decoration: none;
        color: black;
    }

    a:hover {
        color: red;
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
