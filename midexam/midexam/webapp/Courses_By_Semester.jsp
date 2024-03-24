<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.Persistence"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.auca.model.Semester"%>
<%@ page import="com.auca.dao.SemesterDao"%>
<%@ page import="com.auca.model.Course"%>
<%@ page import="com.auca.dao.CourseDao"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Courses by Semester</title>
    <link rel="stylesheet" type="text/css" href="academic.css">
</head>
<body>
<nav class="sidebar">
        <div class="logo">
            <img src="aucaLogo.png" alt="School Logo">
        </div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="Login.jsp">Log Out</a></li>

        </ul>
        <div class="user-links">
            <a href="Home.jsp">Home</a>
            <a href="Login.jsp">Log Out</a>
        </div>
    </nav>
    <div class="content-container">
        <div class="background-image">
            <!-- Your background image goes here -->
        </div>
        <div class="centered-content">
            <div class="signup-container">
    <h1>Courses by Semester</h1>

    <form method="post">
        <label for="semesterId">Select a Semester:</label>
        <select name="semesterId" id="semesterId">
            <option value="" disabled selected>Select a Semester</option>
            <%-- Populate the dropdown with semester options from your database --%>
            <%
	            EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
	            EntityManager em = emf.createEntityManager();
                SemesterDao semesterDao = new SemesterDao(em);
                List<Semester> semesters = semesterDao.findAll();
                for (Semester semester : semesters) {
            %>
                <option value="<%= semester.getId() %>"><%= semester.getName() %></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Show Courses"><br>
        <a href="Home.jsp">Back Home</a>        
    </form>

    <hr>

    <%-- Display courses based on the selected semester --%>
    <%
        String semesterId = request.getParameter("semesterId");
        if (semesterId != null && !semesterId.isEmpty()) {
            // Fetch the list of courses offered in the selected semester
            CourseDao courseDao = new CourseDao(em);
            List<Course> courses = courseDao.getCoursesBySemester(semesterId);
    %>
        <h2>Courses offered in Semester <%= semesterDao.findById(semesterId).getName() %></h2>
        <ul>
            <%
                for (Course course : courses) {
            %>
                <li><%= course.getName() %></li>
            <%
                }
            %>
        </ul>
    <%
        }
    %>
</div>
    </div>
    </div>
</body>
</html>
