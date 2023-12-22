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
    <%@ include file="../common/head.jsp" %>

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
            width: 70%;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.8);
            z-index: 1;
            text-align: right;
		    margin-top: 0; /* 불필요한 상단 마진 제거 */
		    padding-top: 0; /* 불필요한 상단 패딩 제거 */
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
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'customButton2,customButton1'
                },
                views: {
                	customButton2: {
                        buttonText: '월간 분석',
                    },
                    customButton1: {
                        buttonText: '일간 분석', 
                    }
                    
                },
                customButtons: {
                    customButton1: {
                        text: '일간 분석',
                        click: function() {
                        	var currentDate = new Date();
                        	var currentDate = new Date();
                        	var currentMonth = currentDate.getMonth() + 1; // 현재 월 가져오기
                        	//console.log(currentMonth); // 현재 월 출력
                            var currentString = currentDate.toString();
    					    var slicedText = currentString.slice(4, 15); // "Dec"를 포함한 문자열 추출
    					    var stringWithoutSpaces = slicedText.replace(/\s/g, '-');
    				        var parts = stringWithoutSpaces.split('-'); // '-'를 기준으로 문자열 분리
    				        var formattedDate = parts[2] + '-' + currentMonth + '-' + parts[1]; // 원하는 형식으로 재구성
                            //console.log(formattedDate);
                            openModal(formattedDate, calendar.words, calendar.jsonString, calendar.colorString);
                        }
                    },
                    customButton2: {
                        text: '월간 분석',
                        click: function() {
                        	var targetPageUrl = '${pageContext.request.contextPath}/calendar/monthResult'; // 이동할 페이지 URL을 여기에 넣어주세요
                            
                            // 페이지 이동
                            window.location.href = targetPageUrl;
                        }
                    }
                },
                
	            datesSet: function(info) {
	            	calendar.removeAllEvents();
	                var allDates = info.view.currentStart;
	                var endDate = info.view.currentEnd;
	                var allVisibleDates = [];
	
	                var currentDay = new Date(allDates);
	                while (currentDay <= endDate) {
	                      allVisibleDates.push(new Date(currentDay));
	                      currentDay.setDate(currentDay.getDate() + 1);
	                    }
	               		 calendar.allVisibleDates = allVisibleDates; // calendar 객체에 저장
	           			
	               		var jsonString = ${jsonString};
	                    var words = ${words};
	                    var colorString = ${colorString};
		        		var events = [];
		        		var uniqueDates = {}; // 중복을 확인하기 위한 객체
		        		var colorDates = {}; // 이벤트 객체
		        		calendar.words = words;
		        		calendar.jsonString = jsonString;
		        		calendar.colorString = colorString;
		        		
		        		for (var i = 0; i < jsonString.length; i++) {
		        		    var obj = jsonString[i];
		        		    // 값이 없을 경우 이벤트 추가를 건너뛰도록 확인
		        		    if (obj['감정'] && obj['날짜']) {
		        		        // 중복된 '날짜' 값을 확인하여 가장 마지막 값으로 갱신
		        		        uniqueDates[obj['날짜']] = obj['감정'];
		        		    }
		        		}
		        		
		        		//console.log(uniqueDates)
		        		
		        		// uniqueDates 객체에 저장된 마지막 '날짜' 값을 events 배열에 추가
		        		for (var date in uniqueDates) {
		        			if (uniqueDates[date] === '긍정'){
		        				title = '긍정';
		        			} else if (uniqueDates[date] === '부정'){
		        				title = '부정';
		        			} else {
		        				title = '중립';
		        			}
		        		    events.push({
		        		        start: date,
		        		        title: title,
		        		        // 기타 이벤트 속성들...
		        		    });
		        		}
		        		
		        		for (var i = 0; i < colorString.length; i++) {
		        		    var obj2 = colorString[i];
		        		 	// 값이 없을 경우 이벤트 추가를 건너뛰도록 확인
		        		    colorDates[obj2['modtime']] = obj2['maincolor'];   
		        		}        
		        		
								        		
		        		events.sort(function(a, b) {
		        		    return new Date(a.start) - new Date(b.start);
		        		});
		        		
		        		var eventsData = {};
		        		events.forEach(event => {
		        			var date = event['start'];
		        			
		        			// 해당 날짜의 키가 이미 존재하는지 확인하고, 없다면 빈 배열로 초기화합니다.
		        		    if (!eventsData[date]) {
		        		        eventsData[date] = [];
		        		    }
		        			
		        		 	// 해당 날짜의 배열에 이벤트 정보를 추가합니다.
		        			eventsData[date].push({
		        		        title: event['title'] // 이벤트의 제목(title)을 해당 날짜의 배열에 추가합니다.
		        	        // 다른 이벤트 속성이 필요하다면 여기에 추가할 수 있습니다.
		        	    });
		        	});
		        		
		        		//console.log(eventsData)
		        		// eventsData 객체 순회
						for (var date in eventsData) {
						    if (eventsData.hasOwnProperty(date)) {
						        // 각 날짜에 대한 이벤트 정보 배열
						        var eventsForDate = eventsData[date];
						        //console.log(eventsForDate)
						        // 해당 날짜의 모든 이벤트 정보 배열을 순회하며 FullCalendar에 이벤트 추가
						        eventsForDate.forEach(eventInfo => {
						        	//console.log(eventInfo.date)
						            calendar.addEvent({
						                start: date, // 이벤트 시작 날짜
						                title: eventInfo.title,
						                isEvent: true, // 이벤트인 경우 true로 설정
						                backgroundColor : 'transparent',
						                borderColor : 'transparent',
						                extendedProps: {
						                    additionalInfo: eventInfo.title // 추가 정보를 여기에 설정하세요
						                    // 다른 추가 정보가 있다면 여기에 추가할 수 있습니다.
						                }
						                // 다른 이벤트 속성이 있다면 여기에 추가합니다.
						            });
						        });
						    }
						}
						//console.log(colorDates)
		        		// colorDates 객체를 기반으로 이벤트 생성 및 배경색 지정하여 풀캘린더에 추가
		        		for (var date in colorDates) {
		        		    if (colorDates.hasOwnProperty(date)) {
		        		    	console.log(colorDates[date]);
		        		        calendar.addEvent({
		        		            start: date, // 이벤트 시작 날짜
		        		            display: 'background', // 배경색으로 표시
		        		            backgroundColor: hexToRGBA(colorDates[date], 1) // colorDates 객체에서 가져온 배경색
		        		            // 다른 이벤트 속성이 필요하다면 여기에 추가할 수 있습니다.
		        		        });
		        		    }
		        		}
		            },
		            
		            dateClick: function (info) {
						
		                console.log('Clicked on: ' + info.dateStr);

		                
						
		                
		                openModal(info.dateStr, calendar.words, calendar.jsonString, calendar.colorString);
		            },
		            
		            eventContent: function(arg) {
		            	var eventEl = document.createElement('div');
		            	//배경색 제거
		            	eventEl.style.backgroundColor = 'transparent';
		            	
		            	// 추가적인 이벤트 속성을 확인하여 이미지를 추가하는 예시
		                if (arg.event.extendedProps && arg.event.extendedProps.additionalInfo === '긍정' && arg.event.extendedProps.isEvent) {
		                    var img = document.createElement('img');
		                    img.src = '/project_H/img/happy.png';
		                    img.alt = 'Happy';
		                    img.width = '20';
		                    img.height = '20';
		                    eventEl.appendChild(img);
		                } else if (arg.event.extendedProps && arg.event.extendedProps.additionalInfo === '부정' && arg.event.extendedProps.isEvent) {
		                    var img = document.createElement('img');
		                    img.src = '/project_H/img/sad.png';
		                    img.alt = 'Sad';
		                    img.width = '20';
		                    img.height = '20';
		                    eventEl.appendChild(img);
		                } else if (arg.event.extendedProps && arg.event.extendedProps.additionalInfo === '중립' && arg.event.extendedProps.isEvent) {
		                	var img = document.createElement('img');
		                    img.src = '/project_H/img/neutral.png';
		                    img.alt = 'Neutral';
		                    img.width = '20';
		                    img.height = '20';
		                    eventEl.appendChild(img);
		                }
		                
		               return { domNodes: [eventEl] };
		              }
		            
	                
	            });

	            calendar.render();
	            
	            var headerText = calendar.view.title; // FullCalendar의 기본 헤더 텍스트 가져오기
	            var dateElement = document.getElementsByClassName('fc-toolbar-title');
	            console.log(dateElement);
	            
	       
	            
	         // 16진수 색상 코드를 rgba 형식으로 변환하는 함수
	            function hexToRGBA(hex, alpha) {
	              var r = parseInt(hex.substring(1, 3), 16);
	              var g = parseInt(hex.substring(3, 5), 16);
	              var b = parseInt(hex.substring(5, 7), 16);

	              return 'rgba(' + r + ', ' + g + ', ' + b + ', ' + alpha + ')';
	            }

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
     
        
 

		function openModal(date, words, sentiments, colors) {
			const today = new Date();
			const currentDate = today.toISOString().split('T')[0]; // YYYY-MM-DD 형식의 현재 날짜

			const dateParts = date.split('-'); // date를 년, 월, 일로 분리
			const currentParts = currentDate.split('-'); // currentDate를 년, 월, 일로 분리

			const dateObj = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]); // date의 년, 월, 일로 Date 객체 생성
			const currentObj = new Date(currentParts[0], currentParts[1] - 1, currentParts[2]); // currentDate의 년, 월, 일로 Date 객체 생성
			
			let foundcolor = '';
			colors.forEach(color => {
				if (color['modtime'] === date) {
					foundcolor = color['maincolor_name']
				}
			})
			let foundWord = '';
			words.forEach(word => {
			    if (word['날짜'] === date) {
			    	foundWord = word['단어'];
			    }
			});
			let foundSentiment = '';
			sentiments.forEach(sentiment => {
				if (sentiment['날짜'] === date) {
					foundSentiment = sentiment['감정']
				}
			})
			$('#myModal').modal('show');
        	$('#exampleModalLabel.modal-title').text(date);
        	
        	if (foundcolor !== ''){
       			$('#modalTitle').text('오늘의 컬러: ' + foundcolor);
        	} else {
        		$('#modalTitle').text('');
        	}
       		if (foundWord !== ''){
	        	$('#modalContent').text('오늘 가장 많이 쓴 단어: ' + foundWord);
        	} else {
        		$('#modalContent').text('');
        	}
       		if (foundSentiment !== ''){
       			// 오늘의 기분이 있는 경우
	        	$('#modalContent2').text('오늘의 기분: ' + foundSentiment);
        	} else if (dateObj.getTime() < currentObj.getTime()){
        		// 오늘의 기분이 없고, date가 현재 날짜보다 이전인 경우
        		$('#modalContent2').text('일기를 작성하지 않았어요!');
		        $('#modalContent3').text('바쁜 하루를 보내셨군요!');
        	} else if (dateObj.getTime() === currentObj.getTime()){
        		// 오늘의 기분이 없고, date가 오늘인경우
        		$('#modalContent2').text('오늘은 일기를 작성하지 않았어요!');
		        $('#modalContent3').html('<a href="${pageContext.request.contextPath}/diary/color" onclick="openDiaryPage()">오늘 일기 쓰러 가기</a>');
        	} else {
        		$('#modalContent2').text('훗날의 일기는 미리작성할수 없어요!');
        	}
            
        }
		
	    
	    $('#button1').on('click', function () {
	        // 버튼1이 클릭되었을 때 수행할 동작을 추가하세요.
	        alert('버튼1이 클릭되었습니다!');
	    });

	    $('#button2').on('click', function () {
	        // 버튼2이 클릭되었을 때 수행할 동작을 추가하세요.
	        alert('버튼2이 클릭되었습니다!');
	    });
</script>

</head>
<body>
	<%@ include file="../common/top.jsp" %>
      <!-- FullCalendar를 감싸는 추가된 요소 -->
    <div id='calendar'>

	</div>

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