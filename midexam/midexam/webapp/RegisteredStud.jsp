<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.auca.model.Semester, com.auca.dao.SemesterDao, com.auca.model.Student, com.auca.dao.StudentDao, com.auca.model.AcademicUnit, com.auca.dao.AcademicUnitDao, javax.persistence.EntityManager, javax.persistence.EntityManagerFactory, javax.persistence.Persistence" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Registration</title>
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
           
        </div>
    </nav>
    <div class="content-container">
        <div class="background-image">
            <!-- Your background image goes here -->
        </div>
        <div class="centered-content">
            <div class="signup-container">
                <h1>Student Registration</h1>
                <form method="post" action="${pageContext.request.contextPath}/studentregisteration">
                    <input type="hidden" name="action" value="create">
                    <label for="regId">Registration ID:</label>
                    <input type="text" name="id" id="regId">
                    <label for="depId">Select department:</label>
                    <select name="academicUnitId" id="depId">
                        <option value="" selected>Select department</option>
                        <%
                        EntityManagerFactory emg = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                        EntityManager en = emg.createEntityManager();
                        AcademicUnitDao academicUnitDao = new AcademicUnitDao(en);
                        List<AcademicUnit> departments = academicUnitDao.findDepartments();
                        for (AcademicUnit unit : departments) {
                        %>
                        <option value="<%= unit.getId() %>"><%= unit.getName() %></option>
                        <%
                        }
                        // Close the EntityManager here
                        en.close();
                        emg.close();
                        %>
                    </select>
                    <label for="semId">Select Semester ID:</label>
                    <select name="semesterId" id="semId">
                        <option value="" selected>Select Semester ID:</option>
                        <%
                        EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                        EntityManager em = emf.createEntityManager();
                        SemesterDao semesterDao = new SemesterDao(em);
                        List<Semester> semesterList = semesterDao.findAll();
                        for (Semester unit : semesterList) {
                        %>
                        <option value="<%= unit.getId() %>"><%= unit.getName() %></option>
                        <%
                        }
                        // Close the EntityManager here
                        em.close();
                        emf.close();
                        %>
                    </select>
                    <label for="stid">Select Student ID:</label>
                    <select name="studentId" id="stuId">
                        <option value="" selected>Select Student ID:</option>
                        <%
                        EntityManagerFactory emh = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                        EntityManager eo = emh.createEntityManager();
                        StudentDao studentDao = new StudentDao(eo);
                        List<Student> studentList = studentDao.findAll();
                        for (Student unit : studentList) {
                        %>
                        <option value="<%= unit.getId() %>"><%= unit.getId() %></option>
                        <%
                        }
                        // Close the EntityManager here
                        eo.close();
                        emh.close();
                        %>
                    </select>
                    <label for="regDate">Registration Date:</label>
                    <%
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                    String currentDate = sdf.format(new java.util.Date());
                    %>
                    <input type="text" name="regDate" id="regDate" value="<%= currentDate %>" readonly>
                    <input type="submit" value="Register Students">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
