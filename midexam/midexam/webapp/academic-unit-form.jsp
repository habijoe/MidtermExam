<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.auca.model.AcademicUnit, com.auca.model.EAcademicUnit, javax.persistence.EntityManager, javax.persistence.EntityManagerFactory, javax.persistence.Persistence" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Academic Unit Management</title>
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
    			<h1>Academic Unit Management</h1>

    <form method="post" action="${pageContext.request.contextPath}/academic-units">
        <input type="hidden" name="action" value="create">
        
        <label for="unitId">Academic Unit ID:</label>
        <input type="text" name="id" id="unitId">
        
        <label for="unitName">Academic Unit Name:</label>
        <input type="text" name="name" id="unitName">

        <label for="unitType">Academic Unit Type:</label>
        <select name="type" id="unitType" onchange="loadSelfReferenceIds()">
            <option value="PROGRAMME">PROGRAMME</option>
            <option value="FACULTY">FACULTY</option>
            <option value="DEPARTMENT">DEPARTMENT</option>
        </select>

        <label for="selfReferenceId">Self-Reference ID:</label>
        <select name="unit" id="selfReferenceId">
            <option value="" selected>Select a Self-Reference ID</option>
        </select>
        <br>
        <%
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("YourPersistenceUnit");
        EntityManager em = emf.createEntityManager();
        List<AcademicUnit> selfReferenceUnits = em.createQuery("SELECT au FROM AcademicUnit au", AcademicUnit.class)
            .getResultList();
        em.close();
        emf.close();
        %>
        <input type="submit" value="Create Academic Unit">
    </form>
        
    <script>
        // Define an array to store all the available options
        var allOptions = [
            { type: 'PROGRAMME', options: [] },
            { type: 'FACULTY', options: [] },
            { type: 'DEPARTMENT', options: [] }
        ];
        
        // Populate the options array from the database
        <%
        for (AcademicUnit unit : selfReferenceUnits) {
            String optionValue = unit.getId();
            String unitType = unit.getType().toString();
        %>
            allOptions.find(item => item.type === "<%= unitType %>").options.push("<%= optionValue %>");
        <%
        }
        %>
        
        // Function to load Self-Reference IDs based on the unit type above the selected one
        function loadSelfReferenceIds() {
    var unitTypeSelect = document.getElementById("unitType");
    var selfReferenceIdSelect = document.getElementById("selfReferenceId");
    selfReferenceIdSelect.innerHTML = '';

    // Get the selected unit type
    var unitType = unitTypeSelect.value;

    if (unitType !== "PROGRAMME") {
        // Get the unit type directly above the selected one
        var unitTypeAbove = unitType === "DEPARTMENT" ? "FACULTY" :
                            unitType === "FACULTY" ? "PROGRAMME" : "";
        
        // Get the relevant options based on the unit type above
        var options = allOptions.find(item => item.type === unitTypeAbove).options;

        // Populate the dropdown with the relevant options
        options.forEach(function (option) {
            var optionElement = document.createElement("option");
            optionElement.value = option;
            optionElement.text = option;
            selfReferenceIdSelect.appendChild(optionElement);
        });
    }
}

        // Initially load self-reference options based on the default unit type
        loadSelfReferenceIds();
    </script>
    </div>
    </div>
    </div>
</body>
</html>