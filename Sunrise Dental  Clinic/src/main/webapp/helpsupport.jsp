<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // =========================================================
    // ADMIN LOGIN CHECK
    // =========================================================
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
        return;
    }

    String contextPath = request.getContextPath();
    Object loggedInAdmin = session.getAttribute("loggedInAdmin");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Help & Support | Sunrise Dental Clinic</title>

    <!-- Main Admin CSS -->
    <link rel="stylesheet"
          href="<%= contextPath %>/CSS/adappointments.css">

    <!-- Help & Support CSS -->
    <link rel="stylesheet"
          href="<%= contextPath %>/CSS/helpsupport.css">

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

        <a href="<%= contextPath %>/adminhomes.jsp">
            <i class="fa-solid fa-chart-line"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= contextPath %>/managePatients">
            <i class="fa-solid fa-user-group"></i>
            <span>Patients</span>
        </a>

        <a href="<%= contextPath %>/manageAppointments">
            <i class="fa-solid fa-calendar-check"></i>
            <span>Appointments</span>
        </a>


        <a href="<%= contextPath %>/manageBilling">
            <i class="fa-solid fa-file-invoice-dollar"></i>
            <span>Billing</span>
        </a>

        <a href="<%= contextPath %>/helpSupport"
           class="active">
            <i class="fa-solid fa-circle-question"></i>
            <span>Help</span>
        </a>

    </nav>


    <!-- ADMIN AREA -->

    <div class="admin-area">

        <div class="admin-icon">
            <i class="fa-solid fa-user-shield"></i>
        </div>

        <div class="admin-details">

            <strong>
                <%= loggedInAdmin %>
            </strong>

            <span>Administrator</span>

        </div>

        <a href="<%= contextPath %>/logout"
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


    <!-- PAGE HEADER -->

    <section class="page-header">

        <div class="page-header-content">

            <span class="page-label">
                SUPPORT CENTER
            </span>

            <h1>
                Help & Support
            </h1>

            <p>
                Find answers and guidance for managing the
                Sunrise Dental Clinic system.
            </p>

        </div>


        <div class="header-user">

            <div class="header-user-icon">
                <i class="fa-solid fa-circle-question"></i>
            </div>

            <div class="header-user-text">

                <span>
                    Welcome back
                </span>

                <strong>
                    <%= loggedInAdmin %>
                </strong>

            </div>

        </div>

    </section>


    <!-- =====================================================
         QUICK SUPPORT CARDS
    ====================================================== -->

    <section class="support-cards">


        <!-- PHONE -->

        <div class="support-card">

            <div class="support-icon phone-icon">
                <i class="fa-solid fa-phone"></i>
            </div>

            <div class="support-card-content">

                <span class="support-label">
                    CALL SUPPORT
                </span>

                <h3>
                    +94 11 234 5678
                </h3>

                <p>
                    Speak directly with the clinic
                    administration team.
                </p>

            </div>

        </div>


        <!-- EMAIL -->

        <div class="support-card">

            <div class="support-icon email-icon">
                <i class="fa-solid fa-envelope"></i>
            </div>

            <div class="support-card-content">

                <span class="support-label">
                    EMAIL SUPPORT
                </span>

                <h3>
                    support@sunrisedental.lk
                </h3>

                <p>
                    Send your questions and receive
                    assistance from our team.
                </p>

            </div>

        </div>


        <!-- SUPPORT HOURS -->

        <div class="support-card">

            <div class="support-icon time-icon">
                <i class="fa-solid fa-clock"></i>
            </div>

            <div class="support-card-content">

                <span class="support-label">
                    SUPPORT HOURS
                </span>

                <h3>
                    8:00 AM – 6:00 PM
                </h3>

                <p>
                    Monday to Saturday.
                </p>

            </div>

        </div>

    </section>


    <!-- =====================================================
         CONTACT INFORMATION
    ====================================================== -->

    <section class="content-card">

        <div class="card-header">

            <div class="section-heading">

                <span class="section-label">
                    CONTACT INFORMATION
                </span>

                <h2>
                    Get in Touch
                </h2>

                <p>
                    Contact the clinic administration team
                    whenever you need assistance.
                </p>

            </div>

            <div class="card-header-icon">
                <i class="fa-solid fa-headset"></i>
            </div>

        </div>


        <div class="contact-grid">


            <!-- PHONE -->

            <div class="contact-item">

                <div class="contact-item-icon">
                    <i class="fa-solid fa-phone"></i>
                </div>

                <div>

                    <span>
                        Phone
                    </span>

                    <strong>
                        +94 11 234 5678
                    </strong>

                </div>

            </div>


            <!-- EMAIL -->

            <div class="contact-item">

                <div class="contact-item-icon">
                    <i class="fa-solid fa-envelope"></i>
                </div>

                <div>

                    <span>
                        Email
                    </span>

                    <strong>
                        support@sunrisedental.lk
                    </strong>

                </div>

            </div>


            <!-- ADDRESS -->

            <div class="contact-item">

                <div class="contact-item-icon">
                    <i class="fa-solid fa-location-dot"></i>
                </div>

                <div>

                    <span>
                        Clinic Address
                    </span>

                    <strong>
                        No. 45, Galle Road,
                        Colombo 03, Sri Lanka
                    </strong>

                </div>

            </div>


            <!-- HOURS -->

            <div class="contact-item">

                <div class="contact-item-icon">
                    <i class="fa-solid fa-business-time"></i>
                </div>

                <div>

                    <span>
                        Support Hours
                    </span>

                    <strong>
                        Monday – Saturday,
                        8:00 AM – 6:00 PM
                    </strong>

                </div>

            </div>

        </div>

    </section>


    <!-- =====================================================
         FAQ
    ====================================================== -->

    <section class="content-card">

        <div class="card-header">

            <div class="section-heading">

                <span class="section-label">
                    FREQUENTLY ASKED QUESTIONS
                </span>

                <h2>
                    Common Questions
                </h2>

                <p>
                    Quick answers to common administrative
                    tasks and system questions.
                </p>

            </div>

            <div class="card-header-icon">
                <i class="fa-solid fa-comments"></i>
            </div>

        </div>


        <div class="faq-container">


            <!-- FAQ 01 -->

            <div class="faq-item">

                <div class="faq-number">
                    01
                </div>

                <div class="faq-content">

                    <h3>
                        How do I add a new appointment?
                    </h3>

                    <p>
                        Go to the Appointments section and click
                        <strong>New Appointment</strong>. Enter the
                        patient's contact number to check whether
                        the patient is already registered. Select
                        the dentist, appointment date and time,
                        and required treatments before submitting
                        the appointment.
                    </p>

                </div>

            </div>


            <!-- FAQ 02 -->

            <div class="faq-item">

                <div class="faq-number">
                    02
                </div>

                <div class="faq-content">

                    <h3>
                        Why can't I see dentists or treatments?
                    </h3>

                    <p>
                        Make sure the appointment page has been
                        opened through the system's
                        <strong>New Appointment</strong> option.
                        The system loads active dentists and
                        treatments when the appointment page is
                        opened correctly.
                    </p>

                </div>

            </div>


            <!-- FAQ 03 -->

            <div class="faq-item">

                <div class="faq-number">
                    03
                </div>

                <div class="faq-content">

                    <h3>
                        How do I print a patient's bill?
                    </h3>

                    <p>
                        Open the <strong>Billing</strong> section
                        and locate the required appointment.
                        Click the print icon in the Actions column.
                        The system will open the bill in a new tab
                        where it can be printed.
                    </p>

                </div>

            </div>


            <!-- FAQ 04 -->

            <div class="faq-item">

                <div class="faq-number">
                    04
                </div>

                <div class="faq-content">

                    <h3>
                        Can I edit an existing appointment?
                    </h3>

                    <p>
                        Yes. Open the <strong>Appointments</strong>
                        section and select the edit option for the
                        required appointment. Patient information,
                        dentist, appointment schedule and status
                        can be updated where permitted.
                    </p>

                </div>

            </div>


            <!-- FAQ 05 -->

            <div class="faq-item">

                <div class="faq-number">
                    05
                </div>

                <div class="faq-content">

                    <h3>
                        How do I delete a patient or appointment?
                    </h3>

                    <p>
                        Find the required record in the Patients
                        or Appointments section and click the
                        delete icon. A confirmation message will
                        appear before the record is permanently
                        removed.
                    </p>

                </div>

            </div>


            <!-- FAQ 06 -->

            <div class="faq-item">

                <div class="faq-number">
                    06
                </div>

                <div class="faq-content">

                    <h3>
                        I forgot my administrator password. What should I do?
                    </h3>

                    <p>
                        Contact the clinic system administrator
                        using the support details provided above
                        and request a password reset.
                    </p>

                </div>

            </div>


            <!-- FAQ 07 -->

            <div class="faq-item">

                <div class="faq-number">
                    07
                </div>

                <div class="faq-content">

                    <h3>
                        How can I check whether a patient is registered?
                    </h3>

                    <p>
                        On the New Appointment page, enter the
                        patient's contact number and select
                        <strong>Check Patient</strong>. If the
                        patient exists, the registered details
                        will be displayed automatically.
                    </p>

                </div>

            </div>


            <!-- FAQ 08 -->

            <div class="faq-item">

                <div class="faq-number">
                    08
                </div>

                <div class="faq-content">

                    <h3>
                        What happens if a dentist is already booked?
                    </h3>

                    <p>
                        The system checks the dentist's availability
                        for the selected date and time. If another
                        appointment already exists for that dentist
                        and time, the system will prevent the
                        conflicting booking and require another
                        available time.
                    </p>

                </div>

            </div>

        </div>

    </section>


    <!-- =====================================================
         SUPPORT NOTICE
    ====================================================== -->

    <section class="support-notice">

        <div class="notice-icon">
            <i class="fa-solid fa-circle-info"></i>
        </div>

        <div class="notice-content">

            <h3>
                Need further assistance?
            </h3>

            <p>
                If your issue is not covered in the FAQ section,
                please contact the clinic administration team
                using the phone number or email address above.
            </p>

        </div>

    </section>


    <!-- =====================================================
         FOOTER
    ====================================================== -->

    <footer>

        <span>
            &copy; 2026 Sunrise Dental Clinic.
            All Rights Reserved.
        </span>

        <span>
            Clinic Management System
        </span>

    </footer>

</main>

</body>
</html>