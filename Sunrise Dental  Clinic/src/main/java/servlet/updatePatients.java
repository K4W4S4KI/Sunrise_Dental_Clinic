package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.patient;
import services.patientService;

@WebServlet("/updatePatients")
public class updatePatients extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private patientService service;

    @Override
    public void init() throws ServletException {
        service = new patientService();
    }

    // =========================================================
    // GET - LOAD PATIENT FOR EDIT
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ADMIN LOGIN CHECK
        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adlogin.jsp"
            );
            return;
        }

        // GET PATIENT ID
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {

            session.setAttribute(
                "error",
                "Patient ID is missing."
            );

            response.sendRedirect(
                request.getContextPath() + "/managePatients"
            );
            return;
        }

        int patientId;

        try {

            patientId = Integer.parseInt(idParam);

        } catch (NumberFormatException e) {

            session.setAttribute(
                "error",
                "Invalid patient ID."
            );

            response.sendRedirect(
                request.getContextPath() + "/managePatients"
            );
            return;
        }

        // GET PATIENT
        patient pat = service.getPatientById(patientId);

        if (pat == null) {

            session.setAttribute(
                "error",
                "Patient record not found."
            );

            response.sendRedirect(
                request.getContextPath() + "/managePatients"
            );
            return;
        }

        // SEND PATIENT TO JSP
        request.setAttribute("patient", pat);

        request.getRequestDispatcher(
            "ad_updatepatients.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // POST - UPDATE PATIENT
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // ADMIN LOGIN CHECK
        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adlogin.jsp"
            );
            return;
        }

        // =====================================================
        // GET FORM DATA
        // =====================================================

        String idParam = request.getParameter("p_id");
        String patientName = request.getParameter("patient_name");
        String address = request.getParameter("address");
        String contactNumber = request.getParameter("contact_number");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");

        // =====================================================
        // VALIDATE PATIENT ID
        // =====================================================

        int patientId;

        try {

            patientId = Integer.parseInt(idParam);

        } catch (Exception e) {

            session.setAttribute(
                "error",
                "Invalid patient ID."
            );

            response.sendRedirect(
                request.getContextPath() + "/managePatients"
            );
            return;
        }

        // =====================================================
        // TRIM DATA
        // =====================================================

        if (patientName != null) {
            patientName = patientName.trim();
        }

        if (address != null) {
            address = address.trim();
        }

        if (contactNumber != null) {
            contactNumber = contactNumber.trim();
        }

        if (gender != null) {
            gender = gender.trim();
        }

        if (status != null) {
            status = status.trim();
        }

        // =====================================================
        // PATIENT NAME VALIDATION
        // =====================================================

        if (patientName == null ||
            patientName.isEmpty()) {

            session.setAttribute(
                "error",
                "Please enter the patient name."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
            return;
        }

        // =====================================================
        // ADDRESS VALIDATION
        // =====================================================

        if (address == null ||
            address.isEmpty()) {

            session.setAttribute(
                "error",
                "Please enter the patient address."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
            return;
        }

        // =====================================================
        // CONTACT NUMBER VALIDATION
        // =====================================================

        if (contactNumber == null ||
            contactNumber.isEmpty()) {

            session.setAttribute(
                "error",
                "Please enter the contact number."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
            return;
        }

        // SRI LANKAN PHONE NUMBER
        if (!contactNumber.matches("0[0-9]{9}")) {

            session.setAttribute(
                "error",
                "Please enter a valid 10-digit Sri Lankan contact number."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
            return;
        }

        // =====================================================
        // GENDER VALIDATION
        // =====================================================

        if (gender == null ||
            gender.isEmpty()) {

            session.setAttribute(
                "error",
                "Please select the patient's gender."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
            return;
        }

        // =====================================================
        // STATUS
        // =====================================================

        if (status == null ||
            status.isEmpty()) {

            status = "Active";
        }

        // =====================================================
        // CHECK DUPLICATE CONTACT NUMBER
        // =====================================================

        patient existingPatient =
                service.getPatientByContactNumber(contactNumber);

        if (existingPatient != null &&
            existingPatient.getP_id() != patientId) {

            session.setAttribute(
                "error",
                "This contact number is already registered for another patient."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
            return;
        }

        // =====================================================
        // CREATE PATIENT OBJECT
        // =====================================================

        patient pat = new patient();

        pat.setP_id(patientId);
        pat.setP_name(patientName);
        pat.setAddress(address);
        pat.setC_number(contactNumber);
        pat.setGender(gender);
        pat.setStatus(status);

        // =====================================================
        // UPDATE DATABASE
        // =====================================================

        boolean success = service.updatePatient(pat);

        // =====================================================
        // RESULT
        // =====================================================

        if (success) {

            session.setAttribute(
                "success",
                "Patient updated successfully."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/managePatients"
            );

        } else {

            session.setAttribute(
                "error",
                "Unable to update patient. Please try again."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/updatePatients?id="
                + patientId
            );
        }
    }
}