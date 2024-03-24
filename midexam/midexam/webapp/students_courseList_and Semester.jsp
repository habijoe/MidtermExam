<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.auca.dao.CourseDao"%>
<%@page import="com.auca.dao.SemesterDao"%>
<%@page import="com.auca.model.Course"%>
<%@page import="com.auca.model.Semester"%>
<%@page import="com.auca.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Students by Course and Semester</title>
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
            <h1>Students by Course and Semester</h1>

            <form method="post">
                <label for="courseId">Select a Course:</label>
                <select name="courseId" id="courseId">
                    <option value="" disabled selected>Select a Course</option>
                    <%
                        EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
                        EntityManager em = emf.createEntityManager();
                        CourseDao courseDao = new CourseDao(em);
                        List<Course> courses = courseDao.findAll();
                        for (Course course : courses) {
                    %>
                    <option value="<%= course.getId() %>"><%= course.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <label for="semesterId">Select a Semester:</label>
                <select name="semesterId" id="semesterId">
                    <option value="" disabled selected>Select a Semester</option>
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
                <a href="Home.jsp">Back Home</a>
            </form>

            <hr>

            <%
                String courseId = request.getParameter("courseId");
                String semesterId = request.getParameter("semesterId");
                if (courseId != null && !courseId.isEmpty() && semesterId != null && !semesterId.isEmpty()) {
                    Course selectedCourse = courseDao.findById(courseId);
                    Semester selectedSemester = semesterDao.findById(semesterId);
                    List<Student> students = selectedCourse.getStudents(); // Get all students in the selected course

                    // Filter students by the selected semester
                    List<Student> filteredStudents = new ArrayList<>();
                    for (Student student : students) {
                        for (Course course : student.getCourses()) {
                            if (course.getSemester().getId().equals(semesterId)) {
                                filteredStudents.add(student);
                                break;
                            }
                        }
                    }
            %>
            <h2>Students Enrolled in <%= selectedCourse.getName() %> for <%= selectedSemester.getName() %></h2>
            <ul>
                <%
                    for (Student student : filteredStudents) {
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
