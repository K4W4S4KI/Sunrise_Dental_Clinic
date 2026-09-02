
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.patient" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    /* =========================================================
       ADMIN LOGIN CHECK
       ========================================================= */

    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/adlogin.jsp");
        return;
    }

    /* =========================================================
       GET DATA FROM managePatients SERVLET
       ========================================================= */

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

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a");

    String contextPath = request.getContextPath();

    /* =========================================================
       COUNT ACTIVE / INACTIVE
       ========================================================= */

    int activePatients = 0;
    int inactivePatients = 0;

    for (patient p : patientList) {

        if (p.getStatus() != null &&
            p.getStatus().equalsIgnoreCase("Active")) {

            activePatients++;

        } else {

            inactivePatients++;

        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Patients | Sunrise Dental Clinic</title>

    <!-- SAME DESIGN FAMILY AS ADMIN HOME -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/admpatients.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>


<body>


<!-- =========================================================
     TOP NAVBAR
========================================================= -->

<header class="top-navbar">


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


        <a href="${pageContext.request.contextPath}/adappointments.jsp">
        <i class="fa-solid fa-calendar-check"></i>
        Appointments
    </a>


                <a href="${pageContext.request.contextPath}/adbilling.jsp">
            <i class="fa-solid fa-file-invoice-dollar"></i>
            Billing
        </a>

        <a href="#">
            <i class="fa-solid fa-headphones"></i>
            Help & Support
        </a>

    </nav>


    <!-- ADMIN AREA -->

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

</header>



<!-- =========================================================
     MAIN CONTENT
========================================================= -->

<main class="main-content">


    <!-- =====================================================
         PAGE HEADER
    ====================================================== -->

    <section class="page-header">


        <div>

            <span class="page-label">
                PATIENT MANAGEMENT
            </span>

            <h1>Patients</h1>

            <p>
                View, search and manage registered patient records.
            </p>

        </div>


        <!-- ADMIN INFO -->

        <div class="header-user">

            <div class="header-user-icon">

                <i class="fa-solid fa-users"></i>

            </div>

            <div>

                <span>Total Patients</span>

                <strong>
                    <%= totalPatients %>
                </strong>

            </div>

        </div>

    </section>



    <!-- =====================================================
         PATIENT SUMMARY
    ====================================================== -->

    <section class="stats-grid">


        <!-- TOTAL -->

        <div class="stat-card">

            <div class="stat-icon">

                <i class="fa-solid fa-user-group"></i>

            </div>

            <div class="stat-content">

                <span>Total Patients</span>

                <strong>
                    <%= totalPatients %>
                </strong>

                <small>
                    Registered patients
                </small>

            </div>

        </div>


        <!-- ACTIVE -->

        <div class="stat-card">

            <div class="stat-icon">

                <i class="fa-solid fa-user-check"></i>

            </div>

            <div class="stat-content">

                <span>Active Patients</span>

                <strong>
                    <%= activePatients %>
                </strong>

                <small>
                    Currently active
                </small>

            </div>

        </div>


        <!-- INACTIVE -->

        <div class="stat-card">

            <div class="stat-icon">

                <i class="fa-solid fa-user-clock"></i>

            </div>

            <div class="stat-content">

                <span>Inactive Patients</span>

                <strong>
                    <%= inactivePatients %>
                </strong>

                <small>
                    Inactive records
                </small>

            </div>

        </div>

    </section>


    <section class="content-card">


        <!-- CARD HEADER -->

        <div class="section-heading patient-heading">


            <div>

                <h2>Patient Records</h2>

                <p>
                    Registered patients in Sunrise Dental Clinic
                </p>

            </div>


            <!-- ADD PATIENT -->

            <a href="<%= contextPath %>/adaddpatients.jsp"
               class="primary-btn">

                <i class="fa-solid fa-user-plus"></i>

                Add Patient

            </a>

        </div>



        <!-- =================================================
             SEARCH AREA
        ================================================== -->

        <form action="<%= contextPath %>/managePatients"
              method="get"
              class="search-area">


            <div class="search-box">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    name="keyword"
                    value="<%= keyword %>"
                    placeholder="Search by patient ID, name or contact number..."
                    autocomplete="off">

            </div>


            <button type="submit"
                    class="search-btn">

                <i class="fa-solid fa-magnifying-glass"></i>

                Search

            </button>


            <% if (!keyword.isEmpty()) { %>

                <a href="<%= contextPath %>/managePatients"
                   class="clear-btn">

                    <i class="fa-solid fa-xmark"></i>

                    Clear

                </a>

            <% } %>

        </form>



        <!-- SEARCH RESULT -->

        <% if (!keyword.isEmpty()) { %>

            <div class="search-message">

                <i class="fa-solid fa-circle-info"></i>

                Search results for

                <strong>
                    "<%= keyword %>"
                </strong>

                <span>
                    — <%= patientList.size() %> result(s)
                </span>

            </div>

        <% } %>



        <!-- =================================================
             PATIENT TABLE
        ================================================== -->

        <div class="table-wrapper">

            <table class="patient-table">


                <thead>

                    <tr>

                        <th>ID</th>

                        <th>Patient</th>

                        <th>Contact</th>

                        <th>Address</th>

                        <th>Gender</th>

                        <th>Registered</th>

                        <th>Status</th>

                        <th>Actions</th>

                    </tr>

                </thead>


                <tbody>


                <% if (patientList.isEmpty()) { %>


                    <!-- EMPTY -->

                    <tr>

                        <td colspan="8">

                            <div class="empty-state">

                                <div class="empty-icon">

                                    <i class="fa-solid fa-user-slash"></i>

                                </div>

                                <h3>No Patient Records Found</h3>

                                <p>

                                    <% if (!keyword.isEmpty()) { %>

                                        No patients matched your search.

                                    <% } else { %>

                                        No patients have been registered yet.

                                    <% } %>

                                </p>


                                <% if (!keyword.isEmpty()) { %>

                                    <a href="<%= contextPath %>/managePatients"
                                       class="empty-btn">

                                        View All Patients

                                    </a>

                                <% } else { %>

                                    <a href="<%= contextPath %>/addpatient.jsp"
                                       class="empty-btn">

                                        <i class="fa-solid fa-user-plus"></i>

                                        Register Patient

                                    </a>

                                <% } %>

                            </div>

                        </td>

                    </tr>


                <% } else { %>


                    <% for (patient p : patientList) { %>


                        <tr>


                            <!-- ID -->

                            <td>

                                <span class="patient-id">

                                    #<%= p.getP_id() %>

                                </span>

                            </td>



                            <!-- NAME -->

                            <td>

                                <div class="patient-info">

                                    <div class="patient-avatar">

                                        <%= p.getP_name() != null &&
                                            !p.getP_name().isEmpty()
                                            ? p.getP_name()
                                                .substring(0,1)
                                                .toUpperCase()
                                            : "P" %>

                                    </div>


                                    <div>

                                        <strong>

                                            <%= p.getP_name() != null
                                                ? p.getP_name()
                                                : "-" %>

                                        </strong>

                                        <span>
                                            Patient
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <!-- CONTACT -->

                            <td>

                                <div class="contact-info">

                                    <i class="fa-solid fa-phone"></i>

                                    <span>

                                        <%= p.getC_number() != null
                                            ? p.getC_number()
                                            : "-" %>

                                    </span>

                                </div>

                            </td>



                            <!-- ADDRESS -->

                            <td>

                                <div class="address-info">

                                    <i class="fa-solid fa-location-dot"></i>

                                    <span title="<%= p.getAddress() != null
                                        ? p.getAddress()
                                        : "-" %>">

                                        <%= p.getAddress() != null
                                            ? p.getAddress()
                                            : "-" %>

                                    </span>

                                </div>

                            </td>



                            <!-- GENDER -->

                            <td>

                                <span class="gender">

                                    <% if ("Male".equalsIgnoreCase(
                                            p.getGender())) { %>

                                        <i class="fa-solid fa-mars"></i>

                                    <% } else if ("Female".equalsIgnoreCase(
                                            p.getGender())) { %>

                                        <i class="fa-solid fa-venus"></i>

                                    <% } else { %>

                                        <i class="fa-solid fa-user"></i>

                                    <% } %>


                                    <%= p.getGender() != null
                                        ? p.getGender()
                                        : "-" %>

                                </span>

                            </td>



                            <!-- DATE -->

                            <td>

                                <span class="register-date">

                                    <i class="fa-regular fa-calendar"></i>

                                    <%= p.getRegister_datetime() != null
                                        ? dateFormat.format(
                                            p.getRegister_datetime())
                                        : "-" %>

                                </span>

                            </td>



                            <!-- STATUS -->

                            <td>

                                <%
                                    String status = p.getStatus();

                                    if (status == null ||
                                        status.trim().isEmpty()) {

                                        status = "Active";
                                    }

                                    if (status.equalsIgnoreCase("Active")) {
                                %>

                                    <span class="status active">

                                        <i class="fa-solid fa-circle"></i>

                                        Active

                                    </span>

                                <%
                                    } else {
                                %>

                                    <span class="status inactive">

                                        <i class="fa-solid fa-circle"></i>

                                        <%= status %>

                                    </span>

                                <%
                                    }
                                %>

                            </td>



                            <!-- ACTIONS -->

                            <td>

                                <div class="actions">


                                    <!-- VIEW -->

                                    <a href="<%= contextPath %>/viewPatient?id=<%= p.getP_id() %>"
                                       class="action-btn view"
                                       title="View Patient">

                                        <i class="fa-solid fa-eye"></i>

                                    </a>


                                    <!-- EDIT -->

                                    <a href="<%= contextPath %>/updatePatients?id=<%= p.getP_id() %>"
                                        class="action-btn edit"
                                        title="Edit Patient">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>


                                    <!-- DELETE -->

                                    <button type="button"
        class="action-btn delete"
        title="Delete Patient"
        onclick="deletePatient(<%= p.getP_id() %>)">
    <i class="fa-solid fa-trash"></i>
</button>

                                </div>

                            </td>


                        </tr>


                    <% } %>


                <% } %>


                </tbody>

            </table>

        </div>



        <!-- =================================================
             CARD FOOTER
        ================================================== -->

        <div class="table-footer">

            <span>

                Showing

                <strong>
                    <%= patientList.size() %>
                </strong>

                patient record(s)

            </span>


            <span>

                <i class="fa-solid fa-shield-halved"></i>

                Patient information is securely managed

            </span>

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
                Patient Management System
            </h3>

            <p>
                Maintain accurate patient records and provide
                efficient dental clinic services.
            </p>

        </div>


        <span class="clinic-status">

            <i class="fa-solid fa-circle"></i>

            System Active

        </span>

    </section>



    <!-- =====================================================
         FOOTER
    ====================================================== -->

    <footer>

        <span>
            © 2026 Sunrise Dental Clinic. All Rights Reserved.
        </span>

        <span>
            Clinic Management System
        </span>

    </footer>


</main>



<!-- =========================================================
     DELETE CONFIRMATION
========================================================= -->

<div id="deleteModal"
     class="modal-overlay">


    <div class="delete-modal">


        <div class="delete-icon">

            <i class="fa-solid fa-trash"></i>

        </div>


        <h2>
            Delete Patient?
        </h2>


        <p>
            Are you sure you want to delete this patient record?
            This action cannot be undone.
        </p>


        <div class="modal-buttons">

            <button type="button"
                    onclick="closeModal()"
                    class="cancel-btn">

                Cancel

            </button>


            <a id="deleteLink"
               href="#"
               class="confirm-btn">

                Delete

            </a>

        </div>

    </div>

</div>



<script>

function deletePatient(id) {

    document.getElementById("deleteLink").href =
        "<%= contextPath %>/deletePatient?id=" + id;

    document.getElementById("deleteModal")
            .classList.add("show");
}


function closeModal() {

    document.getElementById("deleteModal")
            .classList.remove("show");
}


document.getElementById("deleteModal")
        .addEventListener("click", function(event) {

    if (event.target === this) {
        closeModal();
    }

});

</script>

</body>
</html>

