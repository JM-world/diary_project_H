function getSentiCatProc(sentiCat) {
		let jsonData = sentiCat;
		let jsonObject = JSON.stringify(jsonData);
		let jData = JSON.parse(jsonObject);

		let labelList = new Array();
		let valueList = new Array();

		var sum = 0;
		for (let i = 0; i < jData.length; i++) {
			let c = jData[i];
			labelList.push(c.sentiCat == 'positive' ? '긍정' : c.sentiCat == 'negative' ? '부정' : '중립');
			valueList.push(c.sentiCnt);
			sum += c.sentiCnt;
		}

		const data = {
			labels: labelList,
			datasets: [{
				label: '부정 긍정',
				data: valueList,
				backgroundColor: [
					'rgb(54, 162, 235)',
					'rgb(255, 99, 132)',
					'rgb(255, 205, 86)'
				],
				hoverOffset: 4
			}]
		};
		const config = {
			plugins: [ChartDataLabels],
			type: 'doughnut',
			data: data,
			options: {
				plugins: {
					legend: {
						display: true
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
							var value = (value / sum) * 100;
							return context.chart.data.labels[idx] + value.toFixed(1) + '%';
						},
						align: 'top',
						font: function (context) {
						  const width = context.chart.width
						  const size = Math.round(width / 25)
						
						  return {
						    size: size,
						    family: 'Pretendard',
						    weight: 'bold',
						  }
						},
					},

				},
			},
		};

		const sentiChart = new Chart(
			document.getElementById('SentiChart').getContext('2d'),
			config
		);
}