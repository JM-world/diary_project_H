<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
        <title>Document</title>
    </head>

    <body>
        <div class="row">
            <div class="col-xl-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-chart-area me-1"></i>
                        부정 긍정 분류
                    </div>
                    <div class="card-body"><canvas id="SentiChart" width="100%" height="40"></canvas></div>
                </div>
            </div>
            <div class="col-xl-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-chart-bar me-1"></i>
                        선택한 메인 색
                    </div>
                    <div class="card-body"><canvas id="ColorChart" width="100%" height="40"></canvas></div>
                </div>
            </div>
            <div class="col-xl-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-chart-bar me-1"></i>
                        회원랭킹 (공감수) TOP 10
                    </div>
                    <div class="card-body"><canvas id="HitCount" width="100%" height="100"></canvas></div>
                </div>
            </div>
        </div>
        <script>
            let jsonData = ${ sentiCatJson };
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

        </script>
        <script>
            const sentiChart = new Chart(
                document.getElementById('SentiChart').getContext('2d'),
                config
            );
        </script>
        <script>
            let sjsonData = ${ selcColorJson };
            let sjsonObject = JSON.stringify(sjsonData);
            let sjData = JSON.parse(sjsonObject);

            let slabelList = new Array();
            let sbackList = new Array();
            let svalueList = new Array();

            for (let i = 0; i < sjData.length; i++) {
                let s = sjData[i];
                slabelList.push(s.colorName);
                sbackList.push(s.colorCode);
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
        </script>
        <script>
            const colorChart = new Chart(
                document.getElementById('ColorChart').getContext('2d'),
                cconfig
            );
        </script>
        <script>
            let hjsonData = ${hitJson};
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

        </script>
        <script>
            const HitCount = new Chart(
                document.getElementById('HitCount').getContext('2d'),
                hconfig
            );
        </script>
    </body>

    </html>