<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="com.auca.model.StudentRegisteration"%>
<%@page import="com.auca.dao.StudentRegistrationDao"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="com.auca.dao.AcademicUnitDao"%>
<%@page import="com.auca.model.AcademicUnit"%>
<%@page import="com.auca.dao.SemesterDao"%>
<%@page import="com.auca.model.Semester"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Students by Department and Semester</title>
    <link rel="stylesheet" type="text/css" href="academic.css">
</head>
<body>
<nav class="sidebar">
    <!-- Your sidebar content goes here -->
</nav>
<div class="content-container">
    <div class="background-image">
        <!-- Your background image goes here -->
    </div>
    <div class="centered-content">
        <div class="signup-container">
            <h1>Students by Department and Semester</h1>

            <form method="post">
                <label for="departmentId">Select a Department:</label>
                <select name="departmentId" id="departmentId">
                    <option value="" disabled selected>Select a Department</option>
                    <!-- Populate the dropdown with department options from your database -->
                    <%
                        EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                        EntityManager em = emf.createEntityManager();
                        AcademicUnitDao au = new AcademicUnitDao(em);
                        List<AcademicUnit> departments = au.findAll(); // Fetch department AcademicUnits
                        for (AcademicUnit department : departments) {
                    %>
                        <option value="<%= department.getId() %>"><%= department.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <label for="semesterId">Select a Semester:</label>
                <select name="semesterId" id="semesterId">
                    <option value="" disabled selected>Select a Semester</option>
                    <!-- Populate the dropdown with semester options from your database -->
                    <%
                        SemesterDao semesterDao = new SemesterDao(em);
                        List<Semester> semesters = semesterDao.findAll();
                        for (Semester semester : semesters) {
                    %>
                        <option value="<%= semester.getId() %>"><%= semester.getName() %></option>
                    <%
                        }
                    %>
                </select>
                <input type="submit" value="Show Students">
            </form>

            <hr>

            <!-- Display students based on the selected department and semester -->
            <%
                String departmentId = request.getParameter("departmentId");
                String semesterId = request.getParameter("semesterId");
                if (departmentId != null && !departmentId.isEmpty() && semesterId != null && !semesterId.isEmpty()) {
                    StudentRegistrationDao studentDao = new StudentRegistrationDao(em);
                    List<StudentRegisteration> students = studentDao.getStudentsByDepartmentAndSemester(departmentId, semesterId);
            %>
                <h2>Students in Department <%= departmentId %> for Semester <%= semesterDao.findById(semesterId).getName() %></h2>
                <ul>
                    <%
                        for (StudentRegisteration studentRegistration : students) {
                    %>
                    <li><%= studentRegistration.getStudent().getName() %></li>
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
