<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp"%>
<link
	href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>월간 분석</title>
<style>
body {
	font-family: 'Cute Font', sans-serif;
}

/* 초기화 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

li {
	list-style-type: none;
}

/* 보여줄 구간의 높이와 넓이 설정 */
#slideShow {
	width: 750px;
	height: 750px;
	position: relative;
	margin: 50px auto;
	margin-left: 400px;
	overflow: hidden;
	/*리스트 형식으로 이미지를 일렬로 
          정렬할 것이기 때문에, 500px 밖으로 튀어 나간 이미지들은
          hidden으로 숨겨줘야됨*/
}

.slides {
	position: absolute;
	left: 0;
	top: 0;
	width: 2500px; /* 슬라이드할 사진과 마진 총 넓이 */
	transition: left 0.5s ease-out;
	/*ease-out: 처음에는 느렸다가 점점 빨라짐*/
}

/* 첫 번째 슬라이드 가운데에 정렬하기위해
        첫번째 슬라이드만 margin-left조정 */
.slides li:first-child {
	margin-left: 40px;
}

/* 슬라이드들 옆으로 정렬 */
.slides li:not(:last-child) {
	float: left;
	margin-right: 80px;
}

.slides li {
	float: left;
}

.controller span {
	position: absolute;
	background-color: transparent;
	color: black;
	text-align: center;
	border-radius: 50%;
	padding: 10px 20px;
	top: 40%;
	font-size: 2.0em;
	cursor: pointer;
}

/* 이전, 다음 화살표에 마우스 커서가 올라가 있을때 */
.controller span:hover {
	background-color: rgba(128, 128, 128, 0.11);
}

.prev {
	left: 20px;
}

/* 이전 화살표에 마우스 커서가 올라가 있을때 
        이전 화살표가 살짝 왼쪽으로 이동하는 효과*/
.prev:hover {
	transform: translateX(-10px);
}

.next {
	right: 20px;
}

/* 다음 화살표에 마우스 커서가 올라가 있을때 
        이전 화살표가 살짝 오른쪽으로 이동하는 효과*/
.next:hover {
	transform: translateX(10px);
}

</style>
</head>
<body>
	<%@ include file="../common/top.jsp"%>
	<div style="display: flex;">
		<div class="card"
			style="margin-left: 50px; margin-top: 50px; height: 600px; width: 350px; background-image: url('/project_H/img/backColor.gif'); background-size: 100% 100%;">
			<div class="card-header"
				style="font-size: 25px; background-color: white;">${sessionScope.user.nickName}님의
				월간 분석 리포트</div>
			<div class="card-body">
				<ul class="alert" style="margin-top: -10px;">
					<li>
						<div class="alert alert-secondary p-2">
							<strong style="font-size: 1.3em; text-align: center;">일기
								제출 횟수!</strong><br>
							<p style="float: left; margin-top: 10px;">${sessionScope.commitCo}
								회</p>
							<p style="float: right; margin-top: 10px;">제출률:
								${sessionScope.commitPer} %</p>
							<div style="clear: both; margin-bottom: -15px;"></div>
						</div>
					</li>
					<li>
						<div class="alert alert-secondary p-2">
							<strong style="font-size: 1.3em;">일기 공유 횟수!</strong><br>
							<p style="margin-top: 10px; margin-bottom: 0px;">${sessionScope.shareCo}
								회</p>
						</div>
					</li>
					<li>
						<div class="alert alert-danger p-2">
							<strong style="font-size: 1.3em;">가장 공감수가 높은 글!</strong><br>
							<p style="float: left; margin-top: 10px; font-size: 1.1em;">
								<a href="/project_H/diary/view/${sessionScope.hitContent.ucid}"
									style="text-decoration: none;">${sessionScope.hitContent.hitContent}...
								</a>
							</p>
							<p style="float: right; margin-top: 10px;">< 공감수:
								${sessionScope.hitContent.hitCount} ></p>
							<div style="clear: both; margin-bottom: -15px;"></div>
						</div>
					</li>
					<li>
						<div class="alert alert-warning p-2">
							<strong style="font-size: 1.3em;">가장 긍점 점수가 높은 글!</strong><br>
							<p style="float: left; margin-top: 10px; font-size: 1.1em;">
								<a href="/project_H/diary/view/${sessionScope.poContent.ucid}"
									style="text-decoration: none;">${sessionScope.poContent.poContent}...
								</a>
							</p>
							<p style="float: right; margin-top: 10px;"><
								${sessionScope.poContent.positive_score} 점 ></p>
							<div style="clear: both; margin-bottom: -15px;"></div>
						</div>
					</li>
					<li>
						<div class="alert alert-warning p-2">
							<strong style="font-size: 1.3em;">가장 부정 점수가 높은 글!</strong><br>
							<p style="float: left; margin-top: 10px; font-size: 1.1em;">
								<a href="/project_H/diary/view/${sessionScope.neContent.ucid}"
									style="text-decoration: none;">${sessionScope.neContent.neContent}...
								</a>
							</p>
							<p style="float: right; margin-top: 10px;"><
								${sessionScope.neContent.negative_score} 점 ></p>
							<div style="clear: both; margin-bottom: -15px;"></div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="slideShow" style="margin-left: 80px;">
			<ul class="slides">

				<li>
					<div class="card" style="height: 600px; width: 600px;">
						<h2 class="chart-title">&nbsp;&nbsp;이번달 선택한 색깔</h2>
						<hr style="border-top: 2px solid #000000; width: 100%; margin: 10px 0;">
						<div class="card-body">
						<canvas class="myPieChartCanvas" width="80%" height="30"></canvas>
						</div>
					</div>
				</li>

				<li>
					<div class="card" style="height: 600px; width: 600px;">
						<h2 class="chart-title">&nbsp;&nbsp;이번달 감정 결과</h2>
						<hr style="border-top: 2px solid #000000; width: 100%; margin: 10px 0;">
						<div class="card-body">
						<canvas class="myDoughnutChartCanvas" width="80%" height="30"></canvas>
						</div>
					</div>
				</li>

				<li>
					<div class="card" style="height: 600px; width: 600px;">
						<h2 class="chart-title">&nbsp;&nbsp;이번달 많이 쓴 단어 Top 10</h2>
						<hr style="border-top: 2px solid #000000; width: 100%; margin: 10px 0;">
						<div class="card-body">
							<canvas id="wordByMonthChart" width="30%" height="25">
						</div>
					</div>
				</li>
			</ul>
			<p class="controller">

				<!-- &lang: 왼쪽 방향 화살표
                    &rang: 오른쪽 방향 화살표 -->
				<span class="prev">&lang;</span> <span class="next">&rang;</span>
			</p>
		</div>
	</div>
<script>


		const slides = document.querySelector('.slides'); //전체 슬라이드 컨테이너
		const slideImg = document.querySelectorAll('.slides li'); //모든 슬라이드들
		let currentIdx = 0; //현재 슬라이드 index
		const slideCount = slideImg.length; // 슬라이드 개수
		const prev = document.querySelector('.prev'); //이전 버튼
		const next = document.querySelector('.next'); //다음 버튼
		const slideWidth = 600; //한개의 슬라이드 넓이
		const slideMargin = 100; //슬라이드간의 margin 값

		//전체 슬라이드 컨테이너 넓이 설정
		slides.style.width = (slideWidth + slideMargin) * slideCount + 'px';

		function moveSlide(num) {
			slides.style.left = -num * 680 + 'px';
			currentIdx = num;
		}

		prev.addEventListener('click', function() {
			/*첫 번째 슬라이드로 표시 됐을때는 
			이전 버튼 눌러도 아무런 반응 없게 하기 위해 
			currentIdx !==0일때만 moveSlide 함수 불러옴 */

			if (currentIdx !== 0)
				moveSlide(currentIdx - 1);
		});

		next.addEventListener('click', function() {
			// Check if the current slide is the last slide
			if (currentIdx === slideCount - 1) {
				// If it is the last slide, move to the first slide
				moveSlide(0);
			} else {
				// If not the last slide, move to the next slide
				moveSlide(currentIdx + 1);
			}
		});
	
		const jsonData = ${sessionScope.chartData};
	    const mainColorNames = jsonData.mainColorNames;
	    const colorCounts = jsonData.colorCounts;
	    const mainColorCode1 = jsonData.colors;
	    
	    

	    const canvas = document.querySelector('.myPieChartCanvas'); // class로 변경
	    if (canvas) {
	        const ctx = canvas.getContext('2d');
	        const myPieChart = new Chart(ctx, {
	            type: 'pie',
	            data: {
	                labels: mainColorNames,
	                datasets: [{
	                    data: colorCounts,
	                    backgroundColor: mainColorCode1,
	                }]
	            },
	            options: {
	            	maintainAspectRatio: false,  // 필요한 경우 추가적인 차트 옵션
	            }
	        });

	        function updateChart() {
	            myPieChart.data.labels = mainColorNames;
	            myPieChart.data.datasets[0].data = colorCounts;
	            myPieChart.data.datasets[0].backgroundColor = mainColorCode1;
	            myPieChart.update();
	        }

	        updateChart();
	    } else {
	        console.error('Canvas element with class "myPieChartCanvas" not found.');
	    }
	    
	    // 두 번째 슬라이드 원형 차트
	    const sentimentData = ${sessionScope.sentimentChartData};
	    const sentiments = sentimentData.sentiments;

	    const canvas3 = document.querySelector('.myDoughnutChartCanvas'); // class로 변경
	    if (canvas3) {
	        const ctx3 = canvas3.getContext('2d');
	        const myDoughnutChart = new Chart(ctx3, {
	            type: 'doughnut',
	            data: {
	                labels: sentiments.map(data => data.sentiment),
	                datasets: [{
	                    data: sentiments.map(data => data.count),
	                    backgroundColor: getRandomColors(sentiments.length),
	                }]
	            },
	            options: {
	                maintainAspectRatio: false // 필요한 경우 추가적인 차트 옵션
	            }
	        });

	        function updateDoughnutChart() {
	            myDoughnutChart.data.labels = sentiments.map(data => data.sentiment);
	            myDoughnutChart.data.datasets[0].data = sentiments.map(data => data.count);
	            myDoughnutChart.data.datasets[0].backgroundColor = getRandomColors(sentiments.length);
	            myDoughnutChart.update();
	        }

	        updateDoughnutChart();
	    } else {
	        console.error('Canvas element with class "myDoughnutChartCanvas" not found.');
	    }

	    // 랜덤 색상 생성 함수
	    function getRandomColors(count) {
	        const colors = [];
	        for (let i = 0; i < count; i++) {
	            const randomColor = '#' + Math.floor(Math.random()*16777215).toString(16);
	            colors.push(randomColor);
	        }
	        return colors;
	    }
	    
	    
	    
</script>
 	<script src="/project_H/chart/userWordByMonth.js"></script>
	 <script>
	  	var wjsonData = ${wordsJson};
	  	var wjsonObject = JSON.stringify(wjsonData);
		var wjsonWord = JSON.parse(wjsonObject);
		getWordByMonth(wjsonWord);
	</script>
</body>
</html>
