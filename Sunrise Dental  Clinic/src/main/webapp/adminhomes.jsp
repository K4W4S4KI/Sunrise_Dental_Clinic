<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.math.BigDecimal" %>

<%
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/adlogin.jsp");
        return;
    }

    Integer totalPatients =
            (Integer) request.getAttribute("totalPatients");

    Integer totalAppointments =
            (Integer) request.getAttribute("totalAppointments");

    Integer todayAppointments =
            (Integer) request.getAttribute("todayAppointments");

    BigDecimal totalRevenue =
            (BigDecimal) request.getAttribute("totalRevenue");

    if (totalPatients == null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard | Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/adminhomes.css">

    <!-- Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>

<body>

<!-- ================= TOP NAVBAR ================= -->

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

        <a href="${pageContext.request.contextPath}/dashboard"
           class="active">
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

                <a href="${pageContext.request.contextPath}/manageBilling">
            <i class="fa-solid fa-file-invoice-dollar"></i>
            Billing
        </a>

        <a href="${pageContext.request.contextPath}/helpSupport">
            <i class="fa-solid fa-headphones"></i>
            Help & Support
        </a>

    </nav>


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


<!-- ================= MAIN CONTENT ================= -->

<main class="main-content">


    <!-- PAGE HEADER -->

    <section class="page-header">

        <div>

            <span class="page-label">
                ADMINISTRATION
            </span>

            <h1>Dashboard</h1>

            <p>
                Manage patients, appointments and clinic services
                efficiently from your dashboard.
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


    <!-- ================= WELCOME ================= -->

    <section class="welcome-card">

        <div class="welcome-text">

            <span>WELCOME TO SUNRISE DENTAL</span>

            <h2>
                Hello, <%= session.getAttribute("loggedInAdmin") %>!
            </h2>

            <p>
                Manage your clinic operations quickly and easily
                from one place.
            </p>

        </div>

        <a href="${pageContext.request.contextPath}/addappointment" class="primary-btn">
            <i class="fa-solid fa-calendar-plus"></i>
            New Appointment
        </a>

    </section>


    <!-- ================= STATISTICS ================= -->

    <section class="stats-grid">


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-user-group"></i>
            </div>

            <div class="stat-content">

                <span>Total Patients</span>

                <strong><%= totalPatients %></strong>

                <small>
                    Registered patients
                </small>

            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-calendar-check"></i>
            </div>

            <div class="stat-content">

                <span>Total Appointments</span>

                <strong><%= totalAppointments %></strong>

                <small>
                    Scheduled appointments
                </small>

            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-calendar-day"></i>
            </div>

            <div class="stat-content">

                <span>Today's Appointments</span>

                <strong><%= todayAppointments %></strong>

                <small>
                    Appointments today
                </small>

            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-money-bill-wave"></i>
            </div>

            <div class="stat-content">

                <span>Total Revenue</span>

                <strong>Rs. <%= String.format("%,.2f", totalRevenue) %></strong>

                <small>
                    Completed appointments
                </small>

            </div>

        </div>

    </section>


    <!-- ================= QUICK ACTIONS ================= -->

    <section class="content-card">

        <div class="section-heading">

            <div>

                <h2>Quick Actions</h2>

                <p>
                    Frequently used clinic functions
                </p>

            </div>

        </div>


        <div class="quick-grid">


            <a href="${pageContext.request.contextPath}/managePatients"
               class="quick-item">

                <div class="quick-icon">
                    <i class="fa-solid fa-user-group"></i>
                </div>

                <div class="quick-info">

                    <strong>Manage Patients</strong>

                    <span>
                        View and manage patient records
                    </span>

                </div>

                <i class="fa-solid fa-chevron-right arrow"></i>

            </a>


            <a href="${pageContext.request.contextPath}/addappointment"
               class="quick-item">

                <div class="quick-icon">
                    <i class="fa-solid fa-calendar-plus"></i>
                </div>

                <div class="quick-info">

                    <strong>New Appointment</strong>

                    <span>
                        Register a new patient appointment
                    </span>

                </div>

                <i class="fa-solid fa-chevron-right arrow"></i>

            </a>


            <a href="${pageContext.request.contextPath}/manageAppointments"
               class="quick-item">

                <div class="quick-icon">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>

                <div class="quick-info">

                    <strong>Appointments</strong>

                    <span>
                        View and manage appointments
                    </span>

                </div>

                <i class="fa-solid fa-chevron-right arrow"></i>

            </a>


            <a href="${pageContext.request.contextPath}/manageBilling"
               class="quick-item">

                <div class="quick-icon">
                    <i class="fa-solid fa-file-invoice-dollar"></i>
                </div>

                <div class="quick-info">

                    <strong>Billing</strong>

                    <span>
                        Calculate and manage patient bills
                    </span>

                </div>

                <i class="fa-solid fa-chevron-right arrow"></i>

            </a>

        </div>

    </section>


    <!-- ================= CLINIC INFORMATION ================= -->

    <section class="clinic-card">

        <div class="clinic-card-icon">
            <i class="fa-solid fa-tooth"></i>
        </div>

        <div class="clinic-card-text">

            <h3>Sunrise Dental Clinic</h3>

            <p>
                Professional dental care with modern treatments
                and patient-focused service.
            </p>

        </div>

        <span class="clinic-status">
            <i class="fa-solid fa-circle"></i>
            System Active
        </span>

    </section>


    <!-- ================= FOOTER ================= -->

    <footer>

        <span>
            © 2026 Sunrise Dental Clinic. All Rights Reserved.
        </span>

        <span>
            Clinic Management System
        </span>

    </footer>
    
    <script>
function confirmLogout(event) {
    event.preventDefault();

    const confirmLogout = confirm("Are you sure you want to logout?");

    if (confirmLogout) {
        window.location.href = "<%= request.getContextPath() %>/logout";
    }
}
</script>


</main>

</body>
</html>