<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Alert Message</title>
</head>
<body>
	<script>
		let msg = '${msg}';
		let url = '${url}';
		alert(msg);
		location.href = url;
	</script>
</body>
</html>