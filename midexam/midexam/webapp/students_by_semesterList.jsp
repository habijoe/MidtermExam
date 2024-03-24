<%@page import="com.auca.dao.StudentRegistrationDao"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="com.auca.dao.SemesterDao"%>
<%@page import="com.auca.model.Semester"%>
<%@page import="com.auca.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Students by Semester</title>
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
           
        </div>
    </nav>
    <div class="content-container">
        <div class="background-image">
            <!-- Your background image goes here -->
        </div>
        <div class="centered-content">
            <div class="signup-container">

    <h1>Students by Semester</h1>

    <form method="post">
        <label for="semesterId">Select a Semester:</label>
        <select name="semesterId" id="semesterId">
            <option value="" disabled selected>Select a Semester</option>
            <%-- Populate the dropdown with semester options from your database --%>
            <%
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                EntityManager em = emf.createEntityManager();
                StudentRegistrationDao studentRegistrationDao = new StudentRegistrationDao(em);
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
        <a href="Home.jsp">Back Home</a>
    </form>

    <hr>

    <%-- Display students based on the selected semester --%>
		    <%
		    String semesterId = request.getParameter("semesterId");
		    if (semesterId != null && !semesterId.isEmpty()) {
		        Semester selectedSemester = semesterDao.findById(semesterId);
		        List<Student> students = studentRegistrationDao.getStudentsBySemester(selectedSemester);
		%>
		<h2>Students Registered in <%= selectedSemester.getName() %></h2>
		<ul>
		    <%
		        for (Student student : students) {
		    %>
		    <li><%= student.getName() %></li>
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
