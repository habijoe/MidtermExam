<%@page import="com.auca.model.AcademicUnit"%>
<%@page import="com.auca.model.Teacher"%>
<%@page import="com.auca.dao.AcademicUnitDao"%>
<%@page import="com.auca.dao.TeacherDao"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
    <%
    
	    TeacherDao teacherDao;
	    AcademicUnitDao academicDao;
	   
    	
    
    	if("POST".equals(request.getMethod())) {
    		EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
    	    EntityManager em = emf.createEntityManager();
    	    teacherDao = new TeacherDao(em);
    	    academicDao = new AcademicUnitDao(em);
    		
		    String teacherId = request.getParameter("teacher");
			String academicId = request.getParameter("admin");
			
			Teacher teach = teacherDao.findById(teacherId);
			AcademicUnit academic = academicDao.findById(academicId);
			
			List<AcademicUnit> academi = new ArrayList<AcademicUnit>();
			academi.add(academic);
			
			teach.setAcademicUnits(academi);
			teacherDao.update(teach);
			
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
	<form action="teacher_admin.jsp" method="POST">
		<label>Teacher ID:</label><br>
		<input type="text" name="teacher"><br>
		<label>AcademicUnit ID:</label><br>
		<input type="text" name="admin">
		<button type="submit">Add Unit</button>
	</form>
	</div>
	</div>
	</div>
</body>
</html>