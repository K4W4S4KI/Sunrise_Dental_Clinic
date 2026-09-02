<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.appointment" %>
<%@ page import="model.dentist" %>

<%
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
        return;
    }

    String contextPath = request.getContextPath();

    appointment appt = (appointment) request.getAttribute("appt");
    List<dentist> dentistList = (List<dentist>) request.getAttribute("dentistList");

    if (appt == null) {
        response.sendRedirect(contextPath + "/manageAppointments");
        return;
    }

    if (dentistList == null) {
        dentistList = new ArrayList<dentist>();
    }

    String errorMessage = (String) session.getAttribute("errorMessage");
    session.removeAttribute("errorMessage");

    SimpleDateFormat dateInputFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeInputFormat = new SimpleDateFormat("HH:mm");

    String currentDate = appt.getAppointment_datetime() != null
            ? dateInputFormat.format(appt.getAppointment_datetime()) : "";

    String currentTime = appt.getAppointment_datetime() != null
            ? timeInputFormat.format(appt.getAppointment_datetime()) : "";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Appointment | Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="<%= contextPath %>/CSS/addappointment.css">
</head>
<body>

<div class="page-wrapper">

    <div class="page-header">
        <div>
            <div class="page-title">Edit Appointment</div>
            <div class="page-subtitle"><%= appt.getAppointment_number() %></div>
        </div>
        <a href="<%= contextPath %>/manageAppointments" class="back-btn">
            ← Back to Appointments
        </a>
    </div>

    <% if (errorMessage != null) { %>
        <div class="alert error"><%= errorMessage %></div>
    <% } %>

    <form method="post" action="<%= contextPath %>/editAppointment">

        <input type="hidden" name="appointmentId" value="<%= appt.getAppointment_id() %>">

        <!-- PATIENT -->
        <div class="card">
            <div class="section-title">
                <div class="section-number">01</div>
                <div><h2>Patient Information</h2></div>
            </div>

            <div class="form-grid">
                <div class="input-group">
                    <label>Patient Name <span>*</span></label>
                    <input type="text" name="patientName"
                           value="<%= appt.getP_name() != null ? appt.getP_name() : "" %>" required>
                </div>
                <div class="input-group">
                    <label>Gender</label>
                    <select name="gender">
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equals(appt.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(appt.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(appt.getGender()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>Contact Number <span>*</span></label>
                    <input type="text" name="contactNumber"
                           value="<%= appt.getC_number() != null ? appt.getC_number() : "" %>" required>
                </div>
                <div class="input-group full-width">
                    <label>Address</label>
                    <textarea name="address" rows="3"><%= appt.getAddress() != null ? appt.getAddress() : "" %></textarea>
                </div>
            </div>
        </div>

        <!-- DENTIST -->
        <div class="card">
            <div class="section-title">
                <div class="section-number">02</div>
                <div><h2>Select Dentist</h2></div>
            </div>

            <div class="input-group">
                <label>Dentist <span>*</span></label>
                <select name="dentistId" required>
                    <option value="">-- Select Dentist --</option>
                    <% for (dentist d : dentistList) { %>
                        <option value="<%= d.getDentist_id() %>"
                            <%= d.getDentist_id() == appt.getD_id() ? "selected" : "" %>>
                            Dr. <%= d.getDentist_name() %>
                            <% if (d.getSpecialization() != null && !d.getSpecialization().trim().isEmpty()) { %>
                                - <%= d.getSpecialization() %>
                            <% } %>
                        </option>
                    <% } %>
                </select>
            </div>
        </div>

        <!-- SCHEDULE -->
        <div class="card">
            <div class="section-title">
                <div class="section-number">03</div>
                <div><h2>Appointment Schedule</h2></div>
            </div>

            <div class="form-grid">
                <div class="input-group">
                    <label>Appointment Date <span>*</span></label>
                    <input type="date" name="appointmentDate" value="<%= currentDate %>" required>
                </div>
                <div class="input-group">
                    <label>Appointment Time <span>*</span></label>
                    <input type="time" name="appointmentTime" value="<%= currentTime %>" required>
                </div>
            </div>
        </div>

        <!-- STATUS -->
        <div class="card">
            <div class="section-title">
                <div class="section-number">04</div>
                <div><h2>Status</h2></div>
            </div>

            <div class="input-group">
                <label>Appointment Status <span>*</span></label>
                <select name="status" required>
                    <% String[] statuses = {"Pending", "Confirmed", "Completed", "Cancelled"}; %>
                    <% for (String s : statuses) { %>
                        <option value="<%= s %>" <%= s.equalsIgnoreCase(appt.getStatus()) ? "selected" : "" %>>
                            <%= s %>
                        </option>
                    <% } %>
                </select>
            </div>

            <p style="color:#888; font-size:13px; margin-top:10px;">
                Note: treatments selected at booking time cannot be changed here.
                To modify treatments, cancel this appointment and create a new one.
            </p>
        </div>

        <div class="form-actions">
            <a href="<%= contextPath %>/viewAppointment?id=<%= appt.getAppointment_id() %>"
               class="cancel-btn" style="text-decoration:none; display:inline-block; text-align:center;">
                Cancel
            </a>
            <button type="submit" class="submit-btn">
                ✓ Save Changes
            </button>
        </div>

    </form>

</div>

</body>
</html>