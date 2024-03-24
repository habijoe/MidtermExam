<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Course Definition</title>
    <link rel="stylesheet" type="text/css" href="course-definition.css">
</head>
<body>
    <nav class="sidebar">
        <div class="logo">
            <img src="aucaLogo.png" alt="School Logo">
        </div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            
        </ul>
        <div class="user-links">
           
        </div>
    </nav>
    <div class="content-container">
        <div class="background-image">
            <!-- Your background image goes here -->
        </div>
        <div class="centered-content">
            <div class="signup-container">
                <h1>Create Course Definition</h1>
                <form method="post" action="course-definition">
                    <label for="id">Course ID:</label>
                    <input type="text" id="id" name="id" required>
                    
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                    
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="4" required></textarea>
                    
                    <input type="submit" value="Create Course Definition">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
