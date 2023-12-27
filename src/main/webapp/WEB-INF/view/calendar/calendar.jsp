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
    
    <!-- Chart.js CDN-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-datalabels/2.2.0/chartjs-plugin-datalabels.min.js" integrity="sha512-JPcRR8yFa8mmCsfrw4TNte1ZvF1e3+1SdGMslZvmrzDYxS69J7J49vkFL8u6u8PlPJK+H3voElBtUCzaXj+6ig==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <%@ include file="../common/head.jsp" %>

    <style>
    /* modal size, 위치 조정 */
        .modal-dialog.modal-80size {
            width: 100%;
            height: 80%;
            margin: 0;
            padding: 0;
        }

        .modal-content.modal-80size {
            height: auto;
            min-height: 80%;
        }

        .modal.modal-center {
            text-align: center;
        }

        @media screen and (min-width: 768px) {
        .modal.modal-center:before {
            display: inline-block;
            vertical-align: middle;
            content: " ";
            height: 100%;
        }
        }

        .modal-dialog.modal-center {
            display: inline-block;
            text-align: left;
            vertical-align: middle;
        }
        /*--------------------*/
    
    	.fc-daygrid-day-events {
        width: 32px !important; /* 원하는 가로 크기로 조정합니다 */
        height: 32px !important; /* 원하는 세로 크기로 조정합니다 */
        /* 다른 스타일도 필요하다면 추가하세요 */
    }
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
    <script src="/project_H/chart/userEmotionByDay.js"></script>
    <script src="/project_H/chart/userColorByDay.js"></script>
    <script src="/project_H/chart/userWordByDay.js"></script>
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
                viewDidMount: function (arg) {
                    if (arg.view.type === 'timeGridWeek') {
                    	if (${sessionScope.commitCo} >= 7) {
                        // 월간 분석 뷰가 로드되었을 때 수행할 동작
                        window.location.href = '${pageContext.request.contextPath}/calendar/monthResult'; // 이동할 페이지의 경로
                    	} else {
                    		alert("일기 제출을 7회 이상 해주세요.")
                    	}
                    } 
                },
                customButtons: {
                    customButton1: {
                        text: '일간 분석',
                        click: function() {
                        	var currentDate = new Date();
                        	console.log(currentDate.toISOString());
                            var currentString = currentDate.toISOString().substring(0,10);
                            console.log(currentString);
    				        var formData = new FormData();
    	                    var custId = '<%=(String)session.getAttribute("sessCustId")%>';
    	                    formData.append('custId', custId);
    	                    formData.append('date', currentString);
    	                    $.ajax({
    	                        type:'POST',
    	                        url: '/project_H/calendar',
    	                        data: formData,
    	                        processData: false,		// img 보낼시 false
    					        contentType: false,		// img 보낼시 false
    	                        success: function(result) {
    	                            // toJSONString으로 받으면 JSON.stringfy 사용
    	                            var obj = JSON.parse(result);
									if(obj.emotionScore != null){
	    	                            // 오늘의 감정
	    	                            $('#myEmotionChart').remove(); // graph 초기화
	    	                            $('#graph-container').append('<canvas id="myEmotionChart"><canvas>');  // canvas 재생성
	    	                            var emotionScore = obj.emotionScore;
	    	                            getUserEmodtionByDay(emotionScore);
	
	    	                            // 많이 쓴 단어 Top 3
	    	                            $('#myWordChart').remove();
	    	                            $('#graph-word').append('<canvas id="myWordChart" width="30%" height="35"><canvas>');
	    	                            var selectWord = obj.userContent;
	    	                            getWordByDay(selectWord);
	
	    	                            // 사용자들이 선택한 색상
	    	                            $('#myColorChart').remove();
	    	                            $('#graph-color').append('<canvas id="myColorChart"><canvas>');
	    	                            var selectColor = obj.usersDayColor;
	    	                            getColorByDay(selectColor);
	    	                            
	    	                            openModal(currentString, calendar.allVisibleDates, obj.mainColor);
									} else {
										alert("오늘 일기를 써주세요!!");
									}
    	                        }
    	                    });
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
	                    var formData = new FormData();
	                    var custId = '<%=(String)session.getAttribute("sessCustId")%>';
	                    formData.append('custId', custId);
	                    var date = info.dateStr;
	                    formData.append('date', date);
	                    $.ajax({
	                        type:'POST',
	                        url: '/project_H/calendar',
	                        data: formData,
	                        processData: false,		// img 보낼시 false
					        contentType: false,		// img 보낼시 false
	                        success: function(result) {
	                            // toJSONString으로 받으면 JSON.stringfy 사용
	                            var obj = JSON.parse(result);
	                            if(obj.emotionScore != null){
		                            // 오늘의 감정
		                            $('#myEmotionChart').remove(); // graph 초기화
		                            $('#graph-container').append('<canvas id="myEmotionChart"><canvas>');  // canvas 재생성
		                            var emotionScore = obj.emotionScore;
		                            getUserEmodtionByDay(emotionScore);
	
		                            // 많이 쓴 단어 Top 3
		                            $('#myWordChart').remove();
		                            $('#graph-word').append('<canvas id="myWordChart" width="30%" height="35"><canvas>');
		                            var selectWord = obj.userContent;
		                            getWordByDay(selectWord);
	
		                            // 사용자들이 선택한 색상
		                            $('#myColorChart').remove();
		                            $('#graph-color').append('<canvas id="myColorChart"><canvas>');
		                            var selectColor = obj.usersDayColor;
		                            getColorByDay(selectColor);
		                            
		                            openModal(info.dateStr, calendar.allVisibleDates, obj.mainColor);
	                            } else {
	                            	alert("작성하신 일기가 없습니다.!!")
	                            }
	                        }
	                    });
		            },
		            
		            eventContent: function(arg) {
		            	var parentEl = document.querySelector('.fc-daygrid-day-frame.fc-scrollgrid-sync-inner'); // 부모 요소 찾기
		            	
		            	if (parentEl) {
			            	// 이벤트 요소 생성
			                var eventEl = document.createElement('div');
			                eventEl.style.backgroundColor = 'transparent';
			                eventEl.style.position = 'absolute'; // 부모 요소를 기준으로 위치 조정
		                
			                var img = document.createElement('img');
			                img.width = '40';
			                img.height = '40';

			                if (arg.event.extendedProps && arg.event.extendedProps.isEvent) {
			                    var additionalInfo = arg.event.extendedProps.additionalInfo;
			                    
			                    switch (additionalInfo) {
			                        case '긍정':
			                            img.src = '/project_H/img/happy.png';
			                            img.alt = 'Happy';
			                            break;
			                        case '부정':
			                            img.src = '/project_H/img/sad.png';
			                            img.alt = 'Sad';
			                            break;
			                        case '중립':
			                            img.src = '/project_H/img/neutral.png';
			                            img.alt = 'Neutral';
			                            break;
			                        default:
			                            break;
			                    }

		                    	eventEl.appendChild(img);
		                    
		                    	// parentEl을 기준으로 위치 설정
		                        var parentRect = parentEl.getBoundingClientRect();
		                        var leftPercentage = 33; // 예시로 왼쪽으로 10% 이동

		                        var parentWidth = parentRect.width;
		                        var leftPosition = (parentWidth * leftPercentage) / 100;

		                        eventEl.style.left = leftPosition + 'px'; // 왼쪽 위치 설정
		                }

		                return { domNodes: [eventEl] };
		              }
		            
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

        });
        
        // <종문 추가> 일기 쓰기 중복 확인
		function checkDuplication() {
        	
        }
     
        
 

		function openModal(date, allVisibleDates, mainColor) {
            var day = new Date(date).getDate();
            var colorCode = mainColor.MAINCOLOR_CODE1;
            var colorName = mainColor.MAINCOLOR_NAME;
            $('#myModal').modal('show');
            $('.modal-title').text(date);
            $('#strong-header').remove();
            $('#color-card-header').append('<strong id="strong-header">오늘의 컬러 : '+ colorName + '</strong>');

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
            $('#color-body').remove();
            $('#todayColor').attr('style', 'background-color: white;height: 230px')
            .append('<div class="card" style="background-color: ' + colorCode + ';height: 200px" id="color-body"></div>');
        }
		
		

	    
	    $(document).ready(function() {
	        // 닫기 버튼을 눌렀을 때 모달 닫기
	        $('.modal-header .close').on('click', function() {
	            $('#myModal').modal('hide');
	        });

	        $('.modal-footer .btn-secondary').on('click', function() {
	            $('#myModal').modal('hide');
	        });
	        
	        // 모달이 표시되기 전에 실행될 이벤트
	        $('#myModal').on('show.bs.modal', function() {
	            console.log('모달이 열립니다!');
	            // 이곳에 모달이 열리기 전에 수행할 작업을 추가할 수 있습니다.
	        });

	        // 모달이 닫히기 전에 실행될 이벤트
	        $('#myModal').on('hide.bs.modal', function() {
	            console.log('모달이 닫힙니다!');
	            // 이곳에 모달이 닫히기 전에 수행할 작업을 추가할 수 있습니다.
	        });
	        
	    });
</script>

</head>
<body>
	<%@ include file="../common/top.jsp" %>
      <!-- FullCalendar를 감싸는 추가된 요소 -->
    <div id='calendar'>

	</div>

    <!-- Bootstrap Modal 예제 -->
 <div class="modal modal-center fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-80size modal-center" role="document">
        <div class="modal-content modal-80size">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xl-6 col-md-6">
                        <div class="card bg-primary text-black mb-4">
                            <div class="card-header" id="color-card-header"></div>
                            <div class="card-body" id="todayColor" style=> <!-- 오늘의 컬러 -->
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-end"></div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-md-6">
                        <div class="card bg-warning text-black mb-4">
                            <div class="card-header"><strong>오늘의 감정</strong></div>
                            <div class="card-body" style="background-color: white; height: 230px;" id="graph-container"></div>
                            <div class="card-footer d-flex align-items-center justify-content-end"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-6 col-md-6">
                        <div class="card bg-success text-black mb-4">
                            <div class="card-header"><strong>많이쓴 단어</strong></div>
                            <div class="card-body" style="background-color: white; height: 230px;" id="graph-word"></div>
                            <div class="card-footer d-flex align-items-center justify-content-end"></div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-md-6">
                        <div class="card bg-info text-black mb-4">
                            <div class="card-header"><strong>사용자들이 선택한 색상</strong></div>
                            <div class="card-body" style="background-color: white; height: 230px;" id="graph-color"></div>
                            <div class="card-footer d-flex align-items-center justify-content-end"></div>
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</div>



</body>
</html>