<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="model.appointment" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    /* =========================================================
       ADMIN LOGIN CHECK
    ========================================================= */

    if (session.getAttribute("loggedInAdmin") == null) {

        response.sendRedirect(
            request.getContextPath() + "/adminlogin.jsp"
        );

        return;
    }


    /* =========================================================
       GET APPOINTMENT DATA
    ========================================================= */

    List<appointment> appointments =
        (List<appointment>) request.getAttribute("appointments");


    /* =========================================================
       GUARD
       If page is opened directly, redirect to servlet
    ========================================================= */

    if (appointments == null) {

        response.sendRedirect(
            request.getContextPath() + "/manageAppointments"
        );

        return;
    }


    /* =========================================================
       DATE AND TIME FORMAT
    ========================================================= */

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy");

    SimpleDateFormat timeFormat =
        new SimpleDateFormat("hh:mm a");


    /* =========================================================
       TOTAL APPOINTMENTS
    ========================================================= */

    int totalAppointments =
        appointments != null ? appointments.size() : 0;

%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Appointments | Sunrise Dental Clinic
    </title>


    <!-- =====================================================
         CSS
    ====================================================== -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/adappointments.css">


    <!-- =====================================================
         FONT AWESOME
    ====================================================== -->

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

            <h2>
                Sunrise Dental
            </h2>

            <span>
                Clinic Management
            </span>

        </div>

    </div>



    <!-- =====================================================
         NAVIGATION
    ====================================================== -->

    <nav class="navigation">


        <!-- DASHBOARD -->

        <a href="${pageContext.request.contextPath}/adminhomes.jsp">

            <i class="fa-solid fa-chart-line"></i>

            Dashboard

        </a>



        <!-- PATIENTS -->

        <a href="${pageContext.request.contextPath}/managePatients">

            <i class="fa-solid fa-user-group"></i>

            Patients

        </a>



        <!-- APPOINTMENTS -->

        <a href="${pageContext.request.contextPath}/manageAppointments"
           class="active">

            <i class="fa-solid fa-calendar-check"></i>

            Appointments

        </a>



        <!-- BILLING -->

        <a href="${pageContext.request.contextPath}/adbilling.jsp">

            <i class="fa-solid fa-file-invoice-dollar"></i>

            Billing

        </a>



        <!-- HELP -->

        <a href="#">

            <i class="fa-solid fa-headphones"></i>

            Help & Support

        </a>

    </nav>



    <!-- =====================================================
         ADMIN AREA
    ====================================================== -->

    <div class="admin-area">


        <div class="admin-icon">

            <i class="fa-solid fa-user-shield"></i>

        </div>


        <div class="admin-details">

            <strong>

                <%= session.getAttribute("loggedInAdmin") %>

            </strong>

            <span>
                Administrator
            </span>

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

                APPOINTMENT MANAGEMENT

            </span>


            <h1>

                Appointments

            </h1>


            <p>

                View, manage and monitor all patient appointments.

            </p>

        </div>



        <!-- ADMIN INFORMATION -->

        <div class="header-user">


            <div class="header-user-icon">

                <i class="fa-solid fa-calendar-check"></i>

            </div>


            <div>

                <span>
                    Welcome back
                </span>

                <strong>

                    <%= session.getAttribute("loggedInAdmin") %>

                </strong>

            </div>

        </div>

    </section>



    <!-- =====================================================
         SUCCESS MESSAGE
    ====================================================== -->

    <% if (request.getAttribute("successMessage") != null) { %>

        <div class="alert success-alert">

            <i class="fa-solid fa-circle-check"></i>


            <span>

                <%= request.getAttribute("successMessage") %>

            </span>


            <button type="button"
                    onclick="this.parentElement.remove()">

                <i class="fa-solid fa-xmark"></i>

            </button>

        </div>

    <% } %>



    <!-- =====================================================
         ERROR MESSAGE
    ====================================================== -->

    <% if (request.getAttribute("errorMessage") != null) { %>

        <div class="alert error-alert">

            <i class="fa-solid fa-circle-exclamation"></i>


            <span>

                <%= request.getAttribute("errorMessage") %>

            </span>


            <button type="button"
                    onclick="this.parentElement.remove()">

                <i class="fa-solid fa-xmark"></i>

            </button>

        </div>

    <% } %>



    <!-- =====================================================
         APPOINTMENT SUMMARY
    ====================================================== -->

    <section class="summary-grid">


        <!-- TOTAL APPOINTMENTS -->

        <div class="summary-card">


            <div class="summary-icon">

                <i class="fa-solid fa-calendar-check"></i>

            </div>


            <div class="summary-content">

                <span>
                    Total Appointments
                </span>


                <strong>

                    <%= totalAppointments %>

                </strong>


                <small>

                    Registered appointments

                </small>

            </div>

        </div>



        <!-- APPOINTMENT STATUS -->

        <div class="summary-card">


            <div class="summary-icon">

                <i class="fa-solid fa-clock"></i>

            </div>


            <div class="summary-content">

                <span>
                    Appointment Status
                </span>


                <strong>
                    Active
                </strong>


                <small>

                    Clinic scheduling system

                </small>

            </div>

        </div>



        <!-- DENTAL SERVICES -->

        <div class="summary-card">


            <div class="summary-icon">

                <i class="fa-solid fa-user-doctor"></i>

            </div>


            <div class="summary-content">

                <span>
                    Dental Services
                </span>


                <strong>
                    Available
                </strong>


                <small>

                    Dentist appointment management

                </small>

            </div>

        </div>



        <!-- SYSTEM STATUS -->

        <div class="summary-card">


            <div class="summary-icon">

                <i class="fa-solid fa-shield-heart"></i>

            </div>


            <div class="summary-content">

                <span>
                    System Status
                </span>


                <strong>
                    Active
                </strong>


                <small>

                    Secure clinic management

                </small>

            </div>

        </div>

    </section>



    <!-- =====================================================
         APPOINTMENT TABLE CARD
    ====================================================== -->

    <section class="content-card">


        <!-- =================================================
             TABLE HEADER
        ================================================== -->

        <div class="table-header">


            <div class="section-heading">


                <span class="section-label">

                    APPOINTMENT RECORDS

                </span>


                <h2>

                    Manage Appointments

                </h2>


                <p>

                    Review patient appointment details and
                    perform management actions.

                </p>

            </div>



            <!-- HEADER ACTIONS -->

            <div class="header-actions">


                <!-- SEARCH -->

                <div class="search-box">

                    <i class="fa-solid fa-magnifying-glass"></i>


                    <input type="text"
                           id="appointmentSearch"
                           placeholder="Search appointments..."
                           onkeyup="searchAppointments()">

                </div>



                <!-- NEW APPOINTMENT -->

                <a href="${pageContext.request.contextPath}/addappointment"
                   class="add-btn">

                    <i class="fa-solid fa-calendar-plus"></i>

                    New Appointment

                </a>

            </div>

        </div>



        <!-- =================================================
             APPOINTMENT TABLE
        ================================================== -->

        <div class="table-container">


            <table class="appointment-table"
                   id="appointmentTable">


                <thead>

                    <tr>

                        <th>
                            #
                        </th>

                        <th>
                            Appointment
                        </th>

                        <th>
                            Patient
                        </th>

                        <th>
                            Contact
                        </th>

                        <th>
                            Dentist
                        </th>

                        <th>
                            Date & Time
                        </th>

                        <th>
                            Status
                        </th>

                        <th>
                            Actions
                        </th>

                    </tr>

                </thead>



                <tbody>


                <% if (appointments != null &&
                       !appointments.isEmpty()) { %>


                    <%

                        int rowNumber = 1;

                        for (appointment appt : appointments) {

                    %>


                    <tr>


                        <!-- =================================================
                             ROW NUMBER
                        ================================================== -->

                        <td>

                            <span class="row-number">

                                <%= rowNumber++ %>

                            </span>

                        </td>



                        <!-- =================================================
                             APPOINTMENT NUMBER
                        ================================================== -->

                        <td>

                            <div class="appointment-number">


                                <div class="appointment-icon">

                                    <i class="fa-solid fa-hashtag"></i>

                                </div>


                                <div>

                                    <strong>

                                        <%= appt.getAppointment_number() %>

                                    </strong>


                                    <small>

                                        ID:
                                        <%= appt.getAppointment_id() %>

                                    </small>

                                </div>

                            </div>

                        </td>



                        <!-- =================================================
                             PATIENT
                        ================================================== -->

                        <td>

                            <div class="patient-info">


                                <div class="patient-avatar">

                                    <i class="fa-solid fa-user"></i>

                                </div>


                                <div>

                                    <strong>

                                        <%= appt.getP_name() %>

                                    </strong>


                                    <small>

                                        Patient #
                                        <%= appt.getP_id() %>

                                    </small>

                                </div>

                            </div>

                        </td>



                        <!-- =================================================
                             CONTACT
                        ================================================== -->

                        <td>

                            <div class="contact-info">


                                <i class="fa-solid fa-phone"></i>


                                <span>

                                    <%= appt.getC_number() %>

                                </span>

                            </div>

                        </td>



                        <!-- =================================================
                             DENTIST
                        ================================================== -->

                        <td>

                            <div class="dentist-info">


                                <div class="dentist-icon">

                                    <i class="fa-solid fa-user-doctor"></i>

                                </div>


                                <span>

                                    Dentist #
                                    <%= appt.getD_id() %>

                                </span>

                            </div>

                        </td>



                        <!-- =================================================
                             DATE & TIME
                        ================================================== -->

                        <td>

                            <div class="datetime-info">


                                <strong>

                                    <%

                                        if (appt.getAppointment_datetime()
                                                != null) {

                                    %>

                                        <%= dateFormat.format(
                                            appt.getAppointment_datetime()
                                        ) %>

                                    <%

                                        }

                                    %>

                                </strong>


                                <span>


                                    <%

                                        if (appt.getAppointment_datetime()
                                                != null) {

                                    %>


                                        <i class="fa-regular fa-clock"></i>


                                        <%= timeFormat.format(
                                            appt.getAppointment_datetime()
                                        ) %>


                                    <%

                                        }

                                    %>

                                </span>

                            </div>

                        </td>



                        <!-- =================================================
                             STATUS
                        ================================================== -->

                        <td>


                            <%

                                String status = appt.getStatus();

                                String statusClass = "pending";


                                if ("Completed".equalsIgnoreCase(status)) {

                                    statusClass = "completed";

                                }

                                else if ("Cancelled"
                                            .equalsIgnoreCase(status)) {

                                    statusClass = "cancelled";

                                }

                                else if ("Confirmed"
                                            .equalsIgnoreCase(status)) {

                                    statusClass = "confirmed";

                                }

                            %>


                            <span class="status-badge <%= statusClass %>">


                                <i class="fa-solid fa-circle"></i>


                                <%= status != null
                                    ? status
                                    : "Pending" %>


                            </span>

                        </td>



                        <!-- =================================================
                             ACTIONS
                        ================================================== -->

                        <td>

                            <div class="action-buttons">


                                <!-- VIEW -->

                                <a href="${pageContext.request.contextPath}/viewAppointment?id=<%= appt.getAppointment_id() %>"
                                   class="action-btn view-btn"
                                   title="View Appointment">

                                    <i class="fa-solid fa-eye"></i>

                                </a>



                                <!-- EDIT -->

                                <a href="${pageContext.request.contextPath}/editAppointment?id=<%= appt.getAppointment_id() %>"
                                   class="action-btn edit-btn"
                                   title="Edit Appointment">

                                    <i class="fa-solid fa-pen"></i>

                                </a>



                                <!-- =================================================
                                     DELETE
                                ================================================== -->

                                <button type="button"
                                        class="action-btn delete-btn"
                                        title="Delete Appointment"
                                        onclick="deleteAppointment(
                                            <%= appt.getAppointment_id() %>,
                                            '<%= appt.getAppointment_number() %>'
                                        )">

                                    <i class="fa-solid fa-trash"></i>

                                </button>


                            </div>

                        </td>


                    </tr>


                    <%

                        }

                    %>


                <% } else { %>


                    <!-- =================================================
                         EMPTY STATE
                    ================================================== -->

                    <tr>

                        <td colspan="8">


                            <div class="empty-state">


                                <div class="empty-icon">

                                    <i class="fa-solid fa-calendar-xmark"></i>

                                </div>


                                <h3>

                                    No Appointments Found

                                </h3>


                                <p>

                                    There are currently no appointment
                                    records in the system.

                                </p>


                                <a href="${pageContext.request.contextPath}/addappointment"
                                   class="empty-btn">

                                    <i class="fa-solid fa-calendar-plus"></i>

                                    Create Appointment

                                </a>


                            </div>


                        </td>

                    </tr>


                <% } %>


                </tbody>

            </table>

        </div>



        <!-- =================================================
             TABLE FOOTER
        ================================================== -->

        <div class="table-footer">


            <span>

                Showing

                <strong id="visibleCount">

                    <%= totalAppointments %>

                </strong>

                appointment(s)

            </span>


            <span>

                Sunrise Dental Clinic

                <i class="fa-solid fa-tooth"></i>

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

                Sunrise Dental Clinic

            </h3>


            <p>

                Efficient appointment scheduling and
                patient-focused dental care management.

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

            © 2026 Sunrise Dental Clinic.
            All Rights Reserved.

        </span>


        <span>

            Clinic Management System

        </span>


    </footer>


</main>



<!-- =========================================================
     DELETE APPOINTMENT CONFIRMATION MODAL
========================================================= -->

<div id="deleteModal"
     class="modal-overlay">


    <div class="delete-modal">


        <!-- DELETE ICON -->

        <div class="delete-icon">

            <i class="fa-solid fa-trash"></i>

        </div>



        <!-- TITLE -->

        <h2>

            Delete Appointment?

        </h2>



        <!-- MESSAGE -->

        <p>

            Are you sure you want to delete appointment

            <strong id="appointmentNumber"></strong>?

            This action cannot be undone.

        </p>



        <!-- MODAL BUTTONS -->

        <div class="modal-buttons">


            <!-- CANCEL -->

            <button type="button"
                    onclick="closeModal()"
                    class="cancel-btn">

                Cancel

            </button>



            <!-- DELETE -->

            <a id="deleteLink"
               href="#"
               class="confirm-btn">

                Delete

            </a>


        </div>


    </div>

</div>



<!-- =========================================================
     JAVASCRIPT
========================================================= -->

<script>


/* =========================================================
   SEARCH APPOINTMENTS
========================================================= */

function searchAppointments() {

    const input =
        document.getElementById("appointmentSearch");

    const filter =
        input.value.toLowerCase();

    const table =
        document.getElementById("appointmentTable");

    const tbody =
        table.getElementsByTagName("tbody")[0];

    const rows =
        tbody.getElementsByTagName("tr");


    let visible = 0;


    for (let i = 0; i < rows.length; i++) {


        const row = rows[i];


        /*
         * Ignore empty-state row
         */

        if (row.cells.length < 8) {

            continue;

        }


        const text =
            row.textContent.toLowerCase();


        if (text.indexOf(filter) > -1) {

            row.style.display = "";

            visible++;

        }

        else {

            row.style.display = "none";

        }

    }


    document.getElementById("visibleCount")
            .textContent = visible;

}



/* =========================================================
   OPEN DELETE APPOINTMENT MODAL
========================================================= */

function deleteAppointment(id, appointmentNumber) {


    /*
     * Display appointment number
     */

    document.getElementById("appointmentNumber")
            .textContent = appointmentNumber;



    /*
     * Create delete URL
     */

    document.getElementById("deleteLink").href =
        "<%= request.getContextPath() %>/manageAppointments?action=delete&id="
        + id;



    /*
     * Show modal
     */

    document.getElementById("deleteModal")
            .classList.add("show");

}



/* =========================================================
   CLOSE DELETE MODAL
========================================================= */

function closeModal() {

    document.getElementById("deleteModal")
            .classList.remove("show");

}



/* =========================================================
   CLOSE MODAL WHEN CLICKING OUTSIDE
========================================================= */

document.getElementById("deleteModal")
        .addEventListener("click", function(event) {


    if (event.target === this) {

        closeModal();

    }

});



/* =========================================================
   CLOSE MODAL USING ESC KEY
========================================================= */

document.addEventListener("keydown", function(event) {


    if (event.key === "Escape") {

        closeModal();

    }

});


</script>


</body>

</html>