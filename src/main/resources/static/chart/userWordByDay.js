function getWordByDay(selectWord) {
		
		var hlabelList = new Array();
		var hvalueList = new Array();

		for (let i = 0; i < selectWord.length; i++) {
			let h = selectWord[i];
			hlabelList.push(h.word);
			hvalueList.push(h.count);
		}

		console.log(hlabelList);
		console.log(hvalueList);
		const hdata = {
			labels: hlabelList.slice(0, 3),
			datasets: [{
				axis: 'y',
				label: '많이 쓴 단어 Top 3',
				data: hvalueList.slice(0, 3),
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
			document.getElementById('myWordChart').getContext('2d'),
			hconfig
		);
}