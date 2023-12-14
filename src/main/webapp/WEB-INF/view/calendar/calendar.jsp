<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FullCalendar in JSP</title>

    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

    <!-- FullCalendar CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.4.0/main.css" />
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.4.0/main.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        #background {
            background: url('/project_H/img/pa.jpg') center center/cover no-repeat fixed;
            height: 100vh;
            position: fixed;
            width: 100%;
            z-index: -1;
        }

        #calendar {
            border: 1px solid #ddd;
            padding: 10px;
            width: 70%;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.8);
            z-index: 1;
        }

        #sidebar {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: white;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 60px;
            color: black;
        }

        #sidebar a {
            padding: 8px 8px 8px 32px;
            text-decoration: none;
            font-size: 18px;
            color: #818181;
            display: block;
            transition: 0.3s;
        }

        #sidebar a:hover {
            color: #f1f1f1;
        }

        #sidebar .closebtn {
            position: absolute;
            top: 0;
            right: 25px;
            font-size: 36px;
            margin-left: 50px;
        }

        .navbar-nav {
            margin-left: auto;
        }

        .nav-item {
            margin-left: 15px;
        }
    </style>

    <script>
        // 내가 쓴 일기 페이지로 이동하는 함수
        function openDiaryPage() {
            alert("일기 페이지로 이동합니다.");
        }

        // 변경된 스크립트: 사이드바 토글
        $(document).ready(function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                dateClick: function (info) {
                    console.log('Clicked on: ' + info.dateStr);
                    openModal(info.dateStr);
                }
            });

            calendar.render();

            $('#sidebarCollapse').on('click', function () {
                if ($('#sidebar').width() === 0) {
                    $('#sidebar').width(250);
                } else {
                    $('#sidebar').width(0);
                }
            });

            $('#sidebar .closebtn').on('click', function () {
                $('#sidebar').width(0);
            });
        });
        
        // <종문 추가> 일기 쓰기 중복 확인
		function checkDuplication() {
        	
        }
     
        // 변경된 부분: 일기 쓰기 모달 열기
        function openModalForWritingDiary() {
            $('#myModal2').modal('show');
            $('#exampleModalLabel2').text("일기 쓰기");
            $('#modalTitle2').text('색깔을 골라보세요!');
            $('#modalContent6').html('<a href="${pageContext.request.contextPath}/diary/color" onclick="openDiaryPage()">일기 쓰기</a>');

            // 다른 모달 내용 초기화
            $('#modalTitle').empty();
            $('#modalContent').empty();
            $('#modalContent2').empty();
            $('#modalContent3').empty();
            $('#modalContent4').empty();
            $('#modalContent5').empty();
        }

        function openModal(date) {
            $('#myModal').modal('show');
            $('#exampleModalLabel').text(date);
            $('#modalTitle').text('오늘의 컬러: ');
            $('#modalContent').text('오늘 가장 많이 쓴 단어: ');
            $('#modalContent2').text('오늘의 기분: ');
            $('#modalContent3').html('<a href="${pageContext.request.contextPath}/home" onclick="openDiaryPage()">일간 분석 데이터</a>');
            $('#modalContent4').html('<a href="${pageContext.request.contextPath}/home" onclick="openDiaryPage()">월간 분석 데이터</a>');
            $('#modalContent5').html('<a href="${pageContext.request.contextPath}/home" onclick="openDiaryPage()">내가 쓴 일기 보러 가기</a>');
        }
    </script>
</head>
<body>
	<%@ include file="../common/top.jsp" %>
    <!-- 배경 이미지를 담당하는 추가된 요소 -->
    <div id="background"></div>

    <!-- Bootstrap Modal 예제 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="modalTitle"></p>
                    <p id="modalContent"></p>
                    <p id="modalContent2"></p>
                    <p id="modalContent3"></p>
                    <p id="modalContent4"></p>
                    <p id="modalContent5"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- FullCalendar를 감싸는 추가된 요소 -->
    <div id='calendar'></div>

    <!-- Bootstrap Modal 예제 -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="modalTitle2"></p>
                    <p id="modalContent6"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
