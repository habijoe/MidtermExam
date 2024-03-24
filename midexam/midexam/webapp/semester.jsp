<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Semester Creation</title>
    <link rel="stylesheet" type="text/css" href="sem.css">
    
    <!-- Add jQuery and jQuery UI Datepicker from a CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <script>
        $(function() {
            // Initialize date picker for Start Date
            $("#startDate").datepicker({
                dateFormat: "yy-mm-dd", // Define the date format
                minDate: 0, // Restrict to select dates from today and onward
                changeMonth: true,
                changeYear: true
            });

            // Initialize date picker for End Date
            $("#endDate").datepicker({
                dateFormat: "yy-mm-dd", // Define the date format
                minDate: 0, // Restrict to select dates from today and onward
                changeMonth: true,
                changeYear: true
            });
        });
    </script>
</head>
<body>
<nav class="sidebar">
    <div class="logo">
        <img src="aucaLogo.png" alt="School Logo">
    </div>
    <ul class="nav-links">
        <li><a href="Home.jsp">Home</a></li>
        
    </ul>
    
</nav>
<div class="content-container">
    <div class="background-image">
        <!-- Your background image goes here -->
    </div>
    <div class="centered-content">
        <div class="signup-container">
            <h1>Semester Creation</h1>
            <form method="post" action="${pageContext.request.contextPath}/semesters">
                <input type="hidden" name="action" value="create">
                <label for="unitId">Semester ID:</label>
                <input type="text" name="id" id="unitId">
                <label for="unitName">Semester Name:</label>
                <input type="text" name="name" id="unitName">
                <label for="startDate">Start Date:</label>
                <input type="text" name="startDate" id="startDate" required>
                <label for="endDate">End Date:</label>
                <input type="text" name="endDate" id="endDate" required>
                <input type="submit" value="Create Semester">
            </form>
        </div>
    </div>
</div>
</body>
</html>
