
function loadChartWithData(lJsonData) {
    Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
    Chart.defaults.global.defaultFontColor = '#292b2c';
    let ljsonObject = JSON.stringify(lJsonData);
    let ljData = JSON.parse(ljsonObject);
            
    let llabelList = new Array();
    let lvalueList = new Array();
    
    for(let i = 0; i<ljData.length; i++) {
        let l = ljData[i];
        llabelList.push(l.lMonth + "월");
        lvalueList.push(l.lNumberOfPerson);
    }

    let ctx1 = document.getElementById("myBarChart");
    let myLineChart = new Chart(ctx1, {
    type: 'bar',
    data: {
        labels: llabelList,
        datasets: [{
        label: "월별 탈퇴 회원수",
        backgroundColor: "#FFFF00",
        borderColor: "#FFFF00",
        data: lvalueList,
        }],
    },
    options: {
        scales: {
        xAxes: [{
            time: {
            unit: '월'
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
            max: 50,
            maxTicksLimit: 10
            },
            gridLines: {
            display: true
            }
        }],
        },
        legend: {
        display: false
        }
    }
    });

}