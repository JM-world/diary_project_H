
function userAreaProc(jsonData) {

  Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
  Chart.defaults.global.defaultFontColor = '#292b2c';

  let jsonObject = JSON.stringify(jsonData);
  let jData = JSON.parse(jsonObject);
          
  let labelList = new Array();
  let valueList = new Array();
  
  for(let i = 0; i<jData.length; i++) {
      let d = jData[i];
      labelList.push(d.month + "월");
      valueList.push(d.numberOfPerson);
  }
  let ctx1 = document.getElementById("myAreaChart");
  let myLineChart = new Chart(ctx1, {
    type: 'line',
    data: {
      labels: labelList,
      datasets: [{
        label: "월별 가입 회원수",
        lineTension: 0.3,
        backgroundColor: "rgba(2,117,216,0.2)",
        borderColor: "rgba(2,117,216,1)",
        pointRadius: 5,
        pointBackgroundColor: "rgba(2,117,216,1)",
        pointBorderColor: "rgba(255,255,255,0.8)",
        pointHoverRadius: 5,
        pointHoverBackgroundColor: "rgba(2,117,216,1)",
        pointHitRadius: 50,
        pointBorderWidth: 2,
        data: valueList,
      }],
    },
    options: {
      scales: {
        xAxes: [{
          time: {
            unit: '월별 가입 회원수'
          },
          gridLines: {
            display: false
          },
          ticks: {
            maxTicksLimit: 100
          }
        }],
        yAxes: [{
          ticks: {
            min: 0,
            max: 100,
            maxTicksLimit: 10
          },
          gridLines: {
            color: "rgba(0, 0, 0, .125)",
          }
        }],
      },
      legend: {
        display: false
      }
    }
  });

}