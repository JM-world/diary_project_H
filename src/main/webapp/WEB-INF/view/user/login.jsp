<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="/project_H/css/login.css" rel="stylesheet">
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="styles.css"> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container" style="margin-top:1px">
        <div class="row">
            <div class="image-container" style="position: relative;">
                <img src="/project_H/img/jo.jpg" alt="jo" class="background-image">
                <img src="/project_H/img/book2.png" alt="book2" style="position: absolute; top: 100px; left: 0px; width: 1300px; height: 800px; z-index: 1;">
                <div class="login-container" style="position: absolute; top: 450px; left: 870px; z-index: 2; background: none;">
                    <div class="login-wrapper">
                        <div class="container">
                            <h2>Login <button type="button" class="btn btn-outline-black" onclick='location.href="/project_H/user/register"'>회원가입</button></h2>
                            <form method="post" action="/project_H/user/login" id="login-form">
                                <input type="text" name="custId" placeholder="Email">
                                <input type="password" name="pwd" placeholder="Password">
                                <label for="remember-check">
                                    <input type="checkbox" id="remember-check">아이디 저장하기
                                </label>
                                <input type="submit" value="Login">
							            <img src="/project_H/img/글씨3.png" alt="글씨3" style="position: absolute; top: -150px; left:-540px; width: 500px; height: 400px;">
							            <img src="/project_H/img/문구.png" alt="문구" style="position: absolute; top: 0px; left:-500px; width: 500px; height: 500px;">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>
</html>