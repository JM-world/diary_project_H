<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제목을 입력하세요</title>
    <link href="/project_H/css/login.css" rel="stylesheet">
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="styles.css"> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 쿠키를 설정하는 함수
        function setCookie(name, value, days) {
            var expires = "";
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + value + expires + "; path=/";
        }

        // 쿠키 값을 가져오는 함수
        function getCookie(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) === ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }

        // 체크박스 변경을 처리하는 함수
        function handleCheckboxChange() {
            var rememberCheck = document.getElementById("remember-check");
            var custIdInput = document.getElementsByName("custId")[0];

            if (rememberCheck.checked) {
                setCookie("rememberedCustId", custIdInput.value, 7); // 7일 동안 기억
            } else {
                setCookie("rememberedCustId", "", -1); // 쿠키 삭제
            }
        }

        // 쿠키 값을 기준으로 초기값을 설정하는 함수
        function setInitialValues() {
            var rememberedCustId = getCookie("rememberedCustId");
            var custIdInput = document.getElementsByName("custId")[0];
            var rememberCheck = document.getElementById("remember-check");

            if (rememberedCustId) {
                custIdInput.value = rememberedCustId;
                rememberCheck.checked = true;
            }
        }

        // 페이지 로드 시 함수 실행
        window.onload = function () {
            setInitialValues();
        };
    </script>
</head>
<body>
    <div class="container" style="margin-top:1px">
        <div class="row">
            <div class="image-container" style="position: relative;">
                <img src="/project_H/img/pa.jpg" alt="HHH" class="background-image">
                <img src="/project_H/img/book2.png" alt="book1" style="position: absolute; top: 100px; left: 0px; width: 1100px; height: 600px; z-index: 1;">
                <div class="login-container" style="position: absolute; top: 320px; left: 770px; z-index: 2; background: none;">
                    <div class="login-wrapper">
                        <div class="container">
                            <h2>Login <button type="button" class="btn btn-secondary p-1" style="margin-left:130px;" onclick='location.href="/project_H/user/register"'>회원가입</button></h2>
                            <form method="post" action="/project_H/user/login" id="login-form">
                                <input type="text" name="custId" placeholder="아이디">
                                <input type="password" name="pwd" placeholder="비밀번호">
                                <label for="remember-check">
							        <input type="checkbox" id="remember-check" onchange="handleCheckboxChange()">아이디 저장하기
							    </label>
                                <input type="submit" value="Login">
                                <img src="/project_H/img/글씨3.png" alt="글씨3" style="position: absolute; top: -50px; left:-480px; width: 450px; height: 350px;">
                                <img src="/project_H/img/문구.png" alt="문구" style="position: absolute; top: 70px; left:-460px; width: 500px; height: 380px;">
                            </form>
                        </div>
                        &nbsp;&nbsp;<button class="btn btn-warning" onclick="location.href='/project_H/oauth2/authorization/kakao'" style="width: 93%; height: 48px;">카카오 로그인</button>
                        &nbsp;&nbsp;<button class="btn btn-success mt-3" onclick="location.href='/project_H/oauth2/authorization/naver'" style="width: 93%; height: 48px;">네이버 로그인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>
</html>