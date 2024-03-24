<%@page import="com.auca.model.Teacher"%>
<%@page import="com.auca.model.CourseDefinition"%>
<%@page import="com.auca.model.StudentRegisteration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.auca.model.Course, com.auca.model.AcademicUnit, com.auca.model.Semester, javax.persistence.EntityManager, javax.persistence.EntityManagerFactory, javax.persistence.Persistence" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Courses</title>
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
    <h1>All Teachers</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Qualification</th>
        </tr>
        <%
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
            EntityManager em = emf.createEntityManager();
            List<Teacher> teacher = em.createQuery("SELECT s FROM Teacher s", Teacher.class).getResultList();
            for (Teacher teach : teacher) {
         %>
        <tr>
            <td><%= teach.getId() %></td>
            <td><%= teach.getName() %></td>
            <td><%= teach.getQualification() %></td>
        </tr>
        <%
            }
            em.close();
            emf.close();
        %>
    </table>
    <a href="Home.jsp">Back Home</a>
    </div>
    </div>
    </div>
</body>
</html>