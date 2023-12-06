<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>색상 선택</title>
</head>
<body>
   <h2>사용 가능한 색상</h2>

   <% out.println(todayColors); %>

   <c:forEach var="color" items="${todayColors}" varStatus="status">
      <tr>
         <td>${color.maincolor_name}</td>
         <td>${color.maincolor_code1}</td>
         <td>${color.color_code2}</td>
      </tr>
   </c:forEach>
</body>

	
	

</html>
