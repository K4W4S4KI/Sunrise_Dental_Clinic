<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

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
        Update Patient | Sunrise Dental Clinic
    </title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/ad_updatepatients.css">

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

            <h1>Update Patient</h1>

            <p>
                Edit and update the patient's clinic record.
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
         ALERT - ERROR
    ====================================================== -->

    <% if (error != null) { %>

        <div class="alert alert-error">

            <div class="alert-icon">

                <i class="fa-solid fa-circle-exclamation"></i>

            </div>


            <div>

                <strong>
                    Unable to update patient
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
         ALERT - SUCCESS
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
         UPDATE FORM CARD
    ====================================================== -->

    <section class="form-card">


        <!-- FORM HEADER -->

        <div class="form-card-header">

            <div class="form-title-area">

                <div class="form-main-icon">

                    <i class="fa-solid fa-user-pen"></i>

                </div>


                <div>

                    <h2>
                        Patient Information
                    </h2>

                    <p>
                        Update the patient's personal details below.
                    </p>

                </div>

            </div>


            <div class="patient-id">

                <span>Patient ID</span>

                <strong>
                    #<%= pat.getP_id() %>
                </strong>

            </div>

        </div>


        <!-- =================================================
             FORM
        ================================================== -->

        <form action="${pageContext.request.contextPath}/updatePatients"
              method="post"
              class="patient-form"
              onsubmit="return validatePatientForm();">


            <!-- HIDDEN PATIENT ID -->

            <input type="hidden"
                   name="p_id"
                   value="<%= pat.getP_id() %>">


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
                           value="<%= pat.getP_name() != null ? pat.getP_name() : "" %>"
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
                              required><%= pat.getAddress() != null ? pat.getAddress() : "" %></textarea>

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
                           value="<%= pat.getC_number() != null ? pat.getC_number() : "" %>"
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

                        <option value=""
                                disabled>

                            Select gender

                        </option>


                        <option value="Male"
                            <%= "Male".equals(pat.getGender())
                                ? "selected"
                                : "" %>>

                            Male

                        </option>


                        <option value="Female"
                            <%= "Female".equals(pat.getGender())
                                ? "selected"
                                : "" %>>

                            Female

                        </option>


                        <option value="Other"
                            <%= "Other".equals(pat.getGender())
                                ? "selected"
                                : "" %>>

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

                        <option value="Active"
                            <%= "Active".equals(pat.getStatus())
                                ? "selected"
                                : "" %>>

                            Active

                        </option>


                        <option value="Inactive"
                            <%= "Inactive".equals(pat.getStatus())
                                ? "selected"
                                : "" %>>

                            Inactive

                        </option>

                    </select>


                    <i class="fa-solid fa-chevron-down select-arrow"></i>

                </div>


                <small class="field-help">

                    <i class="fa-solid fa-circle-info"></i>

                    Select the current patient status.

                </small>

            </div>


            <!-- =================================================
                 REGISTERED DATE
            ================================================== -->

            <div class="form-group">

                <label>

                    Registered Date

                </label>


                <div class="input-wrapper">

                    <i class="fa-solid fa-calendar-days input-icon"></i>

                    <input type="text"
                           value="<%= pat.getRegister_datetime() != null
                                    ? pat.getRegister_datetime()
                                    : "" %>"
                           readonly
                           class="readonly-input">

                </div>


                <small class="field-help">

                    <i class="fa-solid fa-lock"></i>

                    Registration date cannot be changed.

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


                    <button type="button"
                            class="reset-btn"
                            onclick="resetForm();">

                        <i class="fa-solid fa-rotate-left"></i>

                        Reset Changes

                    </button>


                    <button type="submit"
                            class="primary-btn">

                        <i class="fa-solid fa-floppy-disk"></i>

                        Update Patient

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

            <h3>
                Patient Information & Privacy
            </h3>

            <p>
                Please verify all updated patient information
                carefully before saving. Patient records should
                be handled confidentially and used only for
                authorized clinic management purposes.
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


/* =========================================================
   ALLOW NUMBERS ONLY IN CONTACT FIELD
========================================================= */

document.getElementById("contact_number")
    .addEventListener("input", function () {

        this.value =
            this.value.replace(/[^0-9]/g, "");

    });


/* =========================================================
   RESET FORM TO ORIGINAL DATABASE VALUES
========================================================= */

const originalValues = {

    name:
        document.getElementById("patient_name").value,

    address:
        document.getElementById("address").value,

    contact:
        document.getElementById("contact_number").value,

    gender:
        document.getElementById("gender").value,

    status:
        document.getElementById("status").value
};


function resetForm() {

    const confirmed =
        confirm(
            "Are you sure you want to discard your changes?"
        );

    if (!confirmed) {
        return;
    }


    document.getElementById("patient_name").value =
        originalValues.name;

    document.getElementById("address").value =
        originalValues.address;

    document.getElementById("contact_number").value =
        originalValues.contact;

    document.getElementById("gender").value =
        originalValues.gender;

    document.getElementById("status").value =
        originalValues.status;
}

</script>

</body>

</html>