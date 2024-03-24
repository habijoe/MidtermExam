<%@page import="com.auca.model.Course"%>
<%@page import="com.auca.model.AcademicUnit"%>
<%@page import="com.auca.model.Semester"%>
<%@page import="com.auca.dao.AcademicUnitDao"%>
<%@page import="com.auca.dao.SemesterDao"%>
<%@page import="com.auca.dao.CourseDao"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Courses by Department and Semester</title>
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
                <h1>Courses by Department and Semester</h1>

                <form method="post">
                    <label for="academicUnitId">Select an Academic Unit (Department):</label>
                    <select name="academicUnitId" id="academicUnitId">
                        <option value="" disabled selected>Select an Academic Unit (Department)</option>
                        <%
                            EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                            EntityManager em = emf.createEntityManager();
                            AcademicUnitDao academicUnitDao = new AcademicUnitDao(em);
                            List<AcademicUnit> academicUnits = academicUnitDao.findAll();
                            for (AcademicUnit academicUnit : academicUnits) {
                        %>
                            <option value="<%= academicUnit.getId() %>"><%= academicUnit.getName() %></option>
                        <%
                            }
                        %>
                    </select>

                    <label for="semesterId">Select a Semester:</label>
                    <select name="semesterId" id="semesterId">
                        <option value="" disabled selected>Select a Semester</option>
                        <%
                            SemesterDao semesterDao = new SemesterDao(em); // Reusing the same EntityManager
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

                <%
                    String academicUnitId = request.getParameter("academicUnitId");
                    String semesterId = request.getParameter("semesterId");
                    if (academicUnitId != null && !academicUnitId.isEmpty() && semesterId != null && !semesterId.isEmpty()) {
                        CourseDao courseDao = new CourseDao(emf.createEntityManager()); // Create a new EntityManager
                        List<Course> courses = courseDao.getCoursesByAcademicUnitAndSemester(academicUnitId, semesterId);
                %>
                        <h2>Courses offered by <%= academicUnitDao.findById(academicUnitId).getName() %> in <%= semesterDao.findById(semesterId).getName() %></h2>
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
                    // Close the EntityManager when done
                    em.close();
                %>
            </div>
        </div>
    </div>
</body>
</html>
