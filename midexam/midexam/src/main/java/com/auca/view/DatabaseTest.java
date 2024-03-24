package com.auca.view;

import java.util.Properties;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;


import com.auca.model.AcademicUnit;
import com.auca.model.Course;
import com.auca.model.Semester;
import com.auca.model.Student;
import com.auca.model.StudentRegisteration;
import com.auca.model.Teacher;
import com.auca.model.CourseDefinition;

public class DatabaseTest {
	

	private static SessionFactory sessionFactory;
	
	public static SessionFactory getSession() {
		
			try {
				Configuration configuration = new Configuration();

				// Hibernate settings equivalent to hibernate.cfg.xml's properties
				Properties settings = new Properties();
				settings.put(Environment.DRIVER, "com.mysql.jdbc.Driver");
				settings.put(Environment.URL, "jdbc:mysql://localhost:3306/finalexam?createDatabaseIfNotExist=true");
				settings.put(Environment.USER, "root");
				settings.put(Environment.PASS, "12345");
				settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL8Dialect");

				settings.put(Environment.SHOW_SQL, "true");

				settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");

				settings.put(Environment.HBM2DDL_AUTO, "update");

				
				// This help to put all properites into our configuration
				configuration.setProperties(settings);
				
				configuration.addAnnotatedClass(AcademicUnit.class);
				configuration.addAnnotatedClass(Teacher.class);
				configuration.addAnnotatedClass(Course.class);
				configuration.addAnnotatedClass(Student.class);
				configuration.addAnnotatedClass(Semester.class);
				configuration.addAnnotatedClass(CourseDefinition.class);
				configuration.addAnnotatedClass(StudentRegisteration.class);
				
				ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
						.applySettings(configuration.getProperties()).build();
				System.out.println("Hibernate Java Config serviceRegistry created");
				sessionFactory = configuration.buildSessionFactory(serviceRegistry);
				return sessionFactory;

			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return sessionFactory;
	}
	
	public static void main(String[] args) {
	    SessionFactory sessionFactory = getSession();

	    // Open a session
	    Session session = sessionFactory.openSession();

	    // Perform database operations using the session
	    // ...

	    // Close the session when you're done
	    session.close();
	}

	
}




