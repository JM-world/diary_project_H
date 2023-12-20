<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String iconClass=""; %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
    <div style="background-color: rgb(101, 178, 255); padding: 40px; color: #fff; height: 220px">
        <div style="float: left;">
    		 <div class="weather_icon" style="font-size: 2em;"></div>
		</div><br>

        <div style="float: right; margin: -5px 0px 0px 60px; font-size: 11pt">
            <div class="temp_min"></div>
            <div class="temp_max"></div>
            <div class="humidity"></div>
            <div class="wind"></div>
            <div class="cloud"></div>
        </div>
        <div style="float: right; margin-top: -45px;">
            <div class="current_temp" style="font-size: 50pt"></div>
            <div class="weather_description" style="font-size: 20pt"></div>
            <div class="city" style="font-size: 13pt"></div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            var weatherIcon = {
                '01d': 'fas fa-sun',
                '02d': 'fas fa-cloud-sun',
                '03d': 'fas fa-cloud',
                '04d': 'fas fa-cloud-meatball',
                '09d': 'fas fa-cloud-sun-rain',
                '10d': 'fas fa-cloud-showers-heavy',
                '11d': 'fas fa-poo-storm',
                '13d': 'far fa-snowflake',
                '50d': 'fas fa-smog',
            	'01n': 'fas fa-sun',
                '02n': 'fas fa-cloud-sun',
                '03n': 'fas fa-cloud',
                '04n': 'fas fa-cloud-meatball',
                '09n': 'fas fa-cloud-sun-rain',
                '10n': 'fas fa-cloud-showers-heavy',
                '11n': 'fas fa-poo-storm',
                '13n': 'far fa-snowflake',
                '50n': 'fas fa-smog'
            	
            };

            // Model에서 날씨 정보 가져오기
            var description = '<%= request.getAttribute("description") %>';
            var iconCode = '<%= request.getAttribute("iconCode") %>'; // 추가된 부분
            var temperature = '<%= request.getAttribute("temperature") %>';
            var humidity = '<%= request.getAttribute("humidity") %>';
            var windSpeed = '<%= request.getAttribute("windSpeed") %>';
            var cloudiness = '<%= request.getAttribute("cloudiness") %>';
            var temp_min = '<%= request.getAttribute("temp_min") %>';
            var temp_max = '<%= request.getAttribute("temp_max") %>';
            var cityName = '<%= request.getAttribute("name") %>';
            var iconClass = weatherIcon[iconCode];
            

            // 날씨 정보를 HTML에 적용
        	$('.weather_icon').append('<i class="' + weatherIcon[iconCode] +' fa-5x" style="height : 150px; width : 150px;"></i>');
            $('.weather_description').prepend(description);
            $('.current_temp').prepend(temperature);
            $('.humidity').prepend('습도&nbsp;&nbsp;&nbsp;&nbsp;' + humidity + ' %');
            $('.wind').prepend('바람&nbsp;&nbsp;&nbsp;&nbsp;' + windSpeed + ' m/s');
            $('.city').append(cityName);
            $('.cloud').append('구름&nbsp;&nbsp;&nbsp;&nbsp;' + cloudiness + "%");
            $('.temp_min').append('최저 온도&nbsp;&nbsp;&nbsp;&nbsp;' + temp_min + 'º');
            $('.temp_max').append('최고 온도&nbsp;&nbsp;&nbsp;&nbsp;' + temp_max + 'º');
        });
    </script>
</body>
</html>

