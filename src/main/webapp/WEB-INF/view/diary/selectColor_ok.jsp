<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Color Processed</title>
</head>
<body>

    <h2>Selected Color</h2>

    <%
        String selectedColor = request.getParameter("color");
        if (selectedColor != null && !selectedColor.isEmpty()) {
    %>
            <p>You selected the color: <span style="color:<%= selectedColor %>;"><%= selectedColor %></span></p>
    <%
        } else {
    %>
            <p>No color selected.</p>
    <%
        }
    %>

    <p><a href="colorSelection.jsp">Back to Color Selection</a></p>

</body>
</html>
