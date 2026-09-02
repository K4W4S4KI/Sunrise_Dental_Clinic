<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="model.patient" %>

<%
    // =========================================================
    // ADMIN LOGIN CHECK
    // =========================================================

    if (session.getAttribute("loggedInAdmin") == null) {

        response.sendRedirect(
            request.getContextPath() + "/adlogin.jsp"
        );

        return;
    }


    // =========================================================
    // GET PATIENT OBJECT
    // =========================================================

    patient pat = (patient) request.getAttribute("patient");

    if (pat == null) {

        response.sendRedirect(
            request.getContextPath() + "/managePatients"
        );

        return;
    }


    // =========================================================
    // ALERT MESSAGES
    // =========================================================

    String error =
        (String) session.getAttribute("error");

    String success =
        (String) session.getAttribute("success");

    session.removeAttribute("error");
    session.removeAttribute("success");
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


    <!-- =====================================================
         VIEW PATIENT CSS
    ====================================================== -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/adviewpatient.css">


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

        <a href="${pageContext.request.contextPath}/helpsupport.jsp">
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


        <a href="#" class="logout-btn" title="Logout" onclick="confirmLogout(event)">
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
                View complete information about the selected patient.
            </p>

        </div>



        <!-- HEADER USER -->

        <div class="header-user">


            <div class="header-user-icon">

                <i class="fa-solid fa-user-doctor"></i>

            </div>


            <div>

                <span>Welcome back</span>

                <strong>
                    <%= session.getAttribute("loggedInAdmin") %>
                </strong>

            </div>

        </div>

    </section>



    <!-- =====================================================
         ERROR ALERT
    ====================================================== -->

    <% if (error != null) { %>

        <div class="alert alert-error">


            <div class="alert-icon">

                <i class="fa-solid fa-circle-exclamation"></i>

            </div>


            <div>

                <strong>
                    Unable to complete request
                </strong>

                <span>
                    <%= error %>
                </span>

            </div>


            <button type="button"
                    class="alert-close"
                    onclick="this.parentElement.remove();">

                <i class="fa-solid fa-xmark"></i>

            </button>

        </div>

    <% } %>



    <!-- =====================================================
         SUCCESS ALERT
    ====================================================== -->

    <% if (success != null) { %>

        <div class="alert alert-success">


            <div class="alert-icon">

                <i class="fa-solid fa-circle-check"></i>

            </div>


            <div>

                <strong>
                    Success
                </strong>

                <span>
                    <%= success %>
                </span>

            </div>


            <button type="button"
                    class="alert-close"
                    onclick="this.parentElement.remove();">

                <i class="fa-solid fa-xmark"></i>

            </button>

        </div>

    <% } %>



    <!-- =====================================================
         PATIENT PROFILE CARD
    ====================================================== -->

    <section class="patient-card">


        <!-- =================================================
             CARD HEADER
        ================================================== -->

        <div class="patient-card-header">


            <div class="patient-title-area">


                <div class="patient-main-icon">

                    <i class="fa-solid fa-user"></i>

                </div>


                <div>

                    <span class="section-label">
                        PATIENT PROFILE
                    </span>

                    <h2>
                        Patient Information
                    </h2>

                    <p>
                        Personal and registration details
                    </p>

                </div>

            </div>



            <!-- PATIENT ID -->

            <div class="patient-id">

                <span>Patient ID</span>

                <strong>
                    #<%= pat.getP_id() %>
                </strong>

            </div>

        </div>



        <!-- =================================================
             PATIENT BODY
        ================================================== -->

        <div class="patient-body">


            <!-- =================================================
                 PROFILE SUMMARY
            ================================================== -->

            <div class="profile-summary">


                <div class="profile-avatar">

                    <i class="fa-solid fa-user"></i>

                </div>


                <div class="profile-name">

                    <h2>
                        <%= pat.getP_name() != null
                            ? pat.getP_name()
                            : "N/A" %>
                    </h2>


                    <span>
                        Patient
                    </span>

                </div>


                <!-- STATUS -->

                <div class="status-area">

                    <span class="status-label">
                        Current Status
                    </span>


                    <%
                        String patientStatus = pat.getStatus();

                        if ("Active".equalsIgnoreCase(patientStatus)) {
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

                            <%= patientStatus != null
                                ? patientStatus
                                : "Inactive" %>

                        </span>

                    <%
                        }
                    %>

                </div>

            </div>



            <!-- =================================================
                 INFORMATION GRID
            ================================================== -->

            <div class="information-grid">


                <!-- PATIENT NAME -->

                <div class="detail-item">


                    <div class="detail-icon">

                        <i class="fa-solid fa-user"></i>

                    </div>


                    <div class="detail-content">

                        <span>
                            Patient Name
                        </span>

                        <strong>

                            <%= pat.getP_name() != null
                                ? pat.getP_name()
                                : "Not available" %>

                        </strong>

                    </div>

                </div>



                <!-- CONTACT NUMBER -->

                <div class="detail-item">


                    <div class="detail-icon">

                        <i class="fa-solid fa-phone"></i>

                    </div>


                    <div class="detail-content">

                        <span>
                            Contact Number
                        </span>

                        <strong>

                            <%= pat.getC_number() != null
                                ? pat.getC_number()
                                : "Not available" %>

                        </strong>

                    </div>

                </div>



                <!-- GENDER -->

                <div class="detail-item">


                    <div class="detail-icon">

                        <i class="fa-solid fa-venus-mars"></i>

                    </div>


                    <div class="detail-content">

                        <span>
                            Gender
                        </span>

                        <strong>

                            <%= pat.getGender() != null
                                ? pat.getGender()
                                : "Not available" %>

                        </strong>

                    </div>

                </div>



                <!-- REGISTERED DATE -->

                <div class="detail-item">


                    <div class="detail-icon">

                        <i class="fa-solid fa-calendar-days"></i>

                    </div>


                    <div class="detail-content">

                        <span>
                            Registered Date
                        </span>

                        <strong>

                            <%= pat.getRegister_datetime() != null
                                ? pat.getRegister_datetime()
                                : "Not available" %>

                        </strong>

                    </div>

                </div>



                <!-- ADDRESS -->

                <div class="detail-item address-item">


                    <div class="detail-icon">

                        <i class="fa-solid fa-location-dot"></i>

                    </div>


                    <div class="detail-content">

                        <span>
                            Residential Address
                        </span>

                        <strong>

                            <%= pat.getAddress() != null
                                ? pat.getAddress()
                                : "Not available" %>

                        </strong>

                    </div>

                </div>


            </div>

        </div>



        <!-- =================================================
             CARD ACTIONS
        ================================================== -->

        <div class="patient-actions">


            <a href="${pageContext.request.contextPath}/managePatients"
               class="secondary-btn">

                <i class="fa-solid fa-arrow-left"></i>

                Back to Patients

            </a>


            <a href="${pageContext.request.contextPath}/updatePatients?p_id=<%= pat.getP_id() %>"
               class="primary-btn">

                <i class="fa-solid fa-user-pen"></i>

                Edit Patient

            </a>

        </div>

    </section>



    <!-- =====================================================
         QUICK INFORMATION CARDS
    ====================================================== -->

    <section class="quick-info-grid">


        <!-- RECORD STATUS -->

        <div class="quick-card">


            <div class="quick-icon">

                <i class="fa-solid fa-file-circle-check"></i>

            </div>


            <div>

                <span>
                    Record Status
                </span>

                <strong>
                    <%= pat.getStatus() != null
                        ? pat.getStatus()
                        : "N/A" %>
                </strong>

            </div>

        </div>



        <!-- CONTACT -->

        <div class="quick-card">


            <div class="quick-icon">

                <i class="fa-solid fa-phone-volume"></i>

            </div>


            <div>

                <span>
                    Contact
                </span>

                <strong>
                    <%= pat.getC_number() != null
                        ? pat.getC_number()
                        : "N/A" %>
                </strong>

            </div>

        </div>



        <!-- GENDER -->

        <div class="quick-card">


            <div class="quick-icon">

                <i class="fa-solid fa-person"></i>

            </div>


            <div>

                <span>
                    Gender
                </span>

                <strong>
                    <%= pat.getGender() != null
                        ? pat.getGender()
                        : "N/A" %>
                </strong>

            </div>

        </div>



        <!-- PATIENT ID -->

        <div class="quick-card">


            <div class="quick-icon">

                <i class="fa-solid fa-id-card"></i>

            </div>


            <div>

                <span>
                    Patient ID
                </span>

                <strong>
                    #<%= pat.getP_id() %>
                </strong>

            </div>

        </div>

    </section>



    <!-- =====================================================
         PRIVACY INFORMATION
    ====================================================== -->

    <section class="info-card">


        <div class="info-icon">

            <i class="fa-solid fa-shield-heart"></i>

        </div>


        <div class="info-content">

            <h3>
                Patient Information & Privacy
            </h3>

            <p>

                Patient information is confidential and should
                only be accessed by authorized clinic staff.
                Please ensure that all patient records are
                handled securely and responsibly.

            </p>

        </div>


        <div class="info-badge">

            <i class="fa-solid fa-lock"></i>

            Secure Record

        </div>

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

    <script>
function confirmLogout(event) {
    event.preventDefault();

    const confirmLogout = confirm("Are you sure you want to logout?");

    if (confirmLogout) {
        window.location.href = "<%= request.getContextPath() %>/logout";
    }
}
</script>
</main>

</body>

</html>