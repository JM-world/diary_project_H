function getHitChart(hitVar) {
		let hjsonData = hitVar;
		let hjsonObject = JSON.stringify(hjsonData);
		let hjData = JSON.parse(hjsonObject);

		let hlabelList = new Array();
		let hvalueList = new Array();

		for (let i = 0; i < hjData.length; i++) {
			let h = hjData[i];
			hlabelList.push(h.chitId);
			hvalueList.push(h.shit);
		}

		console.log(hlabelList);
		console.log(hvalueList);
		const hdata = {
			labels: hlabelList,
			datasets: [{
				axis: 'y',
				label: '회원 공감 Top 10',
				data: hvalueList,
				fill: false,
				backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(255, 159, 64, 0.2)',
					'rgba(255, 205, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(153, 102, 255, 0.2)',
					'rgba(201, 203, 207, 0.2)',
					'rgba(255, 159, 64, 0.2)',
					'rgba(255, 205, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)'
				],
				borderColor: [
					'rgb(255, 99, 132)',
					'rgb(255, 159, 64)',
					'rgb(255, 205, 86)',
					'rgb(75, 192, 192)',
					'rgb(54, 162, 235)',
					'rgb(153, 102, 255)',
					'rgb(201, 203, 207)',
					'rgb(255, 159, 64)',
					'rgb(255, 205, 86)',
					'rgb(75, 192, 192)'
				],
				borderWidth: 1
			}]
		};
		const hconfig = {
			type: 'bar',
			data: hdata,
			options: {
				indexAxis: 'y',
			}
		};

		const HitCount = new Chart(
			document.getElementById('HitCount').getContext('2d'),
			hconfig
		);
}