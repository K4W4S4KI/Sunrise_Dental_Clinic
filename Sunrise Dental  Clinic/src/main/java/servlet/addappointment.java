package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.appointment;
import model.dentist;
import model.patient;
import model.treatment;
import services.appointmentService;
import services.patientService;

@WebServlet("/addappointment")
public class addappointment extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private appointmentService appointmentService =
            new appointmentService();

    private patientService patientService =
            new patientService();

    
    // DISPLAY ADD APPOINTMENT PAGE
    
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            ArrayList<dentist> dentistList =
                    appointmentService.getActiveDentists();

            ArrayList<treatment> treatmentList =
                    appointmentService.getActiveTreatments();

            request.setAttribute("dentistList", dentistList);
            request.setAttribute("treatmentList", treatmentList);

            request.getRequestDispatcher(
                    "/addappointment.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/addappointment?error=system"
            );
        }
    }

    
    // CREATE APPOINTMENT
    
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String contextPath = request.getContextPath();

        
        // READ FORM DATA
      

        String patientIdStr   = request.getParameter("patientId");
        String phone          = request.getParameter("phone");
        String patientName    = request.getParameter("patientName");
        String gender          = request.getParameter("gender");
        String address         = request.getParameter("address");
        String dentistIdStr    = request.getParameter("dentistId");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
        String[] treatmentIds  = request.getParameterValues("treatmentIds");

        if (phone != null) phone = phone.trim();
        if (patientName != null) patientName = patientName.trim();
        if (address != null) address = address.trim();

        // -----------------------------------------------------
        // VALIDATION
        // -----------------------------------------------------

        if (phone == null || phone.isEmpty()) {
            redirectWithError(response, contextPath, "phone");
            return;
        }

        if (patientName == null || patientName.isEmpty()) {
            redirectWithError(response, contextPath, "name");
            return;
        }

        if (dentistIdStr == null || dentistIdStr.isEmpty()) {
            redirectWithError(response, contextPath, "dentist");
            return;
        }

        if (appointmentDate == null || appointmentDate.isEmpty()
                || appointmentTime == null || appointmentTime.isEmpty()) {
            redirectWithError(response, contextPath, "datetime");
            return;
        }

        if (treatmentIds == null || treatmentIds.length == 0) {
            redirectWithError(response, contextPath, "treatment");
            return;
        }

        int dentistId;
        Timestamp appointmentDatetime;

        try {

            dentistId = Integer.parseInt(dentistIdStr);

            SimpleDateFormat sdf =
                    new SimpleDateFormat("yyyy-MM-dd HH:mm");

            Date parsed = sdf.parse(
                    appointmentDate + " " + appointmentTime
            );

            appointmentDatetime = new Timestamp(parsed.getTime());

        } catch (Exception e) {

            e.printStackTrace();
            redirectWithError(response, contextPath, "datetime");
            return;
        }

        // -----------------------------------------------------
        // CHECK DENTIST AVAILABILITY
        // (appointmentId = 0 since this is a new appointment)
        // -----------------------------------------------------

        boolean available = appointmentService.isDentistAvailable(
                dentistId,
                appointmentDatetime,
                0
        );

        if (!available) {
            redirectWithError(response, contextPath, "unavailable");
            return;
        }

        // -----------------------------------------------------
        // RESOLVE / CREATE PATIENT
        // -----------------------------------------------------

        Integer p_id = null;

        if (patientIdStr != null && !patientIdStr.trim().isEmpty()) {

            try {
                p_id = Integer.parseInt(patientIdStr.trim());
            } catch (NumberFormatException ignored) {
                p_id = null;
            }
        }

        if (p_id == null) {

            // New patient - check if phone already exists first
            patient existing =
                    patientService.getPatientByContactNumber(phone);

            if (existing != null) {

                p_id = existing.getP_id();

            } else {

                patient newPatient = new patient();
                newPatient.setP_name(patientName);
                newPatient.setAddress(address);
                newPatient.setC_number(phone);
                newPatient.setGender(gender);
                newPatient.setStatus("Active");

                boolean added = patientService.addPatient(newPatient);

                if (!added) {
                    redirectWithError(response, contextPath, "create");
                    return;
                }

                patient created =
                        patientService.getPatientByContactNumber(phone);

                if (created != null) {
                    p_id = created.getP_id();
                }
            }
        }

        // -----------------------------------------------------
        // BUILD APPOINTMENT OBJECT
        // -----------------------------------------------------

        appointment appt = new appointment();

        appt.setP_id(p_id);
        appt.setP_name(patientName);
        appt.setAddress(address);
        appt.setC_number(phone);
        appt.setGender(gender);
        appt.setD_id(dentistId);
        appt.setAppointment_datetime(appointmentDatetime);

        // -----------------------------------------------------
        // CREATE APPOINTMENT + TREATMENTS
        // -----------------------------------------------------

        boolean success =
                appointmentService.createAppointmentWithTreatments(
                        appt,
                        treatmentIds
                );

        if (success) {

            response.sendRedirect(
                    contextPath
                    + "/addappointment.jsp?success=true"
            );

        } else {

            redirectWithError(response, contextPath, "create");
        }
    }

    
    // HELPER - redirect back to GET handler with an error code
   
    private void redirectWithError(
            HttpServletResponse response,
            String contextPath,
            String errorCode)
            throws IOException {

        response.sendRedirect(
                contextPath
                + "/addappointment?error="
                + errorCode
        );
    }
}