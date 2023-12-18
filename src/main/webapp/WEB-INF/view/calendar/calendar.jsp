<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FullCalendar in JSP</title>

    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

 

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
    </style>

    <script>
        // 내가 쓴 일기 페이지로 이동하는 함수
        function openDiaryPage() {
            alert("일기 페이지로 이동합니다.");
        }

        $(document).ready(function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                datesSet: function (info) {
                    var allDates = info.view.currentStart;
                    var endDate = info.view.currentEnd;
                    var allVisibleDates = [];

                    var currentDay = new Date(allDates);
                    while (currentDay <= endDate) {
                        allVisibleDates.push(new Date(currentDay));
                        currentDay.setDate(currentDay.getDate() + 1);
                    }

                    calendar.allVisibleDates = allVisibleDates;
                },
                dateClick: function (info) {
                    console.log('Clicked on: ' + info.dateStr);
                    openModal(info.dateStr, calendar.allVisibleDates);
                }
            });

            calendar.render();
        });

        function openModal(date, allVisibleDates) {
            var day = new Date(date).getDate();

            $('#myModal').modal('show');
            $('#exampleModalLabel').text(date);

            var data = [];
            for (var i = 0; i < allVisibleDates.length; i++) {
                var currentString = allVisibleDates[i].toString();
                var slicedText = currentString.slice(0, 7);

                if (slicedText.includes("Dec")) {
                    currentString = currentString.replace("Dec", "12");
                    currentString = currentString.slice(4, 14);
                    var stringWithoutSpaces = currentString.replace(/\s/g, '-');
                    var parts = stringWithoutSpaces.split('-');
                    var formattedDate = parts[2] + '-' + parts[0] + '-' + parts[1];
                    data.push(formattedDate);
                } else if (slicedText.includes("Jan")) {
                    currentString = currentString.replace("Jan", "1");
                    currentString = currentString.slice(4, 14);
                    var stringWithoutSpaces = currentString.replace(/\s/g, '-');
                    var parts = stringWithoutSpaces.split('-');
                    var formattedDate = parts[2] + '-' + parts[0] + '-' + parts[1];
                    data.push(formattedDate);
                }
            }
            console.log(data[day - 1]);
            $('#modalTitle').text('오늘의 컬러: ' + data[day - 1]);
            $('#modalContent').text('오늘 가장 많이 쓴 단어: ');
            $('#modalContent2').text('오늘의 기분: ');
            $('#modalContent3').html('<a href="${pageContext.request.contextPath}/home" onclick="openDiaryPage()">일간 분석 데이터</a>');
            $('#modalContent4').html('<a href="${pageContext.request.contextPath}/home" onclick="openDiaryPage()">월간 분석 데이터</a>');
           
        }
    </script>
</head>
<body>
<%@ include file="../common/head.jsp" %>
<%@ include file="../common/top.jsp" %>

<!-- 배경 이미지를 담당하는 추가된 요소 -->
<div id="background"></div>

<!-- FullCalendar를 감싸는 추가된 요소 -->
<div id='calendar'></div>

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

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
