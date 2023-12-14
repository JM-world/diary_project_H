<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
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
</head>
<body>
    
    <div id="content">
    <!-- Your actual content goes here -->
    <nav class="navbar navbar-expand-sm bg-light navbar-light">
      <div class="container-fluid">
        <div class="text-center" style="padding-left: 20px;">
            <div>
            	<h4 style="font-weight: bold;">
            		<a href="/project_H/home">" 오늘의 기분, 오늘의 컬러 "</a>
            	</h4>
           	</div>
        </div>
        <ul class="navbar-nav ms-auto">
          <li class="nav-item me-3">
            <a href="/project_H/diary/color" class="nav-link btn btn-outline-secondary" title="일기 쓰기"
            	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
              <i class="fas fa-edit"></i>
            </a>
          </li>
          <li class="nav-item me-3">
            <a href="/project_H/calendar" class="nav-link btn btn-outline-secondary" title="캘린더 보기"
            	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
              <i class="fas fa-calendar"></i>
            </a>
          </li>
          <li class="nav-item me-3">
            <a href="#" class="nav-link btn btn-outline-secondary" title="내가 쓴 일기"
            	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
              <i class="fas fa-book"></i>
            </a>
          </li>
          <li class="nav-item me-3">
            <a href="/project_H/board/list/1" class="nav-link btn btn-outline-secondary" title="게시판 이동"
            	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
              <i class="far fa-comments"></i>
            </a>
          <li class="nav-item me-3">
            <c:if test="${not empty sessUid}">
              <button id="writeDiaryButton" class="nav-link btn btn-outline-secondary" title="로그아웃"
              	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
                <i class="fas fa-sign-out-alt"></i>
              </button>
            </c:if>
            <c:if test="${empty sessUid}">
              <button id="writeDiaryButton" class="nav-link btn btn-outline-secondary" title="로그인"
              	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
                <i class="fas fa-sign-in-alt"></i>
              </button>
            </c:if>
          </li>
        </ul>
      </div>
    </nav>
	
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body text-center">
            <h6>로그아웃할까요?</h6>
          </div>
          <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger">로그아웃</button>
          </div>
        </div>
      </div>
    </div>
    
  </div>
</body>
</html>
