<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bill" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
        return;
    }

    String contextPath = request.getContextPath();

    List<bill> billList = (List<bill>) request.getAttribute("billList");

    if (billList == null) {
        response.sendRedirect(contextPath + "/manageBilling");
        return;
    }

    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";

    Integer totalBillsObj = (Integer) request.getAttribute("totalBills");
    int totalBills = totalBillsObj != null ? totalBillsObj : billList.size();

    BigDecimal totalRevenue = (BigDecimal) request.getAttribute("totalRevenue");
    if (totalRevenue == null) totalRevenue = BigDecimal.ZERO;

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Billing | Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/adappointments.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>

<body>


<!-- =========================================================
     TOP NAVBAR
========================================================= -->

<header class="top-navbar">

    <div class="brand">

        <div class="brand-icon">
            <i class="fa-solid fa-tooth"></i>
        </div>

        <div class="brand-text">
            <h2>Sunrise Dental</h2>
            <span>Clinic Management</span>
        </div>

    </div>


    <nav class="navigation">

        <a href="${pageContext.request.contextPath}/adminhomes.jsp">
            <i class="fa-solid fa-chart-line"></i>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/managePatients">
            <i class="fa-solid fa-user-group"></i>
            Patients
        </a>

        <a href="${pageContext.request.contextPath}/manageAppointments">
            <i class="fa-solid fa-calendar-check"></i>
            Appointments
        </a>

        <a href="${pageContext.request.contextPath}/adbilling.jsp"
        class="active">
            <i class="fa-solid fa-file-invoice-dollar"></i>
            Billing
        </a>

        <a href="#">
            <i class="fa-solid fa-headphones"></i>
            Help & Support
        </a>

    </nav>


    <div class="admin-area">

        <div class="admin-icon">
            <i class="fa-solid fa-user-shield"></i>
        </div>

        <div class="admin-details">
            <strong><%= session.getAttribute("loggedInAdmin") %></strong>
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


    <section class="page-header">

        <div>
            <span class="page-label">BILLING MANAGEMENT</span>
            <h1>Billing</h1>
            <p>View, search and print patient appointment bills.</p>
        </div>

        <div class="header-user">

            <div class="header-user-icon">
                <i class="fa-solid fa-file-invoice-dollar"></i>
            </div>

            <div>
                <span>Welcome back</span>
                <strong><%= session.getAttribute("loggedInAdmin") %></strong>
            </div>

        </div>

    </section>


    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert error-alert">
            <i class="fa-solid fa-circle-exclamation"></i>
            <span><%= request.getAttribute("errorMessage") %></span>
        </div>
    <% } %>


    <!-- =====================================================
         SUMMARY
    ====================================================== -->

    <section class="summary-grid">

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fa-solid fa-file-invoice-dollar"></i>
            </div>
            <div class="summary-content">
                <span>Total Bills</span>
                <strong><%= totalBills %></strong>
                <small>Generated from appointments</small>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fa-solid fa-sack-dollar"></i>
            </div>
            <div class="summary-content">
                <span>Total Revenue</span>
                <strong>
                    LKR <%= String.format("%,.2f", totalRevenue) %>
                </strong>
                <small>Across all appointments</small>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fa-solid fa-tooth"></i>
            </div>
            <div class="summary-content">
                <span>Consultation Fee</span>
                <strong>LKR 500.00</strong>
                <small>Applied to every bill</small>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fa-solid fa-shield-heart"></i>
            </div>
            <div class="summary-content">
                <span>System Status</span>
                <strong>Active</strong>
                <small>Secure billing system</small>
            </div>
        </div>

    </section>



    <!-- =====================================================
         BILL TABLE CARD
    ====================================================== -->

    <section class="content-card">

        <div class="table-header">

            <div class="section-heading">
                <span class="section-label">BILL RECORDS</span>
                <h2>Appointment Bills</h2>
                <p>Search and print bills generated from appointments.</p>
            </div>

            <div class="header-actions">

                <form method="get"
                      action="${pageContext.request.contextPath}/manageBilling"
                      class="search-box">

                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input type="text"
                           name="keyword"
                           placeholder="Search by bill no, patient, or phone..."
                           value="<%= keyword %>">

                    <button type="submit"
                            style="border:none; background:none; cursor:pointer;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>

                </form>

            </div>

        </div>


        <div class="table-container">

            <table class="appointment-table" id="billTable">

                <thead>
                    <tr>
                        <th>#</th>
                        <th>Bill No</th>
                        <th>Patient</th>
                        <th>Dentist</th>
                        <th>Date & Time</th>
                        <th>Treatment Total</th>
                        <th>Grand Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>

                <% if (billList != null && !billList.isEmpty()) { %>

                    <%
                        int rowNumber = 1;

                        for (bill b : billList) {
                    %>

                    <tr>

                        <td>
                            <span class="row-number"><%= rowNumber++ %></span>
                        </td>

                        <td>
                            <div class="appointment-number">
                                <div class="appointment-icon">
                                    <i class="fa-solid fa-hashtag"></i>
                                </div>
                                <div>
                                    <strong><%= b.getAppointment_number() %></strong>
                                    <small>ID: <%= b.getAppointment_id() %></small>
                                </div>
                            </div>
                        </td>

                        <td>
                            <div class="patient-info">
                                <div class="patient-avatar">
                                    <i class="fa-solid fa-user"></i>
                                </div>
                                <div>
                                    <strong><%= b.getP_name() %></strong>
                                    <small><%= b.getC_number() %></small>
                                </div>
                            </div>
                        </td>

                        <td>
                            <div class="dentist-info">
                                <div class="dentist-icon">
                                    <i class="fa-solid fa-user-doctor"></i>
                                </div>
                                <span>Dr. <%= b.getDentist_name() %></span>
                            </div>
                        </td>

                        <td>
                            <div class="datetime-info">
                                <strong>
                                    <% if (b.getAppointment_datetime() != null) { %>
                                        <%= dateFormat.format(b.getAppointment_datetime()) %>
                                    <% } %>
                                </strong>
                                <span>
                                    <% if (b.getAppointment_datetime() != null) { %>
                                        <i class="fa-regular fa-clock"></i>
                                        <%= timeFormat.format(b.getAppointment_datetime()) %>
                                    <% } %>
                                </span>
                            </div>
                        </td>

                        <td>
                            LKR <%= String.format("%,.2f", b.getTreatment_total()) %>
                        </td>

                        <td>
                            <strong>
                                LKR <%= String.format("%,.2f", b.getGrand_total()) %>
                            </strong>
                        </td>

                        <td>

                            <%
                                String status = b.getStatus();
                                String statusClass = "pending";

                                if ("Completed".equalsIgnoreCase(status)) {
                                    statusClass = "completed";
                                } else if ("Cancelled".equalsIgnoreCase(status)) {
                                    statusClass = "cancelled";
                                } else if ("Confirmed".equalsIgnoreCase(status)) {
                                    statusClass = "confirmed";
                                }
                            %>

                            <span class="status-badge <%= statusClass %>">
                                <i class="fa-solid fa-circle"></i>
                                <%= status != null ? status : "Pending" %>
                            </span>

                        </td>

                        <td>

                            <div class="action-buttons">

                                <a href="${pageContext.request.contextPath}/viewAppointment?id=<%= b.getAppointment_id() %>"
                                   class="action-btn view-btn"
                                   title="View Appointment">
                                    <i class="fa-solid fa-eye"></i>
                                </a>
                                

                                <a href="${pageContext.request.contextPath}/printBill?id=<%= b.getAppointment_id() %>"
                                   class="action-btn edit-btn"
                                   title="Print Bill"
                                   target="_blank">
                                    <i class="fa-solid fa-print"></i>
                                </a>

                            </div>

                        </td>

                    </tr>

                    <% } %>

                <% } else { %>

                    <tr>
                        <td colspan="9">
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fa-solid fa-file-invoice-dollar"></i>
                                </div>
                                <h3>No Bills Found</h3>
                                <p>
                                    <% if (!keyword.isEmpty()) { %>
                                        No bills match "<%= keyword %>".
                                    <% } else { %>
                                        There are currently no appointment bills.
                                    <% } %>
                                </p>
                            </div>
                        </td>
                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>


        <div class="table-footer">

            <span>
                Showing
                <strong><%= billList.size() %></strong>
                bill(s)
            </span>

            <span>
                Sunrise Dental Clinic
                <i class="fa-solid fa-tooth"></i>
            </span>

        </div>

    </section>


    <footer>
        <span>© 2026 Sunrise Dental Clinic. All Rights Reserved.</span>
        <span>Clinic Management System</span>
    </footer>


</main>

</body>
</html>