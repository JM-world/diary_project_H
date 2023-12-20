function getSentiCatProc(sentiCat) {
		let jsonData = sentiCat;
		let jsonObject = JSON.stringify(jsonData);
		let jData = JSON.parse(jsonObject);

		let labelList = new Array();
		let valueList = new Array();

		for (let i = 0; i < jData.length; i++) {
			let c = jData[i];
			labelList.push(c.sentiCat == 'positive' ? '긍정' : c.sentiCat == 'negative' ? '부정' : '중립');
			valueList.push(c.sentiCnt);
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
			type: 'doughnut',
			data: data,
		};

		const sentiChart = new Chart(
			document.getElementById('SentiChart').getContext('2d'),
			config
		);
}