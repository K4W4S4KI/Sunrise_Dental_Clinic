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

    appointment appt = (appointment) request.getAttribute("appt");
    dentist d = (dentist) request.getAttribute("dentist");
    List<treatment> treatments = (List<treatment>) request.getAttribute("treatments");
    BigDecimal billTotal = (BigDecimal) request.getAttribute("billTotal");
    BigDecimal consultationFee = (BigDecimal) request.getAttribute("consultationFee");

    if (appt == null) {
        response.sendRedirect(request.getContextPath() + "/manageBilling");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Bill - <%= appt.getAppointment_number() %></title>

<style>

  body {
      font-family: Arial, sans-serif;
      color: #222;
      margin: 0;
      padding: 40px;
      background: #f4f4f8;
  }

  .invoice-box {
      max-width: 750px;
      margin: auto;
      background: #fff;
      border: 1px solid #eee;
      padding: 30px;
      box-shadow: 0 0 10px rgba(0,0,0,0.08);
  }

  .invoice-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      border-bottom: 2px solid #4c3fd6;
      padding-bottom: 20px;
      margin-bottom: 20px;
  }

  .clinic-name {
      font-size: 22px;
      font-weight: bold;
      color: #4c3fd6;
  }

  .clinic-sub {
      color: #777;
      font-size: 13px;
  }

  .bill-meta {
      text-align: right;
      font-size: 13px;
      color: #555;
  }

  .section-title {
      font-weight: bold;
      color: #4c3fd6;
      margin-top: 20px;
      margin-bottom: 8px;
      font-size: 14px;
      text-transform: uppercase;
  }

  table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
  }

  th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #eee;
      font-size: 14px;
  }

  th {
      background: #f7f6ff;
      color: #4c3fd6;
  }

  .text-right {
      text-align: right;
  }

  .totals {
      margin-top: 10px;
      width: 100%;
  }

  .totals td {
      border: none;
      padding: 6px 10px;
  }

  .grand-total-row td {
      font-weight: bold;
      font-size: 16px;
      border-top: 2px solid #4c3fd6;
      color: #4c3fd6;
  }

  .print-actions {
      text-align: center;
      margin-top: 30px;
  }

  .print-btn, .back-btn {
      display: inline-block;
      padding: 10px 24px;
      border-radius: 8px;
      text-decoration: none;
      font-weight: 600;
      margin: 0 6px;
      cursor: pointer;
      border: none;
      font-size: 14px;
  }

  .print-btn {
      background: #4c3fd6;
      color: #fff;
  }

  .back-btn {
      background: #f0f0f5;
      color: #333;
      border: 1px solid #ddd;
  }

  @media print {
      .print-actions { display: none; }
      body { padding: 0; background: #fff; }
      .invoice-box { border: none; box-shadow: none; }
  }

</style>

</head>
<body>

<div class="invoice-box">

    <div class="invoice-header">

        <div>
            <div class="clinic-name">Sunrise Dental Clinic</div>
            <div class="clinic-sub">Dental appointment billing statement</div>
        </div>

        <div class="bill-meta">
            <div><strong>Bill No:</strong> <%= appt.getAppointment_number() %></div>
            <div>
                <strong>Date:</strong>
                <%= appt.getAppointment_datetime() != null
                    ? dateFormat.format(appt.getAppointment_datetime())
                    : "-" %>
            </div>
            <div>
                <strong>Status:</strong>
                <%= appt.getStatus() != null ? appt.getStatus() : "Pending" %>
            </div>
        </div>

    </div>

    <div class="section-title">Patient Details</div>

    <table>
        <tr>
            <td style="width:50%;">
                <strong>Name:</strong> <%= appt.getP_name() %>
            </td>
            <td>
                <strong>Contact:</strong> <%= appt.getC_number() %>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Gender:</strong>
                <%= appt.getGender() != null ? appt.getGender() : "-" %>
            </td>
            <td>
                <strong>Address:</strong>
                <%= appt.getAddress() != null ? appt.getAddress() : "-" %>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <strong>Dentist:</strong>
                <%= d != null ? "Dr. " + d.getDentist_name() : "Dentist #" + appt.getD_id() %>
                <% if (d != null && d.getSpecialization() != null &&
                       !d.getSpecialization().trim().isEmpty()) { %>
                    (<%= d.getSpecialization() %>)
                <% } %>
            </td>
        </tr>
    </table>

    <div class="section-title">Treatment Charges</div>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Treatment</th>
                <th class="text-right">Price (LKR)</th>
            </tr>
        </thead>
        <tbody>

            <%
                int row = 1;

                if (treatments != null && !treatments.isEmpty()) {

                    for (treatment t : treatments) {
            %>
            <tr>
                <td><%= row++ %></td>
                <td><%= t.getTreatment_name() %></td>
                <td class="text-right">
                    <%= String.format("%,.2f", t.getTreatment_priceLkr()) %>
                </td>
            </tr>
            <%
                    }

                } else {
            %>
            <tr>
                <td colspan="3">No treatments recorded.</td>
            </tr>
            <%
                }
            %>

        </tbody>
    </table>

    <table class="totals">
        <tr>
            <td class="text-right" style="width:80%;">Consultation Fee</td>
            <td class="text-right">
                LKR <%= String.format("%,.2f", consultationFee) %>
            </td>
        </tr>
        <tr class="grand-total-row">
            <td class="text-right">Grand Total</td>
            <td class="text-right">
                LKR <%= String.format("%,.2f", billTotal) %>
            </td>
        </tr>
    </table>

    <div class="print-actions">
        <button type="button" class="print-btn" onclick="window.print()">
            🖨 Print Bill
        </button>
        <a href="<%= request.getContextPath() %>/manageBilling" class="back-btn">
            ← Back to Billing
        </a>
    </div>

</div>

</body>
</html>