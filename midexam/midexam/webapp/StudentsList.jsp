<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.auca.model.Student, com.auca.model.AcademicUnit, com.auca.model.Semester, javax.persistence.EntityManager, javax.persistence.EntityManagerFactory, javax.persistence.Persistence" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registered Semester Students</title>
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
    <h1>All Students</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Date Of Birth</th>
            <th>Telephone</th>
        </tr>
        <%
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
            EntityManager em = emf.createEntityManager();
            List<Student> activeStudents = em.createQuery("SELECT s FROM Student s", Student.class).getResultList();
            for (Student student : activeStudents) {
         %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getName() %></td>
            <td><%= student.getDob() %></td>
            <td><%= student.getTelephone() %></td>
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