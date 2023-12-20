<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <%@ include file="../common/head.jsp" %>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        body {
            background-image: url('/project_H/img/pa.jpg');
            background-size: cover;
        }

        th, td {
            text-align: center;
        }

        .disabled-link {
            pointer-events: none;
        }

        .custom-margin {
            margin-top: 6cm;
        }

        .center-container {
            text-align: center;
        }

        body,
        html {
            height: 100%;
            margin: 0;
            justify-content: center;
            align-items: center;
        }
        /* 이름 입력 칸의 너비를 7cm로 조절 */
        #custId,
        #uname,
        #email,
        .custom-input {
            width: 7cm;
        }
    </style>
    <script>
        function updateFunc(custId) {
            console.log('updateFunc() called');

            // AJAX 요청은 이 함수 내에서 수행되도록 이동
            $.ajax({
                type: 'GET',
                url: '/project_H/user/update/' + custId,
                success: function (result) {
                    let user = JSON.parse(result);
                    $('#custId').val(user.custId);
                    $('#uname').val(user.uname);
                    $('#email').val(user.email);
                    $('#updateModal').modal('show');
                }
            });
        }

        function deleteFunc(custId) {
            console.log('deleteFunc() called');
            $('#delUid').val(custId);
            $('#deleteModal').modal('show');
        }
    </script>
</head>

<body>
    <%@ include file="../common/top.jsp" %>
    <div class="container text-center custom-margin">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <!-- 사용자 수정 테이블 -->
                        <form action="/project_H/user/update" method="post">
                            <div class="mb-3 row">
                                <label for="custId" class="col-sm-3 col-form-label">사용자 ID</label>
                                <div class="col-sm-9">
                                    <input type="text" id="custId" class="form-control" value="<%= session.getAttribute("sessCustId") %>" disabled>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="pwd" class="col-sm-3 col-form-label">패스워드</label>
                                <div class="col-sm-9">
                                    <input type="password" name="pwd" class="form-control custom-input">
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="pwd2" class="col-sm-3 col-form-label">패스워드 확인</label>
                                <div class="col-sm-9">
                                    <input type="password" name="pwd2" class="form-control custom-input">
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="uname" class="col-sm-3 col-form-label">이름</label>
                                <div class="col-sm-9">
                                    <input type="text" name="uname" id="uname" class="form-control">
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="email" class="col-sm-3 col-form-label">이메일</label>
                                <div class="col-sm-9">
                                    <input type="text" name="email" id="email" class="form-control">
                                </div>
                            </div>
                            <div style="text-align: center;">
                                <input class="btn btn-primary" type="submit" value="수정">
                                <a class="btn btn-secondary ms-1" href="javascript:history.go(-1)">취소></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
