<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.appointment" %>
<%@ page import="model.dentist" %>

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

    String contextPath = request.getContextPath();

    // =========================================================
    // GET APPOINTMENT OBJECT
    // =========================================================

    appointment appt =
        (appointment) request.getAttribute("appt");

    if (appt == null) {
        response.sendRedirect(
            contextPath + "/manageAppointments"
        );
        return;
    }

    // =========================================================
    // GET DENTIST LIST
    // =========================================================

    List<dentist> dentistList =
        (List<dentist>) request.getAttribute("dentistList");

    if (dentistList == null) {
        dentistList = new ArrayList<dentist>();
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
    // DATE AND TIME FORMATTING
    // =========================================================

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("yyyy-MM-dd");

    SimpleDateFormat timeFormat =
        new SimpleDateFormat("HH:mm");

    String appointmentDate = "";

    String appointmentTime = "";

    if (appt.getAppointment_datetime() != null) {

        appointmentDate =
            dateFormat.format(
                appt.getAppointment_datetime()
            );

        appointmentTime =
            timeFormat.format(
                appt.getAppointment_datetime()
            );
    }

    // =========================================================
    // STATUS
    // =========================================================

    String currentStatus =
        appt.getStatus() != null
            ? appt.getStatus()
            : "Pending";
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Update Appointment | Sunrise Dental Clinic
    </title>

    <!-- APPOINTMENT CSS -->
    <link rel="stylesheet"
          href="<%= contextPath %>/CSS/ad_updateappointment.css">

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

        <a href="<%= contextPath %>/adminhomes.jsp">

            <i class="fa-solid fa-chart-line"></i>

            Dashboard

        </a>


        <a href="<%= contextPath %>/managePatients">

            <i class="fa-solid fa-user-group"></i>

            Patients

        </a>


        <a href="<%= contextPath %>/manageAppointments"
           class="active">

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


    <!-- =====================================================
         PAGE HEADER
    ====================================================== -->

    <section class="page-header">

        <div>

            <span class="page-label">
                APPOINTMENT MANAGEMENT
            </span>

            <h1>
                Update Appointment
            </h1>

            <p>
                Edit and update the appointment details below.
            </p>

        </div>


        <div class="header-user">

            <div class="header-user-icon">

                <i class="fa-solid fa-calendar-check"></i>

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
                    Unable to update appointment
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
         UPDATE APPOINTMENT CARD
    ====================================================== -->

    <section class="form-card">


        <!-- FORM HEADER -->

        <div class="form-card-header">

            <div class="form-title-area">

                <div class="form-main-icon">

                    <i class="fa-solid fa-calendar-pen"></i>

                </div>

                <div>

                    <h2>
                        Appointment Information
                    </h2>

                    <p>
                        Update the patient, dentist and schedule details.
                    </p>

                </div>

            </div>


            <!-- APPOINTMENT NUMBER -->

            <div class="appointment-id">

                <span>
                    Appointment No.
                </span>

                <strong>
                    <%= appt.getAppointment_number() %>
                </strong>

            </div>

        </div>


        <!-- =================================================
             FORM
        ================================================== -->

        <form action="<%= contextPath %>/editAppointment"
              method="post"
              class="appointment-form"
              onsubmit="return validateAppointmentForm();">


            <!-- HIDDEN APPOINTMENT ID -->

            <input type="hidden"
                   name="appointmentId"
                   value="<%= appt.getAppointment_id() %>">


            <!-- =================================================
                 PATIENT NAME
            ================================================== -->

            <div class="form-group full-width">

                <label for="patientName">

                    Patient Name

                    <span>*</span>

                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-user input-icon"></i>

                    <input type="text"
                           id="patientName"
                           name="patientName"
                           value="<%= appt.getP_name() != null
                                ? appt.getP_name()
                                : "" %>"
                           placeholder="Enter patient's full name"
                           maxlength="100"
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
                              required><%= appt.getAddress() != null
                                    ? appt.getAddress()
                                    : "" %></textarea>

                </div>

            </div>


            <!-- =================================================
                 CONTACT NUMBER
            ================================================== -->

            <div class="form-group">

                <label for="contactNumber">

                    Contact Number

                    <span>*</span>

                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-phone input-icon"></i>

                    <input type="tel"
                           id="contactNumber"
                           name="contactNumber"
                           value="<%= appt.getC_number() != null
                                ? appt.getC_number()
                                : "" %>"
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
                                disabled
                                <%= appt.getGender() == null
                                    || appt.getGender().trim().isEmpty()
                                    ? "selected"
                                    : "" %>>

                            Select gender

                        </option>

                        <option value="Male"
                            <%= "Male".equals(appt.getGender())
                                ? "selected"
                                : "" %>>

                            Male

                        </option>

                        <option value="Female"
                            <%= "Female".equals(appt.getGender())
                                ? "selected"
                                : "" %>>

                            Female

                        </option>

                        <option value="Other"
                            <%= "Other".equals(appt.getGender())
                                ? "selected"
                                : "" %>>

                            Other

                        </option>

                    </select>

                    <i class="fa-solid fa-chevron-down select-arrow"></i>

                </div>

            </div>


            <!-- =================================================
                 DENTIST
            ================================================== -->

            <div class="form-group full-width">

                <label for="dentistId">

                    Dentist

                    <span>*</span>

                </label>

                <div class="input-wrapper select-wrapper">

                    <i class="fa-solid fa-user-doctor input-icon"></i>

                    <select id="dentistId"
                            name="dentistId"
                            required>

                        <option value=""
                                disabled
                                <%= appt.getD_id() <= 0
                                    ? "selected"
                                    : "" %>>

                            Select dentist

                        </option>


                        <% for (dentist d : dentistList) { %>

                            <option value="<%= d.getDentist_id() %>"
                                <%= d.getDentist_id() == appt.getD_id()
                                    ? "selected"
                                    : "" %>>

                                Dr. <%= d.getDentist_name() %>

                                <% if (d.getSpecialization() != null
                                    && !d.getSpecialization().trim().isEmpty()) { %>

                                    - <%= d.getSpecialization() %>

                                <% } %>

                            </option>

                        <% } %>

                    </select>

                    <i class="fa-solid fa-chevron-down select-arrow"></i>

                </div>

                <small class="field-help">

                    <i class="fa-solid fa-circle-info"></i>

                    Select the dentist assigned to this appointment.

                </small>

            </div>


            <!-- =================================================
                 APPOINTMENT DATE
            ================================================== -->

            <div class="form-group">

                <label for="appointmentDate">

                    Appointment Date

                    <span>*</span>

                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-calendar-days input-icon"></i>

                    <input type="date"
                           id="appointmentDate"
                           name="appointmentDate"
                           value="<%= appointmentDate %>"
                           required>

                </div>

            </div>


            <!-- =================================================
                 APPOINTMENT TIME
            ================================================== -->

            <div class="form-group">

                <label for="appointmentTime">

                    Appointment Time

                    <span>*</span>

                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-clock input-icon"></i>

                    <input type="time"
                           id="appointmentTime"
                           name="appointmentTime"
                           value="<%= appointmentTime %>"
                           required>

                </div>

            </div>


            <!-- =================================================
                 STATUS
            ================================================== -->

            <div class="form-group full-width">

                <label for="status">

                    Appointment Status

                    <span>*</span>

                </label>

                <div class="input-wrapper select-wrapper">

                    <i class="fa-solid fa-circle-check input-icon"></i>

                    <select id="status"
                            name="status"
                            required>

                        <option value="Pending"
                            <%= "Pending".equalsIgnoreCase(currentStatus)
                                ? "selected"
                                : "" %>>

                            Pending

                        </option>

                        <option value="Confirmed"
                            <%= "Confirmed".equalsIgnoreCase(currentStatus)
                                ? "selected"
                                : "" %>>

                            Confirmed

                        </option>

                        <option value="Completed"
                            <%= "Completed".equalsIgnoreCase(currentStatus)
                                ? "selected"
                                : "" %>>

                            Completed

                        </option>

                        <option value="Cancelled"
                            <%= "Cancelled".equalsIgnoreCase(currentStatus)
                                ? "selected"
                                : "" %>>

                            Cancelled

                        </option>

                    </select>

                    <i class="fa-solid fa-chevron-down select-arrow"></i>

                </div>

                <small class="field-help">

                    <i class="fa-solid fa-circle-info"></i>

                    Select the current appointment status.

                </small>

            </div>


            <!-- =================================================
                 TREATMENT NOTE
            ================================================== -->

            <div class="appointment-note full-width">

                <div class="note-icon">

                    <i class="fa-solid fa-circle-info"></i>

                </div>

                <div>

                    <strong>
                        Treatment Information
                    </strong>

                    <p>
                        Treatments selected when the appointment
                        was created cannot be changed from this
                        page. Treatment changes should be handled
                        according to the clinic's appointment policy.
                    </p>

                </div>

            </div>


            <!-- =================================================
                 FORM ACTIONS
            ================================================== -->

            <div class="form-actions">


                <a href="<%= contextPath %>/viewAppointment?id=<%= appt.getAppointment_id() %>"
                   class="secondary-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    Cancel

                </a>


                <div class="right-actions">


                    <button type="button"
                            class="reset-btn"
                            onclick="resetAppointmentForm();">

                        <i class="fa-solid fa-rotate-left"></i>

                        Reset Changes

                    </button>


                    <button type="submit"
                            class="primary-btn">

                        <i class="fa-solid fa-floppy-disk"></i>

                        Save Changes

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
                Appointment Information & Privacy
            </h3>

            <p>
                Please verify all appointment information
                carefully before saving. Patient and appointment
                records should be handled confidentially and
                accessed only for authorized clinic management
                purposes.
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

    // =========================================================
    // VALIDATE APPOINTMENT FORM
    // =========================================================

    function validateAppointmentForm() {

        const patientName =
            document.getElementById("patientName").value.trim();

        const address =
            document.getElementById("address").value.trim();

        const contact =
            document.getElementById("contactNumber").value.trim();

        const gender =
            document.getElementById("gender").value;

        const dentist =
            document.getElementById("dentistId").value;

        const appointmentDate =
            document.getElementById("appointmentDate").value;

        const appointmentTime =
            document.getElementById("appointmentTime").value;

        const status =
            document.getElementById("status").value;


        if (patientName === "") {

            alert("Please enter the patient name.");

            document.getElementById("patientName").focus();

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

            document.getElementById("contactNumber").focus();

            return false;
        }


        if (gender === "") {

            alert("Please select the patient's gender.");

            document.getElementById("gender").focus();

            return false;
        }


        if (dentist === "") {

            alert("Please select a dentist.");

            document.getElementById("dentistId").focus();

            return false;
        }


        if (appointmentDate === "") {

            alert("Please select the appointment date.");

            document.getElementById("appointmentDate").focus();

            return false;
        }


        if (appointmentTime === "") {

            alert("Please select the appointment time.");

            document.getElementById("appointmentTime").focus();

            return false;
        }


        if (status === "") {

            alert("Please select the appointment status.");

            document.getElementById("status").focus();

            return false;
        }


        return true;
    }


    // =========================================================
    // NUMBERS ONLY - CONTACT NUMBER
    // =========================================================

    document.getElementById("contactNumber")
        .addEventListener("input", function () {

            this.value =
                this.value.replace(/[^0-9]/g, "");

        });


    // =========================================================
    // STORE ORIGINAL VALUES
    // =========================================================

    const originalAppointmentValues = {

        patientName:
            document.getElementById("patientName").value,

        address:
            document.getElementById("address").value,

        contactNumber:
            document.getElementById("contactNumber").value,

        gender:
            document.getElementById("gender").value,

        dentistId:
            document.getElementById("dentistId").value,

        appointmentDate:
            document.getElementById("appointmentDate").value,

        appointmentTime:
            document.getElementById("appointmentTime").value,

        status:
            document.getElementById("status").value
    };


    // =========================================================
    // RESET FORM
    // =========================================================

    function resetAppointmentForm() {

        const confirmed =
            confirm(
                "Are you sure you want to discard your changes?"
            );

        if (!confirmed) {

            return;
        }


        document.getElementById("patientName").value =
            originalAppointmentValues.patientName;

        document.getElementById("address").value =
            originalAppointmentValues.address;

        document.getElementById("contactNumber").value =
            originalAppointmentValues.contactNumber;

        document.getElementById("gender").value =
            originalAppointmentValues.gender;

        document.getElementById("dentistId").value =
            originalAppointmentValues.dentistId;

        document.getElementById("appointmentDate").value =
            originalAppointmentValues.appointmentDate;

        document.getElementById("appointmentTime").value =
            originalAppointmentValues.appointmentTime;

        document.getElementById("status").value =
            originalAppointmentValues.status;
    }

</script>

</body>

</html>