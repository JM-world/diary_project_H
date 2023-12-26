function selecColProc (selectColVar) {
		let sjsonData = selectColVar;
		let sjsonObject = JSON.stringify(sjsonData);
		let sjData = JSON.parse(sjsonObject);

		let slabelList = new Array();
		let sbackList = new Array();
		let svalueList = new Array();

		for (let i = 0; i < sjData.length; i++) {
			let s = sjData[i];
			slabelList.push(s.colorName);
			sbackList.push(s.colorCode + "80");
			svalueList.push(s.selctCnt);
		}

		const cdata = {
			labels: slabelList,
			datasets: [{
				label: 'Main Color',
				data: svalueList,
				backgroundColor: sbackList
			}]
		};

		const cconfig = {
			type: 'polarArea',
			data: cdata,
		};

		const colorChart = new Chart(
			document.getElementById('ColorChart').getContext('2d'),
			cconfig
		);
}