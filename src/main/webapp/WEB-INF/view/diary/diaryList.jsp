<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>감정일기 일기장</title>
  <!-- 부트스트랩 CDN 추가 -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <style>
    /* 추가적인 스타일링을 위한 CSS */
    .diary-entry {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

<div class="container mt-5">
  <h1 class="mb-4">나의 일기장</h1>

  <!-- 일기 항목 -->
  <div class="diary-entry">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">2023년 12월 5일</h5>
        <h6 class="card-subtitle mb-2 text-muted">기쁨</h6>
        <p class="card-text">오늘은 정말 행복한 하루였어요! 어제와는 다르게 모든 일이 순조롭게 진행되어 기분이 좋았습니다.</p>
      </div>
    </div>
  </div>

  <div class="diary-entry">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">2023년 12월 4일</h5>
        <h6 class="card-subtitle mb-2 text-muted">슬픔</h6>
        <p class="card-text">조금 우울한 기분이었지만 끝까지 버텨냈어요. 내일은 더 나은 날이 될 것 같아요.</p>
      </div>
    </div>
  </div>

  <!-- 추가적인 일기 항목들을 필요에 따라 반복해서 추가 -->

</div>

<!-- 부트스트랩 JS 및 Popper.js, jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>