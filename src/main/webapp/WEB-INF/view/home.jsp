<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project_H</title>
    
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
            display: flex;
            height: 100vh;
        }

        body::before {
            content: "";
            background: url('img/CCC.jpg') center center / cover no-repeat fixed;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .content {
            flex: 1;
            text-align: center;
            color: white;
            font-size: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .book-image {
            width: 1200px;
            height: auto;
            position: relative;
            z-index: 1;
        }

        .text-box {
            position: absolute;
            top: 48%;
            left: 33%;
            transform: translate(-50%, -50%);
            width: 40%;
            color: black;
            text-align: center;
            z-index: 2; /* Make sure the text box is on top of the image */
            font-size: 15px; /* 변경된 글자 크기 */
            font-family: 'Arial', sans-serif; /* 폰트 변경 */
        }

        .login-form {
            width: 300px; /* 원하는 폭으로 조절 */
            height: 400px; /* 원하는 높이로 조절 */
            padding: 40px;
            box-sizing: border-box;
            position: absolute;
            top: 60%;
            left:135%;
            transform: translate(-50%, -50%);
            text-align: right;
            z-index: 2; /* Ensure the form is on top of the image */
            background-color: ;
            border-radius: 10px;
        }

        .input-box {
            position: relative;
            margin: 10px 0;
            color: black;
        }

        .input-box > input {
            background: transparent;
            border: none;
            border-bottom: solid 1px black; /* 변경된 부분: 검정색 밑줄 */
            padding: 20px 0px 5px 0px;
            font-size: 14pt;
            width: 100%;
            color:black;
        }

        .input-box > input::placeholder {
            color:black;
        }

        .input-box > input:placeholder-shown + label {
            color:black;
            font-size: 14pt;
            top: 15px;
        }

        .input-box > input:focus + label, label {
            color: black;
            font-size: 10pt;
            pointer-events: none;
            position: absolute;
            left: 0px;
            top: 0px;
            transition: all 0.2s ease ;
            -webkit-transition: all 0.2s ease;
            -moz-transition: all 0.2s ease;
            -o-transition: all 0.2s ease;
        }

        .input-box > input:focus, .input-box > input:not(:placeholder-shown) {
            border-bottom: solid 1px #8aa1a1;
            color:black;
            outline: none;
        }

        /* 로그인 버튼 스타일 추가 */
        .login-form input[type="submit"] {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .login-form input[type="submit"]:hover {
            background-color: #2980b9; /* hover 효과 배경색 */
        }

        /* 아이디 저장하기 체크박스 및 회원가입 링크 위치 조절 */
        .login-form label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 170px;
            right:180px;
            margin-bottom: 300px;
        }
        
        .board-link {
            cursor: pointer;
            color: #3498db;
        }
    </style>
</head>
<body>
    <div class="content">
        <img src="img/book1.png" alt="책 이미지" class="book-image">
        <div class="text-box">
        	<br>
        	<br>
            <h2>컬러를 골라 펼쳐보세요.</h2>
            <br>
            <p>포레스트 그린을 골랐나요?</p>
            <p>안정감과 편안함이 필요하다는 신호입니다.</p>
            <br>
            <p>네온 핑크에 끌리나요?</p>
            <p>당신은 누군가의 매력에 풍덩 빠져있을지 모릅니다.</p>
            <br>
            <p>푸른 달 컬러를 골랐다면?</p>
            <p>썰물이 빠져나간 것처럼 울적하지는 않은가요.</p>
            <br>
            <p>컬러는 말로 설명하기 힘든 복잡한 감정을 선명하게</p>
            <p>지친 마음을 어떻게 돌봐야 할지도 알려주죠.</p>
            <br>
            <p>매일 저녁, 오늘의 기분과 연결된 컬러를 찾아보세요.</p>
            <p>세수하듯 자신의 마음을 들여다볼 때</p>
            <p>행복의 빈도를 높일 수 있으니까요.</p>
            <!-- 로그인 폼 추가 -->
            <div class="login-form">
                <form method="post" action="/project/user/main" id="login-form">
                    <div class="input-box">
                        <input type="text" name="userName" placeholder="아이디:">
                    </div>
                    <div class="input-box">         
                        <input type="password" name="userPassword" placeholder="비밀번호:">
                    </div>
                    <a class="board-link" href="#">회원가입</a>
                    <br>
                    <br>
                    <input type="submit" value="Login">
                </form>
            </div>
        </div>
    </div>

</body>
</html>