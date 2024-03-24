<%@page import="com.auca.dao.StudentDao"%>
<%@page import="com.auca.model.Student"%>
<%@page import="com.auca.model.AcademicUnit"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="com.auca.dao.AcademicUnitDao"%>
<%@page import="com.auca.dao.CourseDao"%>
<%@page import="com.auca.model.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Courses by Student</title>
    <link rel="stylesheet" type="text/css" href="academic.css">
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
    <h1>Courses by Student</h1>

    <form method="post">
        <label for="studentId">Select a Student:</label>
        <select name="studentId" id="studentId">
            <option value="" disabled selected>Select a Student</option>
            <%-- Populate the dropdown with student options from your database --%>
            <%
	            EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
	            EntityManager em = emf.createEntityManager(); 
	            StudentDao studentDao = new StudentDao(em);
	            CourseDao courseDao = new CourseDao(em);
                List<Student> students = studentDao.findAll();
                for (Student student : students) {
            %>
                <option value="<%= student.getId() %>"><%= student.getName() %></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Show Courses">
    </form>

    <hr>

    <%-- Display courses based on the selected student --%>
    <%
        String studentId = request.getParameter("studentId");
        if (studentId != null && !studentId.isEmpty()) {
            // Fetch the list of courses registered by the selected student
            // You need to adapt this code to your actual DAO and model structure
            List<Course> courses = courseDao.getCoursesByStudentId(studentId);
    %>
        <h2>Courses for Student <%= studentDao.findById(studentId).getName() %></h2>
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
