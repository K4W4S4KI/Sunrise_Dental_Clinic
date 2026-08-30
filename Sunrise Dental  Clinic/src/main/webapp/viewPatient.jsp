<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.patient" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    /* =========================================================
       ADMIN LOGIN CHECK
    ========================================================= */

    if (session.getAttribute("loggedInAdmin") == null) {

        response.sendRedirect(
            request.getContextPath() + "/adlogin.jsp"
        );

        return;
    }

    /* =========================================================
       GET PATIENT DATA
    ========================================================= */

    patient pat =
        (patient) request.getAttribute("patient");

    if (pat == null) {

        response.sendRedirect(
            request.getContextPath() + "/managePatients"
        );

        return;
    }

    String contextPath = request.getContextPath();

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a");

    /* =========================================================
       PATIENT DATA
    ========================================================= */

    String patientName =
        pat.getP_name() != null &&
        !pat.getP_name().trim().isEmpty()
        ? pat.getP_name()
        : "Unknown Patient";

    String address =
        pat.getAddress() != null &&
        !pat.getAddress().trim().isEmpty()
        ? pat.getAddress()
        : "Not provided";

    String contact =
        pat.getC_number() != null &&
        !pat.getC_number().trim().isEmpty()
        ? pat.getC_number()
        : "Not provided";

    String gender =
        pat.getGender() != null &&
        !pat.getGender().trim().isEmpty()
        ? pat.getGender()
        : "Not specified";

    String status =
        pat.getStatus() != null &&
        !pat.getStatus().trim().isEmpty()
        ? pat.getStatus()
        : "Active";

    String registeredDate =
        pat.getRegister_datetime() != null
        ? dateFormat.format(
            pat.getRegister_datetime()
          )
        : "Not available";

    String initial =
        patientName.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        View Patient | Sunrise Dental Clinic
    </title>

    <!-- PAGE CSS -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/viewPatient.css">

    <!-- FONT AWESOME -->

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

            <h1>

                Patient Details

            </h1>

            <p>

                View complete information about the
                selected patient.

            </p>

        </div>


        <!-- HEADER USER -->

        <div class="header-user">

            <div class="header-user-icon">

                <i class="fa-solid fa-user"></i>

            </div>

            <div>

                <span>Patient ID</span>

                <strong>

                    #<%= pat.getP_id() %>

                </strong>

            </div>

        </div>

    </section>


    <!-- =====================================================
         BREADCRUMB
    ====================================================== -->

    <div class="breadcrumb">

        <a href="${pageContext.request.contextPath}/managePatients">

            <i class="fa-solid fa-users"></i>

            Patients

        </a>

        <i class="fa-solid fa-chevron-right"></i>

        <span>

            View Patient

        </span>

    </div>


    <!-- =====================================================
         PATIENT PROFILE CARD
    ====================================================== -->

    <section class="patient-profile-card">


        <!-- PROFILE TOP -->

        <div class="profile-top">


            <div class="profile-avatar">

                <%= initial %>

            </div>


            <div class="profile-main">

                <span class="profile-label">

                    PATIENT PROFILE

                </span>

                <h2>

                    <%= patientName %>

                </h2>

                <p>

                    <i class="fa-solid fa-id-card"></i>

                    Patient ID:

                    <strong>

                        #<%= pat.getP_id() %>

                    </strong>

                </p>

            </div>


            <!-- STATUS -->

            <div class="profile-status">

                <%
                    if ("Active".equalsIgnoreCase(status)) {
                %>

                    <span class="status-badge active">

                        <i class="fa-solid fa-circle"></i>

                        Active

                    </span>

                <%
                    } else {
                %>

                    <span class="status-badge inactive">

                        <i class="fa-solid fa-circle"></i>

                        <%= status %>

                    </span>

                <%
                    }
                %>

            </div>

        </div>


        <!-- DIVIDER -->

        <div class="profile-divider"></div>


        <!-- =================================================
             PATIENT INFORMATION
        ================================================== -->

        <div class="information-section">


            <div class="section-title">

                <div class="section-title-icon">

                    <i class="fa-solid fa-address-card"></i>

                </div>

                <div>

                    <h3>

                        Personal Information

                    </h3>

                    <p>

                        Basic details of the registered patient

                    </p>

                </div>

            </div>


            <!-- INFORMATION GRID -->

            <div class="details-grid">


                <!-- PATIENT NAME -->

                <div class="detail-item">

                    <div class="detail-icon">

                        <i class="fa-solid fa-user"></i>

                    </div>

                    <div class="detail-content">

                        <span>Full Name</span>

                        <strong>

                            <%= patientName %>

                        </strong>

                    </div>

                </div>


                <!-- PATIENT ID -->

                <div class="detail-item">

                    <div class="detail-icon">

                        <i class="fa-solid fa-hashtag"></i>

                    </div>

                    <div class="detail-content">

                        <span>Patient ID</span>

                        <strong>

                            #<%= pat.getP_id() %>

                        </strong>

                    </div>

                </div>


                <!-- CONTACT -->

                <div class="detail-item">

                    <div class="detail-icon">

                        <i class="fa-solid fa-phone"></i>

                    </div>

                    <div class="detail-content">

                        <span>Contact Number</span>

                        <strong>

                            <%= contact %>

                        </strong>

                    </div>

                </div>


                <!-- GENDER -->

                <div class="detail-item">

                    <div class="detail-icon">

                        <%
                            if ("Male".equalsIgnoreCase(gender)) {
                        %>

                            <i class="fa-solid fa-mars"></i>

                        <%
                            } else if ("Female".equalsIgnoreCase(gender)) {
                        %>

                            <i class="fa-solid fa-venus"></i>

                        <%
                            } else {
                        %>

                            <i class="fa-solid fa-user"></i>

                        <%
                            }
                        %>

                    </div>

                    <div class="detail-content">

                        <span>Gender</span>

                        <strong>

                            <%= gender %>

                        </strong>

                    </div>

                </div>


                <!-- ADDRESS -->

                <div class="detail-item full-width">

                    <div class="detail-icon">

                        <i class="fa-solid fa-location-dot"></i>

                    </div>

                    <div class="detail-content">

                        <span>Address</span>

                        <strong>

                            <%= address %>

                        </strong>

                    </div>

                </div>


                <!-- REGISTERED DATE -->

                <div class="detail-item">

                    <div class="detail-icon">

                        <i class="fa-regular fa-calendar"></i>

                    </div>

                    <div class="detail-content">

                        <span>Registered Date</span>

                        <strong>

                            <%= registeredDate %>

                        </strong>

                    </div>

                </div>


                <!-- ACCOUNT STATUS -->

                <div class="detail-item">

                    <div class="detail-icon">

                        <i class="fa-solid fa-circle-check"></i>

                    </div>

                    <div class="detail-content">

                        <span>Account Status</span>

                        <strong class="status-text">

                            <%= status %>

                        </strong>

                    </div>

                </div>

            </div>

        </div>


        <!-- =================================================
             SECURITY INFORMATION
        ================================================== -->

        <div class="security-box">

            <div class="security-icon">

                <i class="fa-solid fa-shield-halved"></i>

            </div>

            <div class="security-text">

                <strong>

                    Patient Information Secure

                </strong>

                <span>

                    This patient information is securely
                    managed by Sunrise Dental Clinic.

                </span>

            </div>

        </div>


        <!-- =================================================
             ACTION BUTTONS
        ================================================== -->

        <div class="profile-actions">

            <a href="${contextPath}/managePatients"
               class="back-btn">

                <i class="fa-solid fa-arrow-left"></i>

                Back to Patients

            </a>


            <a href="${contextPath}/updatePatients?id=<%= pat.getP_id() %>"
               class="edit-btn">

                <i class="fa-solid fa-pen"></i>

                Edit Patient

            </a>

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

                Maintain accurate patient records and
                provide efficient dental clinic services.

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

</body>

</html>