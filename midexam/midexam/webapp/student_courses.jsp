<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.auca.model.Course"%>
<%@page import="java.util.List"%>
<%@page import="com.auca.dao.CourseDao"%>
<%@page import="com.auca.model.Student"%>
<%@page import="com.auca.dao.StudentDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
    <%
    
	    StudentDao studentDao;
	    CourseDao courseDao;
	   
    	
    
    	if("POST".equals(request.getMethod())) {
    		EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
    	    EntityManager em = emf.createEntityManager();
    	    studentDao = new StudentDao(em);
    	    courseDao = new CourseDao(em);
    		
		    String studentId = request.getParameter("student");
			String courseId = request.getParameter("course");
			
			Student student = studentDao.findById(studentId);
			Course course = courseDao.findById(courseId);
			
			List<Course> courses = new ArrayList<Course>();
			courses.add(course);
			
			student.setCourses(courses);
			studentDao.update(student);
			
			response.sendRedirect("Home.jsp");
    	}
    	
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
	<form action="student_courses.jsp" method="POST">
		<label>Student Id:</label><br>
		<input type="text" name="student"><br>
		<label>Course Id:</label><br>
		<input type="text" name="course">
		<button type="submit">Add Course</button><br>
		<a href="Home.jsp">Back Home</a>
	</form>
	</div>
        </div>
    </div>
</body>
</html>