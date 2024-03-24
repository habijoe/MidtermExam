package com.auca.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.auca.model.CourseDefinition;
import com.auca.model.Semester;

public class CourseDefinitionDao {
	
	   private EntityManager entityManager;

	    public CourseDefinitionDao (EntityManager entityManager) {
	        this.entityManager = entityManager;
	    }

	    public void save(CourseDefinition definition) {
	        EntityTransaction transaction = entityManager.getTransaction();
	        try {
	            transaction.begin();
	            entityManager.persist(definition);
	            transaction.commit();
	        } catch (Exception e) {
	            if (transaction != null && transaction.isActive()) {
	                transaction.rollback();
	            }
	            e.printStackTrace();
	        }
	    }

}
