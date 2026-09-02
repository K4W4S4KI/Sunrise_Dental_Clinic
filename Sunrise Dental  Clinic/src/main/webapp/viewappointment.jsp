<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.appointment" %>
<%@ page import="model.dentist" %>
<%@ page import="model.treatment" %>

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
// GET APPOINTMENT DATA
// =========================================================
appointment appt =
    (appointment) request.getAttribute("appt");

dentist d =
    (dentist) request.getAttribute("dentist");

List<treatment> treatments =
    (List<treatment>) request.getAttribute("treatments");

BigDecimal billTotal =
    (BigDecimal) request.getAttribute("billTotal");

BigDecimal consultationFee =
    (BigDecimal) request.getAttribute("consultationFee");

// =========================================================
// VALIDATE APPOINTMENT
// =========================================================
if (appt == null) {
    response.sendRedirect(
        request.getContextPath() + "/manageAppointments"
    );
    return;
}

// =========================================================
// DATE FORMATS
// =========================================================
SimpleDateFormat dateFormat =
    new SimpleDateFormat("dd MMM yyyy");

SimpleDateFormat timeFormat =
    new SimpleDateFormat("hh:mm a");

// =========================================================
// SAFE BILL VALUES
// =========================================================
if (consultationFee == null) {
    consultationFee = BigDecimal.ZERO;
}

if (billTotal == null) {
    billTotal = consultationFee;
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

// =========================================================
// APPOINTMENT STATUS
// =========================================================
String appointmentStatus = appt.getStatus();

if (appointmentStatus == null ||
    appointmentStatus.trim().isEmpty()) {

    appointmentStatus = "Pending";
}


%>

<!DOCTYPE html>

<html lang="en">

<head>


<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    View Appointment | Sunrise Dental Clinic
</title>

<!-- =====================================================
     VIEW APPOINTMENT CSS
====================================================== -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/CSS/adviewappointment.css">

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


    <a href="${pageContext.request.contextPath}/managePatients">

        <i class="fa-solid fa-user-group"></i>

        Patients

    </a>


    <a href="${pageContext.request.contextPath}/manageAppointments"
       class="active">

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
            Appointment Details
        </h1>

        <p>
            View complete information about the selected appointment.
        </p>

    </div>


    <!-- HEADER USER -->

    <div class="header-user">

        <div class="header-user-icon">

            <i class="fa-solid fa-user-doctor"></i>

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
     APPOINTMENT CARD
====================================================== -->

<section class="appointment-card">


    <!-- =================================================
         CARD HEADER
    ================================================== -->

    <div class="appointment-card-header">

        <div class="appointment-title-area">

            <div class="appointment-main-icon">

                <i class="fa-solid fa-calendar-check"></i>

            </div>

            <div>

                <span class="section-label">
                    APPOINTMENT PROFILE
                </span>

                <h2>
                    Appointment Information
                </h2>

                <p>
                    Complete appointment and treatment details
                </p>

            </div>

        </div>


        <!-- APPOINTMENT NUMBER -->

        <div class="appointment-number">

            <span>
                Appointment No.
            </span>

            <strong>
                #<%= appt.getAppointment_number() %>
            </strong>

        </div>

    </div>


    <!-- =================================================
         APPOINTMENT BODY
    ================================================== -->

    <div class="appointment-body">


        <!-- =================================================
             PROFILE SUMMARY
        ================================================== -->

        <div class="profile-summary">

            <div class="profile-avatar">

                <i class="fa-solid fa-calendar-days"></i>

            </div>


            <div class="profile-name">

                <h2>
                    <%= appt.getP_name() != null
                        ? appt.getP_name()
                        : "N/A" %>
                </h2>

                <span>
                    Patient Appointment
                </span>

            </div>


            <!-- STATUS -->

            <div class="status-area">

                <span class="status-label">
                    Appointment Status
                </span>

                <%
                    if ("Active".equalsIgnoreCase(appointmentStatus)
                        || "Confirmed".equalsIgnoreCase(appointmentStatus)
                        || "Completed".equalsIgnoreCase(appointmentStatus)) {
                %>

                    <span class="status-badge active">

                        <i class="fa-solid fa-circle"></i>

                        <%= appointmentStatus %>

                    </span>

                <%
                    } else if ("Cancelled".equalsIgnoreCase(appointmentStatus)
                               || "Inactive".equalsIgnoreCase(appointmentStatus)) {
                %>

                    <span class="status-badge inactive">

                        <i class="fa-solid fa-circle"></i>

                        <%= appointmentStatus %>

                    </span>

                <%
                    } else {
                %>

                    <span class="status-badge pending">

                        <i class="fa-solid fa-circle"></i>

                        <%= appointmentStatus %>

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
                        <%= appt.getP_name() != null
                            ? appt.getP_name()
                            : "Not available" %>
                    </strong>

                </div>

            </div>


            <!-- CONTACT -->

            <div class="detail-item">

                <div class="detail-icon">

                    <i class="fa-solid fa-phone"></i>

                </div>

                <div class="detail-content">

                    <span>
                        Contact Number
                    </span>

                    <strong>
                        <%= appt.getC_number() != null
                            ? appt.getC_number()
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
                        <%= appt.getGender() != null
                            ? appt.getGender()
                            : "Not available" %>
                    </strong>

                </div>

            </div>


            <!-- DENTIST -->

            <div class="detail-item">

                <div class="detail-icon">

                    <i class="fa-solid fa-user-doctor"></i>

                </div>

                <div class="detail-content">

                    <span>
                        Dentist
                    </span>

                    <strong>

                        <%= d != null
                            ? "Dr. " + d.getDentist_name()
                            : "Dentist #" + appt.getD_id() %>

                    </strong>

                </div>

            </div>


            <!-- SPECIALIZATION -->

            <div class="detail-item">

                <div class="detail-icon">

                    <i class="fa-solid fa-stethoscope"></i>

                </div>

                <div class="detail-content">

                    <span>
                        Specialization
                    </span>

                    <strong>

                        <%= d != null &&
                            d.getSpecialization() != null
                            ? d.getSpecialization()
                            : "Not available" %>

                    </strong>

                </div>

            </div>


            <!-- APPOINTMENT DATE -->

            <div class="detail-item">

                <div class="detail-icon">

                    <i class="fa-solid fa-calendar-days"></i>

                </div>

                <div class="detail-content">

                    <span>
                        Appointment Date
                    </span>

                    <strong>

                        <%= appt.getAppointment_datetime() != null
                            ? dateFormat.format(
                                appt.getAppointment_datetime()
                              )
                            : "Not available" %>

                    </strong>

                </div>

            </div>


            <!-- APPOINTMENT TIME -->

            <div class="detail-item">

                <div class="detail-icon">

                    <i class="fa-solid fa-clock"></i>

                </div>

                <div class="detail-content">

                    <span>
                        Appointment Time
                    </span>

                    <strong>

                        <%= appt.getAppointment_datetime() != null
                            ? timeFormat.format(
                                appt.getAppointment_datetime()
                              )
                            : "Not available" %>

                    </strong>

                </div>

            </div>


            <!-- STATUS -->

            <div class="detail-item">

                <div class="detail-icon">

                    <i class="fa-solid fa-circle-check"></i>

                </div>

                <div class="detail-content">

                    <span>
                        Status
                    </span>

                    <strong>
                        <%= appointmentStatus %>
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

                        <%= appt.getAddress() != null
                            ? appt.getAddress()
                            : "Not available" %>

                    </strong>

                </div>

            </div>

        </div>

    </div>


    <!-- =================================================
         CARD ACTIONS
    ================================================== -->

    <div class="appointment-actions">

        <a href="${pageContext.request.contextPath}/manageAppointments"
           class="secondary-btn">

            <i class="fa-solid fa-arrow-left"></i>

            Back to Appointments

        </a>


        <a href="${pageContext.request.contextPath}/editAppointment?id=<%= appt.getAppointment_id() %>"
           class="primary-btn">

            <i class="fa-solid fa-calendar-pen"></i>

            Edit Appointment

        </a>

    </div>

</section>


<!-- =====================================================
     TREATMENT & BILLING CARD
====================================================== -->

<section class="billing-card">


    <div class="billing-header">

        <div class="billing-title">

            <div class="billing-icon">

                <i class="fa-solid fa-file-invoice-dollar"></i>

            </div>

            <div>

                <span class="section-label">
                    BILLING INFORMATION
                </span>

                <h2>
                    Treatment & Charges
                </h2>

                <p>
                    Treatment details and appointment billing summary
                </p>

            </div>

        </div>

    </div>


    <div class="billing-body">

        <div class="table-wrapper">

            <table class="treatment-table">

                <thead>

                    <tr>

                        <th>
                            Treatment
                        </th>

                        <th class="price-column">
                            Price (LKR)
                        </th>

                    </tr>

                </thead>

                <tbody>

                    <% if (treatments != null &&
                           !treatments.isEmpty()) {

                        for (treatment t : treatments) {
                    %>

                        <tr>

                            <td>

                                <div class="treatment-name">

                                    <div class="treatment-icon">

                                        <i class="fa-solid fa-tooth"></i>

                                    </div>

                                    <span>
                                        <%= t.getTreatment_name() %>
                                    </span>

                                </div>

                            </td>

                            <td class="price-column">

                                LKR
                                <%= String.format(
                                    "%,.2f",
                                    t.getTreatment_priceLkr()
                                ) %>

                            </td>

                        </tr>

                    <%
                        }

                    } else {
                    %>

                        <tr>

                            <td colspan="2"
                                class="empty-treatment">

                                <i class="fa-solid fa-circle-info"></i>

                                No treatments recorded for this appointment.

                            </td>

                        </tr>

                    <%
                    }
                    %>


                    <!-- CONSULTATION FEE -->

                    <tr class="consultation-row">

                        <td>

                            <div class="treatment-name">

                                <div class="treatment-icon">

                                    <i class="fa-solid fa-user-doctor"></i>

                                </div>

                                <span>
                                    Consultation Fee
                                </span>

                            </div>

                        </td>

                        <td class="price-column">

                            LKR
                            <%= String.format(
                                "%,.2f",
                                consultationFee
                            ) %>

                        </td>

                    </tr>

                </tbody>


                <tfoot>

                    <tr>

                        <td>
                            Grand Total
                        </td>

                        <td class="price-column grand-total">

                            LKR
                            <%= String.format(
                                "%,.2f",
                                billTotal
                            ) %>

                        </td>

                    </tr>

                </tfoot>

            </table>

        </div>

    </div>

</section>


<!-- =====================================================
     QUICK INFORMATION
====================================================== -->

<section class="quick-info-grid">


    <!-- APPOINTMENT NUMBER -->

    <div class="quick-card">

        <div class="quick-icon">

            <i class="fa-solid fa-hashtag"></i>

        </div>

        <div>

            <span>
                Appointment No.
            </span>

            <strong>
                #<%= appt.getAppointment_number() %>
            </strong>

        </div>

    </div>


    <!-- PATIENT -->

    <div class="quick-card">

        <div class="quick-icon">

            <i class="fa-solid fa-user"></i>

        </div>

        <div>

            <span>
                Patient
            </span>

            <strong>
                <%= appt.getP_name() != null
                    ? appt.getP_name()
                    : "N/A" %>
            </strong>

        </div>

    </div>


    <!-- DENTIST -->

    <div class="quick-card">

        <div class="quick-icon">

            <i class="fa-solid fa-user-doctor"></i>

        </div>

        <div>

            <span>
                Dentist
            </span>

            <strong>

                <%= d != null
                    ? "Dr. " + d.getDentist_name()
                    : "N/A" %>

            </strong>

        </div>

    </div>


    <!-- TOTAL -->

    <div class="quick-card">

        <div class="quick-icon">

            <i class="fa-solid fa-money-bill-wave"></i>

        </div>

        <div>

            <span>
                Total Amount
            </span>

            <strong>

                LKR
                <%= String.format(
                    "%,.2f",
                    billTotal
                ) %>

            </strong>

        </div>

    </div>

</section>


<!-- =====================================================
     INFORMATION CARD
====================================================== -->

<section class="info-card">

    <div class="info-icon">

        <i class="fa-solid fa-shield-heart"></i>

    </div>


    <div class="info-content">

        <h3>
            Appointment Information & Privacy
        </h3>

        <p>
            Appointment, patient and billing information
            is confidential and should only be accessed
            by authorized clinic staff. Please ensure that
            all records are handled securely and responsibly.
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
```

</main>

</body>

</html>
