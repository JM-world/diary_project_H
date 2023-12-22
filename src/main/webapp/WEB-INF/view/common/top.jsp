<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

 <div id="content">
 <!-- Your actual content goes here -->
 <nav class="navbar navbar-expand-sm bg-light navbar-light">
    <div class="container-fluid">
 	        <div class="text-center" style="padding-left: 20px;">
            <div>
            	<h4 style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
            		<a href="/project_H/home" style="text-decoration: none; color: #bbb8cc;" 
            		onmouseover="this.style.color='#ddc0de'" onmouseout="this.style.color='#bbb8cc'">
            		<img src="/project_H/img/bookMain.gif" width="50" height="50 " style="border-radius: 50%;"/>  오늘의 기분, 오늘의 컬러 </a>
            	</h4>
	           	</div>
	        </div>
            <ul class="navbar-nav ms-auto">
            	<li class="nav-item me-3">
				    <a style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
				        <span class="weather_icon"></span>
				    </a>
				</li>
                <li class="nav-item me-3">
                    <a style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
                        <span class="current_temp" style="font-size: 20px"></span>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
                        <span class="weather_description" style="font-size: 20px"></span>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
                        <span class="city" style="font-size: 20px"></span>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a id = "diary" href="/project_H/diary/color" class="nav-link btn btn-outline-secondary" title="일기 쓰기"
                        data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
                        <i class="fas fa-edit"></i>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a id="calendarLink" href="/project_H/calendar" class="nav-link btn btn-outline-secondary"
                        title="캘린더 보기" data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
                        <i class="fas fa-calendar"></i>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a id="myDiaryLink" href="/project_H/diary/diarylist" class="nav-link btn btn-outline-secondary"
                        title="내가 쓴 일기" data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip"
                        data-bs-placement="bottom">
                        <i class="fas fa-book"></i>
                    </a>
                </li>
              <li class="nav-item me-3">
		            <a id = "boardLink" href="/project_H/board/list/1" class="nav-link btn btn-outline-secondary" title="자유게시판"
		            	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
		              <i class="fas fa-list-alt"></i>
		            </a>
         		</li>
	          <li class="nav-item me-3">
	            <a id = "boardLink2" href="/project_H/diary/list/1" class="nav-link btn btn-outline-secondary" title="공유게시판"
	            	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
	            <i class="far fa-list-alt"></i>
	            </a>
	            </li>
	           <li class="nav-item me-3">
		         <a href="/project_H/api/local" class="nav-link btn btn-outline-secondary" title="상담센터 지도"
		            data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
		          <i class="fas fa-map-marker-alt"></i>
		            </a>
         		 </li>
				<li class="nav-item me-3">
           			<c:if test="${not empty sessCustId}">
              			<div class="dropdown">
				<button class="btn btn-outline-secondary dropdown-toggle" type="button" id="profileMenu" data-bs-toggle="dropdown">
				    <i class="fas fa-user"></i>
				  </button>
				  <ul class="dropdown-menu dropdown-menu-end">
				    <li><a class="dropdown-item" style="font-weight: bold;" href="/project_H/user/list/1">개인정보 수정</a></li>
				    <li><hr class="dropdown-divider"></hr></li>
				    <li><a class="dropdown-item text-danger" style="font-weight: bold;" href="#" data-bs-toggle="modal"
				    data-bs-target="#logoutModal">로그아웃</a></li>
				  </ul>
			  </div>
		            </c:if>
		            <c:if test="${empty sessCustId}">
		              <a href="/project_H/user/login" class="nav-link btn btn-outline-secondary" title="로그인"
		              	data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
		                <i class="fas fa-sign-in-alt"></i>
		              </a>
		            </c:if>
        		  </li>
         	 </ul>
       </div>       
    </nav>

    <c:if test="${not empty sessCustId}">
	    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog modal-sm" role="document">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="exampleModalLabel"></h5>
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div class="modal-body text-center">
	                    <h6>로그아웃할까요?</h6>
	                </div>
	                <div class="modal-footer justify-content-center">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                    <button type="button" class="btn btn-danger" onclick="performLogout()">로그아웃</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</c:if>
   <script>
   function performLogout() {
       
       window.location.href = "/project_H/user/logout";
   }
   
    function showLoginModal() {
        $('#loginModal').modal('show');
    }

    document.getElementById('myDiaryLink').addEventListener('click', function (event) {
        var isUserLoggedIn = ${not empty sessCustId};
        if (!isUserLoggedIn) {
            event.preventDefault();
            showLoginModal();
        }
    });

    document.getElementById('calendarLink').addEventListener('click', function (event) {
        var isUserLoggedIn = ${not empty sessCustId};
        if (!isUserLoggedIn) {
            event.preventDefault();
            showLoginModal();
        }
    });

    document.getElementById('boardLink').addEventListener('click', function (event) {
        var isUserLoggedIn = ${not empty sessCustId};
        if (!isUserLoggedIn) {
            event.preventDefault();
            showLoginModal();
        }
    });

    document.getElementById('boardLink2').addEventListener('click', function (event) {
        var isUserLoggedIn = ${not empty sessCustId};
        if (!isUserLoggedIn) {
            event.preventDefault();
            showLoginModal();
        }
    });

    document.getElementById('diary').addEventListener('click', function (event) {
        var isUserLoggedIn = ${not empty sessCustId};
        if (!isUserLoggedIn) {
            event.preventDefault();
            showLoginModal();
        }
    });

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
	    var iconCode = '<%= request.getAttribute("iconCode") %>';
	    var temperature = '<%= request.getAttribute("temperature") %>';
	    var humidity = '<%= request.getAttribute("humidity") %>';
	    var windSpeed = '<%= request.getAttribute("windSpeed") %>';
	    var cloudiness = '<%= request.getAttribute("cloudiness") %>';
	    var temp_min = '<%= request.getAttribute("temp_min") %>';
	    var temp_max = '<%= request.getAttribute("temp_max") %>';
	    var cityName = '<%= request.getAttribute("name") %>'; 
	    var iconClass = weatherIcon[iconCode];
        

        // 날씨 정보를 HTML에 적용
    	$('.weather_icon').append('<i class="' + weatherIcon[iconCode] +' fa-2x" style="height: 40px; width: 40px;"></i>');
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
<c:if test="${empty sessCustId}">
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그인 필요</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <h6>로그인이 필요한 서비스입니다.</h6>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <a href="/project_H/user/login" class="btn btn-primary">로그인</a>
                </div>
            </div>
        </div>
    </div>
</c:if>
   
</div>
