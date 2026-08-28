<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.patient" %>

<%
    // Check admin login
    if (session.getAttribute("loggedInAdmin") == null) {
        response.sendRedirect(
            request.getContextPath() + "/adlogin.jsp"
        );
        return;
    }

    ArrayList<patient> patientList =
        (ArrayList<patient>) request.getAttribute("patientList");

    String keyword =
        (String) request.getAttribute("keyword");

    Integer totalPatients =
        (Integer) request.getAttribute("totalPatients");

    if (patientList == null) {
        patientList = new ArrayList<patient>();
    }

    if (keyword == null) {
        keyword = "";
    }

    if (totalPatients == null) {
        totalPatients = patientList.size();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Patients | Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/adpatients.css">

</head>

<body>

<!-- =========================================================
     TOP NAVIGATION BAR
========================================================= -->

<header class="top-navbar">

    <!-- Clinic Brand -->

    <div class="clinic-brand">

        <div class="clinic-logo">
            🦷
        </div>

        <div class="clinic-name">
            <h2>Sunrise</h2>
            <span>Dental Clinic</span>
        </div>

    </div>


    <!-- Navigation -->

    <nav class="navigation">

        <a href="${pageContext.request.contextPath}/adminhomes.jsp">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/managePatients"
           class="active">
            Patients
        </a>

        <a href="#">
            Appointments
        </a>

        <a href="#">
            Doctors
        </a>

    </nav>


    <!-- Admin Profile -->

    <div class="admin-profile">

        <div class="profile-icon">
            👤
        </div>

        <div class="profile-info">

            <small>Logged in as</small>

            <strong>
                <%= session.getAttribute("loggedInAdmin") %>
            </strong>

        </div>

        <a href="${pageContext.request.contextPath}/logout"
           class="logout-btn">
            Logout
        </a>

    </div>

</header>


<!-- =========================================================
     MAIN CONTENT
========================================================= -->

<main class="main-content">


    <!-- Page Header -->

    <section class="page-header">

        <div class="header-content">

            <span class="page-label">
                ADMIN PORTAL
            </span>

            <h1>
                Manage Patients
            </h1>

            <p>
                View, search and manage registered patients
                of Sunrise Dental Clinic.
            </p>

        </div>

        <div class="header-icon">
            👥
        </div>

    </section>


    <!-- =====================================================
         PATIENT SUMMARY
    ====================================================== -->

    <section class="summary-card">

        <div class="summary-icon">
            👥
        </div>

        <div class="summary-content">

            <span>Total Registered Patients</span>

            <strong>
                <%= totalPatients %>
            </strong>

            <small>
                Patients currently displayed
            </small>

        </div>

    </section>


    <!-- =====================================================
         SEARCH SECTION
    ====================================================== -->

    <section class="search-card">

        <div class="search-title">

            <div class="search-title-icon">
                🔍
            </div>

            <div>

                <h2>Search Patients</h2>

                <p>
                    Search by patient ID, name or contact number.
                </p>

            </div>

        </div>


        <form method="get"
              action="${pageContext.request.contextPath}/managePatients"
              class="search-form">

            <div class="search-input-wrapper">

                <span class="search-icon">
                    🔍
                </span>

                <input
                    type="text"
                    name="keyword"
                    value="<%= keyword %>"
                    placeholder="Enter patient ID, name or contact number">

            </div>

            <button type="submit"
                    class="search-btn">
                Search
            </button>

            <a href="${pageContext.request.contextPath}/managePatients"
               class="clear-btn">
                Clear
            </a>

        </form>

    </section>


    <!-- =====================================================
         PATIENT TABLE
    ====================================================== -->

    <section class="patients-card">

        <div class="card-header">

            <div>

                <h2>Patient Records</h2>

                <p>
                    Registered patient information
                </p>

            </div>

            <span class="record-count">
                <%= totalPatients %> Records
            </span>

        </div>


        <div class="table-container">

            <table class="patient-table">

                <thead>

                    <tr>

                        <th>ID</th>

                        <th>Patient Name</th>

                        <th>Address</th>

                        <th>Contact Number</th>

                        <th>Gender</th>

                        <th>Registered Date</th>

                        <th>Status</th>

                        <th>Action</th>

                    </tr>

                </thead>


                <tbody>

                <%
                    if (patientList.isEmpty()) {
                %>

                    <tr>

                        <td colspan="8"
                            class="no-data">

                            <div class="no-data-icon">
                                👤
                            </div>

                            <strong>
                                No patients found
                            </strong>

                            <span>
                                No patient records match your search.
                            </span>

                        </td>

                    </tr>

                <%
                    } else {

                        for (patient pat : patientList) {
                %>

                    <tr>

                        <!-- Patient ID -->

                        <td>
                            <span class="patient-id">
                                #<%= pat.getP_id() %>
                            </span>
                        </td>


                        <!-- Patient Name -->

                        <td>

                            <div class="patient-name">

                                <div class="patient-avatar">
                                    <%= pat.getP_name()
                                          .substring(0, 1)
                                          .toUpperCase() %>
                                </div>

                                <strong>
                                    <%= pat.getP_name() %>
                                </strong>

                            </div>

                        </td>


                        <!-- Address -->

                        <td>

                            <span class="address-text">
                                <%= pat.getAddress() %>
                            </span>

                        </td>


                        <!-- Contact -->

                        <td>

                            <span class="contact-number">
                                📞 <%= pat.getC_number() %>
                            </span>

                        </td>


                        <!-- Gender -->

                        <td>

                            <span class="gender-badge">
                                <%= pat.getGender() %>
                            </span>

                        </td>


                        <!-- Register Date -->

                        <td>

                            <%
                                if (pat.getRegister_datetime() != null) {
                            %>

                                <span class="date-text">
                                    <%= pat.getRegister_datetime() %>
                                </span>

                            <%
                                } else {
                            %>

                                <span class="date-text">
                                    -
                                </span>

                            <%
                                }
                            %>

                        </td>


                        <!-- Status -->

                        <td>

                            <%
                                String status = pat.getStatus();

                                if (status == null ||
                                    status.trim().isEmpty()) {

                                    status = "Active";
                                }

                                String statusClass =
                                    status.equalsIgnoreCase("Active")
                                    ? "status-active"
                                    : "status-inactive";
                            %>

                            <span class="status-badge <%= statusClass %>">

                                <span class="status-dot"></span>

                                <%= status %>

                            </span>

                        </td>


                        <!-- Actions -->

                        <td>

                            <div class="action-buttons">

                                <a href="#"
                                   class="view-btn"
                                   title="View Patient">
                                    👁
                                </a>

                                <a href="#"
                                   class="edit-btn"
                                   title="Edit Patient">
                                    ✏
                                </a>

                                <a href="#"
                                   class="delete-btn"
                                   title="Delete Patient">
                                    🗑
                                </a>

                            </div>

                        </td>

                    </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>

    </section>


    <!-- =====================================================
         FOOTER INFORMATION
    ====================================================== -->

    <section class="clinic-footer-card">

        <div class="footer-icon">
            🦷
        </div>

        <div class="footer-content">

            <h3>
                Sunrise Dental Clinic
            </h3>

            <p>
                Professional dental care with modern
                treatments and patient-focused service.
            </p>

        </div>

        <span class="portal-badge">
            Admin Portal
        </span>

    </section>


</main>


<!-- =========================================================
     MOBILE NAVIGATION SCRIPT
========================================================= -->

<script>

    // Confirm delete action
    const deleteButtons =
        document.querySelectorAll(".delete-btn");

    deleteButtons.forEach(function(button) {

        button.addEventListener("click", function(event) {

            const confirmDelete =
                confirm(
                    "Are you sure you want to delete this patient?"
                );

            if (!confirmDelete) {
                event.preventDefault();
            }

        });

    });

</script>

</body>

</html>