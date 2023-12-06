<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>상담센터 검색하기</title>
    <style>
	* {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        body {
            font-size: 14px;
            font-family: 'Roboto', sans-serif;
            overflow: hidden; /* 화면 가득 찬 이미지를 위해 추가 */
            margin: 0; /* body의 기본 margin 제거 */
        }

        .background-image {
            width: 100%;
            height: 100vh; /* 뷰포트 높이를 100%로 설정 */
            object-fit: cover;
            position: fixed;
            top: 0;
            left: 0;
            z-index: -1;
        }

        .foreground-image {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1;
        }
		

				
		.content-container {
		    position: relative;
		    z-index: 1;
		    width: 600px;
		    height: 5px; /* 원래 높이에서 5cm 내리기 */
		    margin: 10cm auto; /* 가운데 정렬을 위해 top과 bottom을 auto로 설정 */
		    transform: translateY(-50%); /* 현재 위치에서 위로 50% 이동하여 정확한 가운데 정렬 */
		}
   		
        #map {
            width: 600px; /* 원래 너비에서 10px 빼기 */
            height: 500px; /* 원래 높이에서 10px 빼기 */
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <img src="/project_H/img/CCC.png" alt="CCC" class="background-image">
    <img src="/project_H/img/book1.png" alt="book1" style="position: absolute; top: 100px; left: 60px; width: 1300px; height: 800px; z-index: 1;">
    
    <div class="content-container" style="margin-top: 5cm;">
    <h2>상담센터 지도 검색</h2>
        <label for="keyword">상담센터 지역:</label>
        <input type="text" id="keyword" />
        <button onclick="searchCounselingCenters()">검색</button>
        <div id="map"></div>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=163531f559b3b1b15070b9932b6799e2&libraries=services"></script>
    <script>
        var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        function searchCounselingCenters() {
            var keyword = document.getElementById('keyword').value;

            var ps = new kakao.maps.services.Places();
            ps.keywordSearch(keyword + ' 상담센터', placesSearchCB);
        }

        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                var bounds = new kakao.maps.LatLngBounds();

                for (var i = 0; i < data.length; i++) {
                    displayMarker(data[i]);
                    bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                }

                map.setBounds(bounds);
            }
        }

        function displayMarker(place) {
            var marker = new kakao.maps.Marker({
                map: map,
                position: new kakao.maps.LatLng(place.y, place.x)
            });

            kakao.maps.event.addListener(marker, 'click', function () {
                var content =
                    '<div style="padding:17px;font-size:15px;">' +
                    '<strong>' + place.place_name + '</strong><br>' +
                    '전화번호: ' + place.phone + '<br>' +
                    '위치: ' + place.address_name +
                    '</div>';

                infowindow.setContent(content);
                infowindow.open(map, marker);
            });
        }
    </script>
</body>
</html>
