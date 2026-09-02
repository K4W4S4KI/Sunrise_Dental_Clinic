<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.appointment" %>
<%@ page import="model.dentist" %>
<%@ page import="model.treatment" %>

<%
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
        return;
    }

    String contextPath = request.getContextPath();

    appointment appt = (appointment) request.getAttribute("appt");
    dentist d = (dentist) request.getAttribute("dentist");
    List<treatment> treatments = (List<treatment>) request.getAttribute("treatments");
    BigDecimal billTotal = (BigDecimal) request.getAttribute("billTotal");
    BigDecimal consultationFee = (BigDecimal) request.getAttribute("consultationFee");

    if (appt == null) {
        response.sendRedirect(contextPath + "/manageAppointments");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Appointment | Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="<%= contextPath %>/CSS/addappointment.css">
</head>
<body>

<div class="page-wrapper">

    <div class="page-header">
        <div>
            <div class="page-title">Appointment Details</div>
            <div class="page-subtitle">
                <%= appt.getAppointment_number() %>
            </div>
        </div>
        <a href="<%= contextPath %>/manageAppointments" class="back-btn">
            ← Back to Appointments
        </a>
    </div>

    <!-- PATIENT -->
    <div class="card">
        <div class="section-title">
            <div class="section-number">01</div>
            <div><h2>Patient Information</h2></div>
        </div>

        <div class="form-grid">
            <div class="input-group">
                <label>Patient Name</label>
                <p><%= appt.getP_name() %></p>
            </div>
            <div class="input-group">
                <label>Gender</label>
                <p><%= appt.getGender() != null ? appt.getGender() : "-" %></p>
            </div>
            <div class="input-group">
                <label>Contact Number</label>
                <p><%= appt.getC_number() %></p>
            </div>
            <div class="input-group full-width">
                <label>Address</label>
                <p><%= appt.getAddress() != null ? appt.getAddress() : "-" %></p>
            </div>
        </div>
    </div>

    <!-- DENTIST -->
    <div class="card">
        <div class="section-title">
            <div class="section-number">02</div>
            <div><h2>Dentist</h2></div>
        </div>

        <div class="form-grid">
            <div class="input-group">
                <label>Dentist</label>
                <p>
                    <%= d != null ? "Dr. " + d.getDentist_name() : "Dentist #" + appt.getD_id() %>
                </p>
            </div>
            <div class="input-group">
                <label>Specialization</label>
                <p><%= (d != null && d.getSpecialization() != null) ? d.getSpecialization() : "-" %></p>
            </div>
        </div>
    </div>

    <!-- SCHEDULE -->
    <div class="card">
        <div class="section-title">
            <div class="section-number">03</div>
            <div><h2>Schedule</h2></div>
        </div>

        <div class="form-grid">
            <div class="input-group">
                <label>Date</label>
                <p>
                    <%= appt.getAppointment_datetime() != null
                        ? dateFormat.format(appt.getAppointment_datetime())
                        : "-" %>
                </p>
            </div>
            <div class="input-group">
                <label>Time</label>
                <p>
                    <%= appt.getAppointment_datetime() != null
                        ? timeFormat.format(appt.getAppointment_datetime())
                        : "-" %>
                </p>
            </div>
            <div class="input-group">
                <label>Status</label>
                <p><%= appt.getStatus() != null ? appt.getStatus() : "Pending" %></p>
            </div>
        </div>
    </div>

    <!-- TREATMENTS -->
    <div class="card">
        <div class="section-title">
            <div class="section-number">04</div>
            <div><h2>Treatments</h2></div>
        </div>

        <table style="width:100%; border-collapse:collapse;">
            <thead>
                <tr>
                    <th style="text-align:left; padding:8px; border-bottom:1px solid #eee;">Treatment</th>
                    <th style="text-align:right; padding:8px; border-bottom:1px solid #eee;">Price (LKR)</th>
                </tr>
            </thead>
            <tbody>
                <% if (treatments != null && !treatments.isEmpty()) {
                       for (treatment t : treatments) { %>
                <tr>
                    <td style="padding:8px; border-bottom:1px solid #f5f5f5;">
                        <%= t.getTreatment_name() %>
                    </td>
                    <td style="text-align:right; padding:8px; border-bottom:1px solid #f5f5f5;">
                        <%= String.format("%,.2f", t.getTreatment_priceLkr()) %>
                    </td>
                </tr>
                <% } } else { %>
                <tr><td colspan="2" style="padding:8px;">No treatments recorded.</td></tr>
                <% } %>
                <tr>
                    <td style="padding:8px;">Consultation Fee</td>
                    <td style="text-align:right; padding:8px;">
                        <%= String.format("%,.2f", consultationFee) %>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td style="padding:8px; font-weight:bold; border-top:2px solid #ddd;">Grand Total</td>
                    <td style="text-align:right; padding:8px; font-weight:bold; border-top:2px solid #ddd;">
                        LKR <%= String.format("%,.2f", billTotal) %>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div class="form-actions">
        <a href="<%= contextPath %>/editAppointment?id=<%= appt.getAppointment_id() %>"
           class="submit-btn" style="text-decoration:none; display:inline-block; text-align:center;">
            ✎ Edit Appointment
        </a>
    </div>

</div>

</body>
</html>