<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

    String contextPath = request.getContextPath();
    String loggedInAdmin =
        String.valueOf(session.getAttribute("loggedInAdmin"));
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Help & Support | Sunrise Dental Clinic</title>

    <!-- =====================================================
         MAIN CSS
    ====================================================== -->
    <link rel="stylesheet"
          href="<%= contextPath %>/CSS/helpsupport.css">

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

        <a href="<%= contextPath %>/adminhomes.jsp">

            <i class="fa-solid fa-chart-line"></i>

            Dashboard

        </a>


        <!-- PATIENTS -->

        <a href="<%= contextPath %>/managePatients">

            <i class="fa-solid fa-user-group"></i>

            Patients

        </a>


        <!-- APPOINTMENTS -->

        <a href="<%= contextPath %>/manageAppointments">

            <i class="fa-solid fa-calendar-check"></i>

            Appointments

        </a>


        <!-- BILLING -->

        <a href="<%= contextPath %>/adbilling.jsp">

            <i class="fa-solid fa-file-invoice-dollar"></i>

            Billing

        </a>


        <!-- HELP -->

        <a href="<%= contextPath %>/helpsupport.jsp"
           class="active">

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
                <%= loggedInAdmin %>
            </strong>

            <span>
                Administrator
            </span>

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
                SUPPORT CENTER
            </span>

            <h1>
                Help & Support
            </h1>

            <p>
                Find answers and assistance for using the
                Sunrise Dental Clinic Management System.
            </p>

        </div>


        <!-- =================================================
             HEADER USER
        ================================================== -->

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
         SEARCH HELP
    ====================================================== -->

    <section class="search-card">

        <div class="search-heading">

            <div class="search-icon">

                <i class="fa-solid fa-magnifying-glass"></i>

            </div>

            <div>

                <span>
                    SUPPORT SEARCH
                </span>

                <h2>
                    How can we help?
                </h2>

            </div>

        </div>


        <div class="help-search-box">

            <i class="fa-solid fa-magnifying-glass"></i>

            <input type="text"
                   id="helpSearch"
                   placeholder="Search help topics, appointments, billing, patients..."
                   onkeyup="searchHelp()">

            <button type="button"
                    onclick="clearHelpSearch()"
                    title="Clear Search">

                <i class="fa-solid fa-xmark"></i>

            </button>

        </div>

        <div class="search-result">

            <span id="searchResultText">
                Showing all help topics
            </span>

        </div>

    </section>


    <!-- =====================================================
         QUICK HELP CARDS
    ====================================================== -->

    <section class="quick-help-grid">


        <!-- APPOINTMENTS -->

        <div class="quick-help-card searchable-item"
             data-search="appointment appointments booking dentist schedule new appointment">

            <div class="quick-help-icon">

                <i class="fa-solid fa-calendar-check"></i>

            </div>

            <div>

                <h3>
                    Appointments
                </h3>

                <p>
                    Manage patient appointments and dentist schedules.
                </p>

            </div>

        </div>


        <!-- PATIENTS -->

        <div class="quick-help-card searchable-item"
             data-search="patient patients register patient contact number details">

            <div class="quick-help-icon">

                <i class="fa-solid fa-user-group"></i>

            </div>

            <div>

                <h3>
                    Patients
                </h3>

                <p>
                    Register, search and manage patient information.
                </p>

            </div>

        </div>


        <!-- BILLING -->

        <div class="quick-help-card searchable-item"
             data-search="billing bill invoice payment treatment consultation print bill">

            <div class="quick-help-icon">

                <i class="fa-solid fa-file-invoice-dollar"></i>

            </div>

            <div>

                <h3>
                    Billing
                </h3>

                <p>
                    View treatment charges and print patient bills.
                </p>

            </div>

        </div>


        <!-- SYSTEM -->

        <div class="quick-help-card searchable-item"
             data-search="system security login password administrator support">

            <div class="quick-help-icon">

                <i class="fa-solid fa-shield-heart"></i>

            </div>

            <div>

                <h3>
                    System Support
                </h3>

                <p>
                    Get assistance with login and system-related issues.
                </p>

            </div>

        </div>

    </section>


    <!-- =====================================================
         MAIN HELP GRID
    ====================================================== -->

    <section class="help-grid">


        <!-- =================================================
             FAQ
        ================================================== -->

        <div class="content-card faq-card">

            <div class="section-header">

                <div class="section-heading">

                    <span class="section-label">
                        FREQUENTLY ASKED QUESTIONS
                    </span>

                    <h2>
                        Common Questions
                    </h2>

                    <p>
                        Quick answers to common administrative tasks.
                    </p>

                </div>

                <div class="section-header-icon">

                    <i class="fa-solid fa-circle-question"></i>

                </div>

            </div>


            <div class="faq-list">


                <!-- FAQ 1 -->

                <div class="faq-item searchable-item"
                     data-search="how add new appointment appointment booking dentist patient phone number treatments">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-calendar-plus"></i>

                            How do I add a new appointment?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            Go to the Appointments section and click
                            <strong>New Appointment</strong>.
                            Enter the patient's contact number to check
                            whether the patient is already registered.
                            Select the dentist, appointment date and time,
                            and required treatments before submitting
                            the appointment.

                        </p>

                    </div>

                </div>


                <!-- FAQ 2 -->

                <div class="faq-item searchable-item"
                     data-search="dentist treatments not showing appointment form dentist treatment available">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-user-doctor"></i>

                            Why can't I see dentists or treatments?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            Make sure you open the Add Appointment page
                            using the <strong>New Appointment</strong>
                            button from the Appointments section.
                            The system loads active dentists and treatments
                            when the appointment form is opened correctly.

                        </p>

                    </div>

                </div>


                <!-- FAQ 3 -->

                <div class="faq-item searchable-item"
                     data-search="print bill billing invoice patient treatment charges">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-print"></i>

                            How do I print a patient bill?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            Open the <strong>Billing</strong> section,
                            locate the required appointment and select
                            the print icon from the Actions column.
                            The invoice will open in a new browser tab
                            where it can be printed.

                        </p>

                    </div>

                </div>


                <!-- FAQ 4 -->

                <div class="faq-item searchable-item"
                     data-search="edit appointment update patient dentist date time status">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-pen"></i>

                            Can I edit an appointment?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            Yes. Open the Appointments section and click
                            the <strong>Edit</strong> icon for the required
                            appointment. Patient information, dentist,
                            appointment schedule and status can be updated
                            according to the available fields.

                        </p>

                    </div>

                </div>


                <!-- FAQ 5 -->

                <div class="faq-item searchable-item"
                     data-search="delete patient appointment remove record trash confirmation">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-trash"></i>

                            How do I delete a record?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            Select the delete icon beside the relevant
                            patient or appointment. A confirmation message
                            will appear before the record is permanently
                            removed from the system.

                        </p>

                    </div>

                </div>


                <!-- FAQ 6 -->

                <div class="faq-item searchable-item"
                     data-search="forgot password admin login password reset administrator">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-lock"></i>

                            I forgot my administrator password. What should I do?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            For security reasons, contact the clinic system
                            administrator using the support information
                            provided on this page to request assistance
                            with resetting the administrator password.

                        </p>

                    </div>

                </div>


                <!-- FAQ 7 -->

                <div class="faq-item searchable-item"
                     data-search="patient already registered check patient contact phone number">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-user-check"></i>

                            How can I check if a patient is registered?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            On the Add Appointment page, enter the patient's
                            contact number and use the patient checking
                            function. If the contact number already exists,
                            the patient's registered information can be
                            loaded automatically.

                        </p>

                    </div>

                </div>


                <!-- FAQ 8 -->

                <div class="faq-item searchable-item"
                     data-search="dentist busy availability appointment time conflict schedule">

                    <button type="button"
                            class="faq-question"
                            onclick="toggleFAQ(this)">

                        <span>

                            <i class="fa-solid fa-clock"></i>

                            What happens if a dentist is already busy?

                        </span>

                        <i class="fa-solid fa-chevron-down faq-arrow"></i>

                    </button>

                    <div class="faq-answer">

                        <p>

                            The appointment system checks the dentist's
                            existing schedule for the selected date and
                            time. If the dentist already has an appointment
                            during that period, select another available
                            time slot.

                        </p>

                    </div>

                </div>


            </div>


            <!-- NO SEARCH RESULTS -->

            <div id="noResults"
                 class="no-results">

                <div class="no-results-icon">

                    <i class="fa-solid fa-magnifying-glass"></i>

                </div>

                <h3>
                    No Help Topics Found
                </h3>

                <p>
                    Try using different keywords such as
                    appointment, patient, billing or password.
                </p>

            </div>

        </div>


        <!-- =================================================
             CONTACT INFORMATION
        ================================================== -->

        <div class="support-side">


            <!-- CONTACT CARD -->

            <div class="content-card contact-card">

                <div class="section-header">

                    <div class="section-heading">

                        <span class="section-label">
                            CONTACT INFORMATION
                        </span>

                        <h2>
                            Get in Touch
                        </h2>

                    </div>

                    <div class="section-header-icon">

                        <i class="fa-solid fa-headset"></i>

                    </div>

                </div>


                <div class="contact-list">


                    <div class="contact-item">

                        <div class="contact-icon">

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


                    <div class="contact-item">

                        <div class="contact-icon">

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


                    <div class="contact-item">

                        <div class="contact-icon">

                            <i class="fa-solid fa-location-dot"></i>

                        </div>

                        <div>

                            <span>
                                Address
                            </span>

                            <strong>
                                No. 45, Galle Road,
                                Colombo 03, Sri Lanka
                            </strong>

                        </div>

                    </div>


                    <div class="contact-item">

                        <div class="contact-icon">

                            <i class="fa-solid fa-clock"></i>

                        </div>

                        <div>

                            <span>
                                Support Hours
                            </span>

                            <strong>
                                Monday - Saturday
                                <br>
                                8:00 AM - 6:00 PM
                            </strong>

                        </div>

                    </div>

                </div>

            </div>


            <!-- SYSTEM SUPPORT CARD -->

            <div class="support-status-card">

                <div class="support-status-icon">

                    <i class="fa-solid fa-shield-heart"></i>

                </div>

                <div>

                    <span>
                        SYSTEM SUPPORT
                    </span>

                    <h3>
                        Support is Available
                    </h3>

                    <p>
                        Our clinic management system is currently
                        operating normally.
                    </p>

                </div>

                <div class="online-status">

                    <i class="fa-solid fa-circle"></i>

                    Active

                </div>

            </div>


            <!-- QUICK TIPS -->

            <div class="content-card tips-card">

                <div class="section-header">

                    <div class="section-heading">

                        <span class="section-label">
                            QUICK TIPS
                        </span>

                        <h2>
                            Helpful Tips
                        </h2>

                    </div>

                </div>


                <div class="tip-item">

                    <i class="fa-solid fa-circle-check"></i>

                    <span>
                        Always check the patient contact number
                        before creating a new patient record.
                    </span>

                </div>


                <div class="tip-item">

                    <i class="fa-solid fa-circle-check"></i>

                    <span>
                        Verify the dentist and appointment time
                        before confirming an appointment.
                    </span>

                </div>


                <div class="tip-item">

                    <i class="fa-solid fa-circle-check"></i>

                    <span>
                        Review treatment charges before printing
                        the final patient bill.
                    </span>

                </div>

            </div>

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
                Professional dental care supported by an efficient
                and secure clinic management system.
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
     JAVASCRIPT
========================================================= -->

<script>

/* =========================================================
   FAQ TOGGLE
========================================================= */

function toggleFAQ(button) {

    const faqItem = button.parentElement;

    const answer = faqItem.querySelector(".faq-answer");

    const isOpen = faqItem.classList.contains("open");


    document.querySelectorAll(".faq-item").forEach(function(item) {

        item.classList.remove("open");

    });


    if (!isOpen) {

        faqItem.classList.add("open");

    }

}


/* =========================================================
   SEARCH HELP TOPICS
========================================================= */

function searchHelp() {

    const input =
        document.getElementById("helpSearch");

    const filter =
        input.value.toLowerCase().trim();

    const items =
        document.querySelectorAll(".searchable-item");

    const noResults =
        document.getElementById("noResults");

    const resultText =
        document.getElementById("searchResultText");

    let visibleCount = 0;


    items.forEach(function(item) {

        const searchText =
            (
                item.textContent +
                " " +
                item.getAttribute("data-search")
            ).toLowerCase();


        if (searchText.includes(filter)) {

            item.style.display = "";

            visibleCount++;

        } else {

            item.style.display = "none";

        }

    });


    if (filter === "") {

        resultText.textContent =
            "Showing all help topics";

    } else {

        resultText.textContent =
            "Found " + visibleCount + " help topic(s)";

    }


    if (visibleCount === 0 && filter !== "") {

        noResults.style.display = "block";

    } else {

        noResults.style.display = "none";

    }

}


/* =========================================================
   CLEAR SEARCH
========================================================= */

function clearHelpSearch() {

    const input =
        document.getElementById("helpSearch");

    input.value = "";

    searchHelp();

    input.focus();

}

function confirmLogout(event) {
    event.preventDefault();

    const confirmLogout = confirm("Are you sure you want to logout?");

    if (confirmLogout) {
        window.location.href = "<%= request.getContextPath() %>/logout";
    }
}

</script>


</body>

</html>