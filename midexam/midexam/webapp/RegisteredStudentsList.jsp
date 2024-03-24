<%@page import="com.auca.model.StudentRegisteration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.auca.model.Course, com.auca.model.AcademicUnit, com.auca.model.Semester, javax.persistence.EntityManager, javax.persistence.EntityManagerFactory, javax.persistence.Persistence" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Registered Students</title>
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
    <h1>All Registered Students</h1>
    <table border="1">
        <tr>
            <th>Registered ID</th>
            <th>Department ID</th>
            <th>Semester ID</th>
            <th>Student ID</th>
            <th>Registered Date</th>
        </tr>
        <%
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
            EntityManager em = emf.createEntityManager();
            List<StudentRegisteration> registered = em.createQuery("SELECT s FROM StudentRegisteration s", StudentRegisteration.class).getResultList();
            for (StudentRegisteration register : registered) {
         %>
        <tr>
            <td><%= register.getId() %></td>
            <td><%= register.getAcademicUnit().getName() %></td>
            <td><%= register.getSemester().getName() %></td>
            <td><%= register.getStudent().getName() %></td>
            <td><%= register.getRegDate() %></td>
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