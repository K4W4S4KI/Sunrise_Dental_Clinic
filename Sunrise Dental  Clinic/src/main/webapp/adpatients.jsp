<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.patient" %>

<%
// Check admin login
if (session.getAttribute("loggedInAdmin") == null) {
response.sendRedirect(
request.getContextPath() + "/adlogin.jsp"
);
return;
}


ArrayList<patient> patientList =
    (ArrayList<patient>) request.getAttribute("patientList");

String keyword =
    (String) request.getAttribute("keyword");

Integer totalPatients =
    (Integer) request.getAttribute("totalPatients");

if (patientList == null) {
    patientList = new ArrayList<patient>();
}

if (keyword == null) {
    keyword = "";
}

if (totalPatients == null) {
    totalPatients = patientList.size();
}


%>

<!DOCTYPE html>

<html lang="en">

<head>


<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Patients | Sunrise Dental Clinic</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/CSS/adpatients.css">

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>

<body>

<!-- =========================================================
     TOP NAVBAR
========================================================= -->

<header class="top-navbar">

```
<!-- BRAND -->

<div class="brand">

    <div class="brand-icon">
        <i class="fa-solid fa-tooth"></i>
    </div>

    <div class="brand-text">

        <h2>Sunrise Dental</h2>

        <span>Clinic Management</span>

    </div>

</div>


<!-- NAVIGATION -->

<nav class="navigation">

    <a href="${pageContext.request.contextPath}/adminhomes.jsp">

        <i class="fa-solid fa-chart-line"></i>

        Dashboard

    </a>


    <a href="${pageContext.request.contextPath}/managePatients"
       class="active">

        <i class="fa-solid fa-user-group"></i>

        Patients

    </a>


    <a href="#">

        <i class="fa-solid fa-calendar-check"></i>

        Appointments

    </a>


    <a href="#">

        <i class="fa-solid fa-user-doctor"></i>

        Doctors

    </a>


    <a href="#">

        <i class="fa-solid fa-file-invoice-dollar"></i>

        Billing

    </a>

</nav>


<!-- ADMIN -->

<div class="admin-area">

    <div class="admin-icon">

        <i class="fa-solid fa-user-shield"></i>

    </div>

    <div class="admin-details">

        <strong>
            <%= session.getAttribute("loggedInAdmin") %>
        </strong>

        <span>Administrator</span>

    </div>

    <a href="${pageContext.request.contextPath}/logout"
       class="logout-btn"
       title="Logout">

        <i class="fa-solid fa-right-from-bracket"></i>

    </a>

</div>
```

</header>

<!-- =========================================================
     MAIN CONTENT
========================================================= -->

<main class="main-content">

```
<!-- PAGE HEADER -->

<section class="page-header">

    <div>

        <span class="page-label">
            PATIENT MANAGEMENT
        </span>

        <h1>
            Patients
        </h1>

        <p>
            View, search and manage registered patient records.
        </p>

    </div>


    <a href="${pageContext.request.contextPath}/ad_addpatients.jsp"
       class="add-patient-btn">

        <i class="fa-solid fa-user-plus"></i>

        Add Patient

    </a>

</section>



<!-- =====================================================
     SUMMARY
====================================================== -->

<section class="summary-grid">

    <div class="summary-card">

        <div class="summary-icon">

            <i class="fa-solid fa-users"></i>

        </div>

        <div class="summary-content">

            <span>Total Patients</span>

            <strong>
                <%= totalPatients %>
            </strong>

            <small>
                Registered patients
            </small>

        </div>

    </div>


    <div class="summary-card">

        <div class="summary-icon">

            <i class="fa-solid fa-user-check"></i>

        </div>

        <div class="summary-content">

            <span>Displayed Records</span>

            <strong>
                <%= patientList.size() %>
            </strong>

            <small>
                Current results
            </small>

        </div>

    </div>

</section>



<!-- =====================================================
     SEARCH
====================================================== -->

<section class="content-card search-card">

    <div class="section-heading">

        <div>

            <h2>
                Search Patients
            </h2>

            <p>
                Search using patient ID, name or contact number.
            </p>

        </div>

    </div>


    <form method="get"
          action="${pageContext.request.contextPath}/managePatients"
          class="search-form">


        <div class="search-input">

            <i class="fa-solid fa-magnifying-glass"></i>

            <input
                type="text"
                name="keyword"
                value="<%= keyword %>"
                placeholder="Search patient ID, name or contact number...">

        </div>


        <button type="submit"
                class="search-btn">

            <i class="fa-solid fa-magnifying-glass"></i>

            Search

        </button>


        <a href="${pageContext.request.contextPath}/managePatients"
           class="clear-btn">

            Clear

        </a>

    </form>

</section>



<!-- =====================================================
     PATIENT RECORDS
====================================================== -->

<section class="content-card patient-card">


    <div class="card-header">

        <div>

            <h2>
                Patient Records
            </h2>

            <p>
                Registered patient information
            </p>

        </div>


        <span class="record-count">

            <%= patientList.size() %> Records

        </span>

    </div>



    <!-- TABLE -->

    <div class="table-container">

        <table class="patient-table">


            <thead>

                <tr>

                    <th>ID</th>

                    <th>Patient</th>

                    <th>Address</th>

                    <th>Contact</th>

                    <th>Gender</th>

                    <th>Registered</th>

                    <th>Status</th>

                    <th>Actions</th>

                </tr>

            </thead>


            <tbody>


            <%
                if (patientList.isEmpty()) {
            %>


                <tr>

                    <td colspan="8"
                        class="no-data">

                        <div class="no-data-icon">

                            <i class="fa-solid fa-user-group"></i>

                        </div>

                        <strong>
                            No patients found
                        </strong>

                        <span>
                            No patient records match your search.
                        </span>

                    </td>

                </tr>


            <%
                } else {

                    for (patient pat : patientList) {

                        String patientName = pat.getP_name();

                        String firstLetter = "?";

                        if (patientName != null &&
                            !patientName.trim().isEmpty()) {

                            firstLetter =
                                patientName.trim()
                                          .substring(0, 1)
                                          .toUpperCase();
                        }

                        String status = pat.getStatus();

                        if (status == null ||
                            status.trim().isEmpty()) {

                            status = "Active";
                        }

                        String statusClass =
                            status.equalsIgnoreCase("Active")
                            ? "status-active"
                            : "status-inactive";
            %>


                <tr>


                    <!-- ID -->

                    <td>

                        <span class="patient-id">

                            #<%= pat.getP_id() %>

                        </span>

                    </td>



                    <!-- NAME -->

                    <td>

                        <div class="patient-name">

                            <div class="patient-avatar">

                                <%= firstLetter %>

                            </div>

                            <strong>

                                <%= pat.getP_name() %>

                            </strong>

                        </div>

                    </td>



                    <!-- ADDRESS -->

                    <td>

                        <span class="address-text">

                            <%= pat.getAddress() %>

                        </span>

                    </td>



                    <!-- CONTACT -->

                    <td>

                        <span class="contact-text">

                            <i class="fa-solid fa-phone"></i>

                            <%= pat.getC_number() %>

                        </span>

                    </td>



                    <!-- GENDER -->

                    <td>

                        <span class="gender-badge">

                            <%= pat.getGender() %>

                        </span>

                    </td>



                    <!-- DATE -->

                    <td>

                        <span class="date-text">

                            <%
                                if (pat.getRegister_datetime() != null) {
                            %>

                                <%= pat.getRegister_datetime() %>

                            <%
                                } else {
                            %>

                                -

                            <%
                                }
                            %>

                        </span>

                    </td>



                    <!-- STATUS -->

                    <td>

                        <span class="status-badge <%= statusClass %>">

                            <span class="status-dot"></span>

                            <%= status %>

                        </span>

                    </td>



                    <!-- ACTIONS -->

                    <td>

                        <div class="action-buttons">


                            <a href="#"
                               class="action-btn view-btn"
                               title="View Patient">

                                <i class="fa-solid fa-eye"></i>

                            </a>


                            <a href="#"
                               class="action-btn edit-btn"
                               title="Edit Patient">

                                <i class="fa-solid fa-pen"></i>

                            </a>


                            <a href="#"
                               class="action-btn delete-btn"
                               title="Delete Patient">

                                <i class="fa-solid fa-trash"></i>

                            </a>


                        </div>

                    </td>


                </tr>


            <%
                    }
                }
            %>


            </tbody>

        </table>

    </div>

</section>



<!-- =====================================================
     CLINIC INFORMATION
====================================================== -->

<section class="clinic-card">

    <div class="clinic-card-icon">

        <i class="fa-solid fa-tooth"></i>

    </div>


    <div class="clinic-card-text">

        <h3>
            Sunrise Dental Clinic
        </h3>

        <p>
            Professional dental care with modern treatments
            and patient-focused service.
        </p>

    </div>


    <span class="clinic-status">

        <i class="fa-solid fa-circle"></i>

        System Active

    </span>

</section>



<!-- FOOTER -->

<footer>

    <span>
        © 2026 Sunrise Dental Clinic. All Rights Reserved.
    </span>

    <span>
        Clinic Management System
    </span>

</footer>
```

</main>

<script>

    // Delete confirmation

    const deleteButtons =
        document.querySelectorAll(".delete-btn");

    deleteButtons.forEach(function(button) {

        button.addEventListener("click", function(event) {

            const confirmDelete =
                confirm(
                    "Are you sure you want to delete this patient?"
                );

            if (!confirmDelete) {

                event.preventDefault();

            }

        });

    });

</script>

</body>

</html>
