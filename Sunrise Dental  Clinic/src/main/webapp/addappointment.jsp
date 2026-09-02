
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dentist" %>
<%@ page import="model.treatment" %>

<%

String contextPath = request.getContextPath();

ArrayList<dentist> dentistList =
        (ArrayList<dentist>)
        request.getAttribute("dentistList");

ArrayList<treatment> treatmentList =
        (ArrayList<treatment>)
        request.getAttribute("treatmentList");

// -----------------------------------------------------
// GUARD: if this page was opened directly (not forwarded
// by the servlet), dentistList/treatmentList will be null.
// Redirect to the servlet so the data actually loads.
// -----------------------------------------------------
if (dentistList == null && request.getParameter("success") == null
        && request.getParameter("error") == null) {

    response.sendRedirect(contextPath + "/addappointment");
    return;
}

String success =
        request.getParameter("success");

String error =
        request.getParameter("error");

if (dentistList == null) {
    dentistList = new ArrayList<dentist>();
}

if (treatmentList == null) {
    treatmentList = new ArrayList<treatment>();
}

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Add Appointment | Sunrise Dental Clinic
    </title>

    <link rel="stylesheet"
          href="<%= contextPath %>/CSS/addappointment.css">

</head>

<body>

<div class="page-wrapper">

    <!-- ================================================= -->
    <!-- HEADER -->
    <!-- ================================================= -->

    <div class="page-header">

        <div>

            <div class="page-title">
                Add New Appointment
            </div>

            <div class="page-subtitle">
                Register a patient and schedule a dental appointment
            </div>

        </div>

        <a href="<%= contextPath %>/adappointments.jsp"
           class="back-btn">

            ← Back to Appointments

        </a>

    </div>


    <!-- ================================================= -->
    <!-- ALERTS -->
    <!-- ================================================= -->

    <% if ("true".equals(success)) { %>

        <div class="alert success">
            ✓ Appointment created successfully.
        </div>

    <% } %>


    <% if ("phone".equals(error)) { %>

        <div class="alert error">
            Please enter a patient contact number.
        </div>

    <% } else if ("name".equals(error)) { %>

        <div class="alert error">
            Please enter the patient name.
        </div>

    <% } else if ("dentist".equals(error)) { %>

        <div class="alert error">
            Please select a dentist.
        </div>

    <% } else if ("datetime".equals(error)) { %>

        <div class="alert error">
            Please select appointment date and time.
        </div>

    <% } else if ("treatment".equals(error)) { %>

        <div class="alert error">
            Please select at least one treatment.
        </div>

    <% } else if ("unavailable".equals(error)) { %>

        <div class="alert error">
            The selected dentist is not available at this date and time.
            Please select another time.
        </div>

    <% } else if ("create".equals(error)) { %>

        <div class="alert error">
            Appointment could not be created.
        </div>

    <% } else if ("system".equals(error)) { %>

        <div class="alert error">
            A system error occurred. Please try again.
        </div>

    <% } %>


    <!-- ================================================= -->
    <!-- FORM -->
    <!-- ================================================= -->

    <form method="post"
          action="<%= contextPath %>/addappointment"
          id="appointmentForm">


        <!-- ================================================= -->
        <!-- PATIENT SECTION -->
        <!-- ================================================= -->

        <div class="card">

            <div class="section-title">

                <div class="section-number">
                    01
                </div>

                <div>

                    <h2>
                        Patient Information
                    </h2>

                    <p>
                        Check whether the patient is already registered
                    </p>

                </div>

            </div>


            <!-- PHONE SEARCH -->

            <div class="phone-search">

                <div class="input-group">

                    <label>
                        Contact Number
                        <span>*</span>
                    </label>

                    <input type="text"
                           id="phone"
                           name="phone"
                           placeholder="Enter patient phone number"
                           maxlength="20"
                           required>

                </div>

                <button type="button"
                        class="check-btn"
                        onclick="checkPatient()">

                    🔍 Check Patient

                </button>

            </div>


            <div id="patientMessage"
                 class="patient-message">
            </div>


            <!-- PATIENT ID -->

            <input type="hidden"
                   id="patientId"
                   name="patientId">


            <!-- PATIENT DETAILS -->

            <div class="form-grid">


                <div class="input-group">

                    <label>

                        Patient Name
                        <span>*</span>

                    </label>

                    <input type="text"
                           id="patientName"
                           name="patientName"
                           placeholder="Patient full name"
                           required>

                </div>


                <div class="input-group">

                    <label>
                        Gender
                    </label>

                    <select id="gender"
                            name="gender">

                        <option value="">
                            Select Gender
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


                <div class="input-group full-width">

                    <label>
                        Address
                    </label>

                    <textarea id="address"
                              name="address"
                              placeholder="Patient address"
                              rows="3"></textarea>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- DENTIST SECTION -->
        <!-- ================================================= -->

        <div class="card">

            <div class="section-title">

                <div class="section-number">
                    02
                </div>

                <div>

                    <h2>
                        Select Dentist
                    </h2>

                    <p>
                        Choose the dentist for this appointment
                    </p>

                </div>

            </div>


            <div class="input-group">

                <label for="dentistId">

                    Dentist
                    <span>*</span>

                </label>


                <select id="dentistId"
                        name="dentistId"
                        required>

                    <option value="">
                        -- Select Dentist --
                    </option>


                    <%
                        if (dentistList != null &&
                            !dentistList.isEmpty()) {

                            for (dentist d : dentistList) {
                    %>


                        <option value="<%= d.getDentist_id() %>">

                            Dr.
                            <%= d.getDentist_name() %>

                            <% if (d.getSpecialization() != null &&
                                   !d.getSpecialization().trim().isEmpty()) { %>

                                -
                                <%= d.getSpecialization() %>

                            <% } %>

                        </option>


                    <%
                            }

                        } else {
                    %>


                        <option value="" disabled>
                            No active dentists available
                        </option>


                    <%
                        }
                    %>

                </select>


                <% if (dentistList == null ||
                       dentistList.isEmpty()) { %>

                    <small class="field-warning">

                        No active dentists available.

                    </small>

                <% } %>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- APPOINTMENT DATE AND TIME -->
        <!-- ================================================= -->

        <div class="card">

            <div class="section-title">

                <div class="section-number">
                    03
                </div>

                <div>

                    <h2>
                        Appointment Schedule
                    </h2>

                    <p>
                        Select the appointment date and time
                    </p>

                </div>

            </div>


            <div class="form-grid">


                <div class="input-group">

                    <label>

                        Appointment Date
                        <span>*</span>

                    </label>

                    <input type="date"
                           name="appointmentDate"
                           id="appointmentDate"
                           required>

                </div>


                <div class="input-group">

                    <label>

                        Appointment Time
                        <span>*</span>

                    </label>

                    <input type="time"
                           name="appointmentTime"
                           id="appointmentTime"
                           required>

                </div>


            </div>

        </div>


        <!-- ================================================= -->
        <!-- TREATMENTS -->
        <!-- ================================================= -->

        <div class="card">

            <div class="section-title">

                <div class="section-number">
                    04
                </div>

                <div>

                    <h2>
                        Select Treatments
                    </h2>

                    <p>
                        You can select multiple treatments
                    </p>

                </div>

            </div>


            <div class="treatment-grid">


                <%
                    if (treatmentList != null &&
                        !treatmentList.isEmpty()) {

                        for (treatment t : treatmentList) {
                %>


                    <label class="treatment-item">

                        <input type="checkbox"
                               name="treatmentIds"
                               value="<%= t.getTreatment_id() %>"
                               data-price="<%= t.getTreatment_priceLkr() %>"
                               data-name="<%= t.getTreatment_name() %>"
                               onchange="calculateTotal()">


                        <div class="treatment-info">

                            <strong>

                                <%= t.getTreatment_name() %>

                            </strong>

                            <span>

                                LKR
                                <%= String.format(
                                        "%,.2f",
                                        t.getTreatment_priceLkr()
                                ) %>

                            </span>

                        </div>

                    </label>


                <%
                        }

                    } else {
                %>


                    <div class="no-data">

                        No active treatments available.

                    </div>


                <%
                    }
                %>


            </div>


            <!-- ================================================= -->
            <!-- BILL SUMMARY -->
            <!-- ================================================= -->

            <div class="bill-summary">


                <div class="bill-row">

                    <span>
                        Selected Treatments
                    </span>

                    <strong id="selectedCount">
                        0
                    </strong>

                </div>


                <div class="bill-row">

                    <span>
                        Treatment Total
                    </span>

                    <strong id="treatmentTotal">
                        LKR 0.00
                    </strong>

                </div>


                <div class="bill-row">

                    <span>
                        Consultation Fee
                    </span>

                    <strong>
                        LKR 500.00
                    </strong>

                </div>


                <div class="bill-divider">
                </div>


                <div class="bill-total">

                    <span>
                        Grand Total
                    </span>

                    <strong id="grandTotal">
                        LKR 500.00
                    </strong>

                </div>


            </div>

        </div>


        <!-- ================================================= -->
        <!-- BUTTONS -->
        <!-- ================================================= -->

        <div class="form-actions">

            <button type="reset"
                    class="cancel-btn"
                    onclick="resetForm()">

                Clear Form

            </button>


            <button type="submit"
                    class="submit-btn">

                ✓ Create Appointment

            </button>

        </div>


    </form>

</div>


<script>

const contextPath =
        '<%= contextPath %>';


// =========================================================
// CHECK PATIENT
// =========================================================

function checkPatient() {

    const phone =
            document.getElementById("phone")
                    .value.trim();

    const message =
            document.getElementById(
                    "patientMessage"
            );


    if (phone === "") {

        message.className =
                "patient-message error-message";

        message.innerHTML =
                "Please enter a contact number.";

        return;
    }


    message.className =
            "patient-message loading-message";

    message.innerHTML =
            "Checking patient...";


    fetch(
        contextPath
        + "/checkPatient?phone="
        + encodeURIComponent(phone)
    )

    .then(response => {

        if (!response.ok) {
            throw new Error(
                "HTTP error " + response.status
            );
        }

        return response.json();

    })

    .then(data => {


        if (data.found) {

            // Existing patient

            document.getElementById(
                "patientId"
            ).value = data.p_id;


            document.getElementById(
                "patientName"
            ).value = data.p_name || "";


            document.getElementById(
                "address"
            ).value = data.address || "";


            document.getElementById(
                "phone"
            ).value = data.c_number || "";


            document.getElementById(
                "gender"
            ).value = data.gender || "";


            document.getElementById(
                "patientName"
            ).readOnly = true;


            document.getElementById(
                "address"
            ).readOnly = true;


            document.getElementById(
                "phone"
            ).readOnly = true;


            /*
             * DO NOT disable gender.
             * Disabled fields are not submitted.
             * Instead make it readonly using JS.
             */
            document.getElementById(
                "gender"
            ).style.pointerEvents = "none";


            message.className =
                    "patient-message success-message";


            message.innerHTML =
                    "✓ Existing patient found. Patient details loaded automatically.";

        }

        else {

            // New patient

            document.getElementById(
                "patientId"
            ).value = "";


            document.getElementById(
                "patientName"
            ).value = "";


            document.getElementById(
                "address"
            ).value = "";


            document.getElementById(
                "gender"
            ).value = "";


            document.getElementById(
                "patientName"
            ).readOnly = false;


            document.getElementById(
                "address"
            ).readOnly = false;


            document.getElementById(
                "phone"
            ).readOnly = false;


            document.getElementById(
                "gender"
            ).style.pointerEvents = "auto";


            message.className =
                    "patient-message new-patient-message";


            message.innerHTML =
                    "＋ Patient not registered. Please enter the patient details below.";

        }

    })

    .catch(error => {

        console.error(
            "Patient check error:",
            error
        );

        message.className =
                "patient-message error-message";

        message.innerHTML =
                "Unable to check patient. Please try again.";

    });
}


// =========================================================
// CALCULATE TOTAL
// =========================================================

function calculateTotal() {

    const treatments =
            document.querySelectorAll(
                'input[name="treatmentIds"]:checked'
            );


    let treatmentTotal = 0;


    treatments.forEach(function(item) {

        treatmentTotal +=
                parseFloat(
                    item.dataset.price
                ) || 0;

    });


    const consultationFee = 500;


    const grandTotal =
            treatmentTotal
            + consultationFee;


    document.getElementById(
        "selectedCount"
    ).innerText =
            treatments.length;


    document.getElementById(
        "treatmentTotal"
    ).innerText =
            "LKR "
            + formatMoney(treatmentTotal);


    document.getElementById(
        "grandTotal"
    ).innerText =
            "LKR "
            + formatMoney(grandTotal);
}


// =========================================================
// MONEY FORMAT
// =========================================================

function formatMoney(value) {

    return value.toLocaleString(
        "en-LK",
        {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }
    );
}


// =========================================================
// RESET
// =========================================================

function resetForm() {

    setTimeout(function() {

        document.getElementById(
            "patientId"
        ).value = "";


        document.getElementById(
            "patientName"
        ).readOnly = false;


        document.getElementById(
            "address"
        ).readOnly = false;


        document.getElementById(
            "phone"
        ).readOnly = false;


        document.getElementById(
            "gender"
        ).style.pointerEvents = "auto";


        document.getElementById(
            "patientMessage"
        ).innerHTML = "";


        calculateTotal();

    }, 50);
}


// =========================================================
// PAGE LOAD
// =========================================================

window.addEventListener(
    "DOMContentLoaded",
    function() {

        const dateInput =
                document.getElementById(
                    "appointmentDate"
                );


        const today =
                new Date()
                    .toISOString()
                    .split("T")[0];


        dateInput.min = today;


        calculateTotal();

    }
);


// =========================================================
// FORM VALIDATION
// =========================================================

document.getElementById(
    "appointmentForm"
).addEventListener(
    "submit",
    function(event) {

        const treatments =
                document.querySelectorAll(
                    'input[name="treatmentIds"]:checked'
                );


        if (treatments.length === 0) {

            event.preventDefault();

            alert(
                "Please select at least one treatment."
            );

            return;
        }


        const dentist =
                document.getElementById(
                    "dentistId"
                ).value;


        if (dentist === "") {

            event.preventDefault();

            alert(
                "Please select a dentist."
            );

            return;
        }


        const date =
                document.getElementById(
                    "appointmentDate"
                ).value;


        const time =
                document.getElementById(
                    "appointmentTime"
                ).value;


        if (date === "" || time === "") {

            event.preventDefault();

            alert(
                "Please select appointment date and time."
            );

            return;
        }

    }
);

</script>


</body>

</html>

