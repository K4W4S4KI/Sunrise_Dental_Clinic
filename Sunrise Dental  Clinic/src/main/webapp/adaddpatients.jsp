<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if (session.getAttribute("loggedInAdmin") == null) {
response.sendRedirect(request.getContextPath() + "/adlogin.jsp");
return;
}


String error = (String) session.getAttribute("error");
String success = (String) session.getAttribute("success");

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

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/CSS/ad_addpatients.css">

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


        <a href="#" class="logout-btn" title="Logout" onclick="confirmLogout(event)">
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
            PATIENT MANAGEMENT
        </span>

        <h1>Add New Patient</h1>

        <p>
            Register a new patient and create their clinic record.
        </p>

    </div>


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
     ALERT MESSAGES
====================================================== -->

<% if (error != null) { %>

    <div class="alert alert-error">

        <div class="alert-icon">

            <i class="fa-solid fa-circle-exclamation"></i>

        </div>

        <div>

            <strong>Unable to add patient</strong>

            <span><%= error %></span>

        </div>

        <button type="button"
                class="alert-close"
                onclick="this.parentElement.remove();">

            <i class="fa-solid fa-xmark"></i>

        </button>

    </div>

<% } %>


<% if (success != null) { %>

    <div class="alert alert-success">

        <div class="alert-icon">

            <i class="fa-solid fa-circle-check"></i>

        </div>

        <div>

            <strong>Success</strong>

            <span><%= success %></span>

        </div>

        <button type="button"
                class="alert-close"
                onclick="this.parentElement.remove();">

            <i class="fa-solid fa-xmark"></i>

        </button>

    </div>

<% } %>



<!-- =====================================================
     PATIENT FORM CARD
====================================================== -->

<section class="form-card">


    <!-- FORM HEADER -->

    <div class="form-card-header">

        <div class="form-title-area">

            <div class="form-main-icon">

                <i class="fa-solid fa-user-plus"></i>

            </div>

            <div>

                <h2>Patient Information</h2>

                <p>
                    Enter the patient's personal details below.
                </p>

            </div>

        </div>


        <div class="required-note">

            <span>*</span>

            Required fields

        </div>

    </div>



    <!-- FORM -->

    <form action="${pageContext.request.contextPath}/addPatients"
          method="post"
          class="patient-form"
          onsubmit="return validatePatientForm();">


        <!-- =================================================
             PATIENT NAME
        ================================================== -->

        <div class="form-group full-width">

            <label for="patient_name">

                Patient Name

                <span>*</span>

            </label>


            <div class="input-wrapper">

                <i class="fa-solid fa-user input-icon"></i>

                <input type="text"
                       id="patient_name"
                       name="patient_name"
                       placeholder="Enter patient's full name"
                       maxlength="100"
                       autocomplete="name"
                       required>

            </div>

        </div>



        <!-- =================================================
             ADDRESS
        ================================================== -->

        <div class="form-group full-width">

            <label for="address">

                Address

                <span>*</span>

            </label>


            <div class="input-wrapper textarea-wrapper">

                <i class="fa-solid fa-location-dot input-icon"></i>

                <textarea id="address"
                          name="address"
                          rows="3"
                          maxlength="250"
                          placeholder="Enter patient's residential address"
                          required></textarea>

            </div>

        </div>



        <!-- =================================================
             CONTACT NUMBER
        ================================================== -->

        <div class="form-group">

            <label for="contact_number">

                Contact Number

                <span>*</span>

            </label>


            <div class="input-wrapper">

                <i class="fa-solid fa-phone input-icon"></i>

                <input type="tel"
                       id="contact_number"
                       name="contact_number"
                       placeholder="07XXXXXXXX"
                       maxlength="10"
                       pattern="0[0-9]{9}"
                       inputmode="numeric"
                       required>

            </div>


            <small class="field-help">

                <i class="fa-solid fa-circle-info"></i>

                Enter a valid 10-digit Sri Lankan number.

            </small>

        </div>



        <!-- =================================================
             GENDER
        ================================================== -->

        <div class="form-group">

            <label for="gender">

                Gender

                <span>*</span>

            </label>


            <div class="input-wrapper select-wrapper">

                <i class="fa-solid fa-venus-mars input-icon"></i>

                <select id="gender"
                        name="gender"
                        required>

                    <option value="" disabled selected>
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

                <i class="fa-solid fa-chevron-down select-arrow"></i>

            </div>

        </div>



        <!-- =================================================
             STATUS
        ================================================== -->

        <div class="form-group">

            <label for="status">

                Patient Status

            </label>


            <div class="input-wrapper select-wrapper">

                <i class="fa-solid fa-circle-check input-icon"></i>

                <select id="status"
                        name="status">

                    <option value="Active" selected>
                        Active
                    </option>

                    <option value="Inactive">
                        Inactive
                    </option>

                </select>

                <i class="fa-solid fa-chevron-down select-arrow"></i>

            </div>


            <small class="field-help">

                <i class="fa-solid fa-circle-info"></i>

                New patients are active by default.

            </small>

        </div>



        <!-- =================================================
             FORM ACTIONS
        ================================================== -->

        <div class="form-actions">


            <a href="${pageContext.request.contextPath}/managePatients"
               class="secondary-btn">

                <i class="fa-solid fa-arrow-left"></i>

                Back to Patients

            </a>


            <div class="right-actions">

                <button type="reset"
                        class="reset-btn">

                    <i class="fa-solid fa-rotate-left"></i>

                    Clear

                </button>


                <button type="submit"
                        class="primary-btn">

                    <i class="fa-solid fa-user-plus"></i>

                    Add Patient

                </button>

            </div>

        </div>


    </form>

</section>



<!-- =====================================================
     INFORMATION CARD
====================================================== -->

<section class="info-card">

    <div class="info-icon">

        <i class="fa-solid fa-shield-heart"></i>

    </div>


    <div class="info-content">

        <h3>Patient Information & Privacy</h3>

        <p>
            Please ensure that all patient information is entered
            accurately. Patient records should be handled
            confidentially and used only for authorized clinic
            management purposes.
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


</main>

<!-- =========================================================
     JAVASCRIPT VALIDATION
========================================================= -->

<script>

function confirmLogout(event) {
    event.preventDefault();

    const confirmLogout = confirm("Are you sure you want to logout?");

    if (confirmLogout) {
        window.location.href = "<%= request.getContextPath() %>/logout";
    }
}

function validatePatientForm() {

    const name =
        document.getElementById("patient_name").value.trim();

    const address =
        document.getElementById("address").value.trim();

    const contact =
        document.getElementById("contact_number").value.trim();

    const gender =
        document.getElementById("gender").value;


    if (name === "") {

        alert("Please enter the patient name.");

        document.getElementById("patient_name").focus();

        return false;
    }


    if (address === "") {

        alert("Please enter the patient address.");

        document.getElementById("address").focus();

        return false;
    }


    if (!/^0[0-9]{9}$/.test(contact)) {

        alert(
            "Please enter a valid 10-digit Sri Lankan contact number."
        );

        document.getElementById("contact_number").focus();

        return false;
    }


    if (gender === "") {

        alert("Please select the patient's gender.");

        document.getElementById("gender").focus();

        return false;
    }


    return true;
}


/* Allow numbers only in contact field */

document.getElementById("contact_number")
    .addEventListener("input", function () {

        this.value = this.value.replace(/[^0-9]/g, "");

    });

</script>

</body>
</html>
