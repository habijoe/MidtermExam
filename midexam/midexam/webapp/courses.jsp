<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.auca.model.Semester, com.auca.dao.SemesterDao, com.auca.model.Student, com.auca.dao.StudentDao, com.auca.model.AcademicUnit, com.auca.dao.AcademicUnitDao, javax.persistence.EntityManager, javax.persistence.EntityManagerFactory, javax.persistence.Persistence" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Creation</title>
    <link rel="stylesheet" type="text/css" href="course-creation.css">
</head>
<body>
    <nav class="sidebar">
        <div class "logo">
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
                <h1>Course Creation</h1>
                <form method="post" action="${pageContext.request.contextPath}/courses">
                    <input type="hidden" name="action" value="create">
                    <label for="courseId">Course ID:</label>
                    <input type="text" name="id" id="courseId">
                    <label for="courseName">Course Name:</label>
                    <input type="text" name="name" id="courseName">
                    <label for="semId">Semester ID:</label>
                    <input type="text" name="semesterId" id="semId">
                    <label for="deptId">Academic Unit ID:</label>
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
                    <input type="submit" value="Create Course">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
