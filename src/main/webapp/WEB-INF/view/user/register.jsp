<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" crossorigin="anonymous">
    <title>Your Page Title</title>
</head>

<body>
	
    <nav style="position: relative; height: 100vh; overflow: hidden;">
        <img src="/project_H/img/co.jpg" alt="co" style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0;">
        <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
            <img src="/project_H/img/book2.png" alt="book2" style="position: absolute; top: 1.5cm; left: 3cm; width: 80%; height: 80%;">
            <img src="/project_H/img/my_color.png" alt="my" style="position: absolute; top: 9cm; left: 20cm; width: 20%; height: 20%;">
            <div style="position: absolute; top: 200px; left: calc(250px + 2cm); color: #black; z-index: 1;">
                <h3><strong>회원가입</strong></h3>
                <hr style="width: 80%; margin: 7px 0; border: 1px solid #fff;">
                <form action="/project_H/user/register" method="post">
                    <table style="width: 90%; border-spacing: 10px; border-collapse: separate;">
                        <tr>
                            <td style="width: 35%;"><label class="col-form-label">사용자 ID</label></td>
                            <td style="width: 65%;"><input type="text" name="custId" class="form-control" style="width: calc(100% - 20px); margin-bottom: 16px;"></td>
                        </tr>
                        <tr>
                            <td><label class="col-form-label">PW</label></td>
                            <td><input type="password" name="pwd" class="form-control" style="width: calc(100% - 20px); margin-bottom: 16px;"></td>
                        </tr>
                        <tr>
                            <td><label class="col-form-label">PW 확인</label></td>
                            <td><input type="password" name="pwd2" class="form-control" style="width: calc(100% - 20px); margin-bottom: 16px;"></td>
                        </tr>
                        <tr>
                            <td><label class="col-form-label">이름</label></td>
                            <td><input type="text" name="uname" class="form-control" style="width: calc(100% - 20px); margin-bottom: 16px;"></td>
                        </tr>
                        <tr>
                            <td><label class="col-form-label">별명</label></td>
                            <td><input type="text" name="nickName" class="form-control" style="width: calc(100% - 20px); margin-bottom: 16px;"></td>
                        </tr>
                        <tr>
                            <td><label class="col-form-label">이메일</label></td>
                            <td><input type="text" name="email" class="form-control" style="width: calc(100% - 20px); margin-bottom: 16px;"></td>
                        </tr>
                        <tr>
						 <td colspan="2" style="text-align: center;">
                              <input class="btn btn-pink" type="submit" value="가입">
                              <input class="btn btn-pink ms-1" type="reset" value="취소">
                          </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </nav>


</body>

</html>