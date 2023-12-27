function getColorByDay (selectColor) {

		var selectColor = selectColor;

		var slabelList = new Array();
		var sbackList = new Array();
		var svalueList = new Array();

		for (var i = 0; i < selectColor.length; i++) {
			var s = selectColor[i];
			slabelList.push(s.colorName.replace("색", ''));
			sbackList.push(s.colorCode + "80");
			svalueList.push(s.colorCount);
		}

		const cdata = {
			labels: slabelList.slice(0, 3),
			datasets: [{
				label: 'Main Color',
				data: svalueList.slice(0, 3),
				backgroundColor: sbackList.slice(0, 3)
			}]
		};

		const cconfig = {
			type: 'polarArea',
			data: cdata,
			 options: {
			    responsive: true,
			    scales: {
			      r: {
			        pointLabels: {
			          display: true,
			          centerPointLabels: true,
			          font: {
			            size: 15
			          }
			        }
			      }
			    },
			    plugins: {
			      legend: {
					display: false,
			        position: 'top',
			      },
			      /* animation: {
						duration: 10,
					},
			       title: {
			        display: true,
			        text: 'Chart.js Polar Area Chart With Centered Point Labels'
			      } */
			    }
  			},
		};

		const colorChart = new Chart(
			document.getElementById('myColorChart').getContext('2d'),
			cconfig
		);
}