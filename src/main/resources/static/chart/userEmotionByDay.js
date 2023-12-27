function getUserEmodtionByDay(emotionScore) {
	const data = {
		labels: ['긍정', '중립', '부정'],
		datasets: [{
			label: '감정 비율',
			data: [emotionScore.POSITIVE_SCORE, emotionScore.NEUTRAL_SCORE, emotionScore.NEGATIVE_SCORE],
			backgroundColor: [
				'rgb(54, 162, 235)',
				'rgb(255, 205, 86)',
				'rgb(255, 99, 132)'
			],
			hoverOffset: 4
		}]
	};
	const config = {
		plugins: [ChartDataLabels], // chartjs-plugin-datalabels 불러오기
		type: 'doughnut',
		data: data,
		options: {
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						enabled: true
					},
					animation: {
						duration: 0,
					},
					datalabels: {
						formatter: function (value, context) {
							var idx = context.dataIndex;
							return value < 1 ? null :
							context.chart.data.labels[idx] + value + '%';
						},
						align: 'top',
					},

				},
			},
	};

	const sentiChart = new Chart(
		document.getElementById('myEmotionChart').getContext('2d'),
		config
	);
}