<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		function checkContentAndRead() {
			  let val = $('#content').val();
	
			  if (val !== null && val !== undefined) {
			    read(); 
			  } 
			}
		
		function read() {
				let val = $('#content').val();
				
			    if (val.length % 10 == 0) {
			    
				  $.ajax({
				    type: 'GET',
				    url: '/project_H/diary/write_in',
				    data: {contentIn: val},
				    success: function(result) {
				  	$('#content-out').html(result);
				    }
				    
				  });
				}
		}
		
	</script>
</head>

<body>
	<div class="layout">
		<form action="/project_H/diary/diaryWrite" method="post">
		
			<textarea class="form-control" rows="5" name="content" id="content" onkeyup="checkContentAndRead()"></textarea> 
			<br>
			<div class="card">
            <div class="card-body">
              <h5 class="card-title">출력 창</h5>
              <div id="content-out"></div>
            </div>
          </div>
			<div class="form-check">
				<input type="checkbox" id="share" name="share" class="form-check-input"> 
				<input type="hidden" name="_share" value="on"/>
				<label>공유게시판에 포스팅하기</label>
			<br>
			</div>
			<button type="submit">제출하기</button>
		</form>
	</div>
</body>
</html>