<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Check admin login
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(
            request.getContextPath() + "/adlogin.jsp"
        );
        return;
    }

    String error = (String) session.getAttribute("error");
    String success = (String) session.getAttribute("success");

    // Remove messages after reading
    session.removeAttribute("error");
    session.removeAttribute("success");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add Patient | Sunrise Dental Clinic</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/ad_addpatients.css">

</head>

<body>


<!-- =========================================================
     TOP NAVIGATION
========================================================= -->

<header class="top-navbar">

    <!-- BRAND -->

    <div class="brand">

        <div class="brand-icon">
            <i class="fa-solid fa-tooth"></i>
        </div>

        <div class="brand-text">

            <h2>Sunrise</h2>
            <span>Dental Clinic</span>

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
            <i class="fa-solid fa-users"></i>
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

    </nav>


    <!-- ADMIN AREA -->

    <div class="admin-area">

        <div class="admin-icon">
            <i class="fa-solid fa-user"></i>
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


    <!-- PAGE HEADER -->

    <section class="page-header">

        <div>

            <span class="page-label">
                ADMIN PORTAL
            </span>

            <h1>
                Add New Patient
            </h1>

            <p>
                Register a new patient in the Sunrise Dental Clinic system.
            </p>

        </div>


        <div class="header-user">

            <div class="header-user-icon">
                <i class="fa-solid fa-user-plus"></i>
            </div>

            <div>

                <span>Patient Management</span>

                <strong>
                    New Registration
                </strong>

            </div>

        </div>

    </section>



    <!-- =====================================================
         MESSAGES
    ====================================================== -->

    <% if (error != null) { %>

        <div class="message error-message">

            <i class="fa-solid fa-circle-exclamation"></i>

            <span>
                <%= error %>
            </span>

        </div>

    <% } %>


    <% if (success != null) { %>

        <div class="message success-message">

            <i class="fa-solid fa-circle-check"></i>

            <span>
                <%= success %>
            </span>

        </div>

    <% } %>



    <!-- =====================================================
         FORM CARD
    ====================================================== -->

    <section class="form-card">


        <!-- CARD HEADER -->

        <div class="form-header">

            <div class="form-header-icon">
                <i class="fa-solid fa-user-plus"></i>
            </div>

            <div>

                <h2>Patient Information</h2>

                <p>
                    Enter the patient's basic information below.
                </p>

            </div>

        </div>



        <!-- FORM -->

        <form method="post"
              action="${pageContext.request.contextPath}/addPatients"
              class="patient-form">


            <!-- ROW 1 -->

            <div class="form-row">


                <!-- Patient Name -->

                <div class="form-group">

                    <label for="patient_name">
                        Patient Name
                        <span>*</span>
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-solid fa-user"></i>

                        <input
                            type="text"
                            id="patient_name"
                            name="patient_name"
                            placeholder="Enter patient's full name"
                            maxlength="100"
                            required>

                    </div>

                </div>



                <!-- Contact Number -->

                <div class="form-group">

                    <label for="contact_number">
                        Contact Number
                        <span>*</span>
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-solid fa-phone"></i>

                        <input
                            type="text"
                            id="contact_number"
                            name="contact_number"
                            placeholder="07XXXXXXXX"
                            maxlength="10"
                            pattern="0[0-9]{9}"
                            required>

                    </div>

                    <small>
                        Enter a valid 10-digit Sri Lankan number.
                    </small>

                </div>

            </div>



            <!-- ADDRESS -->

            <div class="form-group full-width">

                <label for="address">
                    Address
                    <span>*</span>
                </label>

                <div class="textarea-wrapper">

                    <i class="fa-solid fa-location-dot"></i>

                    <textarea
                        id="address"
                        name="address"
                        placeholder="Enter patient's address"
                        rows="3"
                        required></textarea>

                </div>

            </div>



            <!-- ROW 2 -->

            <div class="form-row">


                <!-- Gender -->

                <div class="form-group">

                    <label for="gender">
                        Gender
                        <span>*</span>
                    </label>

                    <div class="input-wrapper select-wrapper">

                        <i class="fa-solid fa-venus-mars"></i>

                        <select
                            id="gender"
                            name="gender"
                            required>

                            <option value="" selected disabled>
                                Select gender
                            </option>

                            <option value="Male">
                                Male
                            </option>

                            <option value="Female">
                                Female
                            </option>

                            <option value="Other">
                                Other
                            </option>

                        </select>

                    </div>

                </div>



                <!-- Status -->

                <div class="form-group">

                    <label for="status">
                        Patient Status
                    </label>

                    <div class="input-wrapper select-wrapper">

                        <i class="fa-solid fa-circle-check"></i>

                        <select
                            id="status"
                            name="status">

                            <option value="Active" selected>
                                Active
                            </option>

                            <option value="Inactive">
                                Inactive
                            </option>

                        </select>

                    </div>

                </div>

            </div>



            <!-- REQUIRED NOTE -->

            <div class="required-note">

                <span>*</span>
                Required fields

            </div>



            <!-- FORM ACTIONS -->

            <div class="form-actions">

                <a href="${pageContext.request.contextPath}/managePatients"
                   class="cancel-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    Cancel

                </a>


                <button type="reset"
                        class="reset-btn">

                    <i class="fa-solid fa-rotate-left"></i>

                    Reset

                </button>


                <button type="submit"
                        class="submit-btn">

                    <i class="fa-solid fa-user-plus"></i>

                    Add Patient

                </button>

            </div>


        </form>

    </section>



    <!-- =====================================================
         INFORMATION CARD
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
                Please ensure that all patient information
                is accurate before registration.
            </p>

        </div>

        <span class="clinic-status">
            <i class="fa-solid fa-circle"></i>
            Admin Portal
        </span>

    </section>



    <!-- FOOTER -->

    <footer>

        <span>
            © 2026 Sunrise Dental Clinic
        </span>

        <span>
            Patient Management System
        </span>

    </footer>


</main>

</body>
</html>

