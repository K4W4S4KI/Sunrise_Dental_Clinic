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
import javax.servlet.http.HttpSession;

import model.appointment;
import model.dentist;
import services.appointmentService;

@WebServlet("/editAppointment")
public class editAppointment extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private appointmentService appointmentService = new appointmentService();

    
    // LOAD EDIT FORM
    
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
            return;
        }

        String idValue = request.getParameter("id");

        int appointmentId;

        try {
            appointmentId = Integer.parseInt(idValue);
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Invalid appointment id.");
            response.sendRedirect(request.getContextPath() + "/manageAppointments");
            return;
        }

        appointment appt = appointmentService.getAppointmentById(appointmentId);

        if (appt == null) {
            session.setAttribute("errorMessage", "Appointment not found.");
            response.sendRedirect(request.getContextPath() + "/manageAppointments");
            return;
        }

        ArrayList<dentist> dentistList = appointmentService.getActiveDentists();

        // make sure the appointment's current dentist is selectable
        // even if they've since been set to Inactive
        boolean currentDentistInList = false;

        for (dentist d : dentistList) {
            if (d.getDentist_id() == appt.getD_id()) {
                currentDentistInList = true;
                break;
            }
        }

        if (!currentDentistInList) {

            dentist current = appointmentService.getDentistById(appt.getD_id());

            if (current != null) {
                dentistList.add(current);
            }
        }

        request.setAttribute("appt", appt);
        request.setAttribute("dentistList", dentistList);

        request.getRequestDispatcher("/editappointment.jsp")
               .forward(request, response);
    }

    
    // SAVE CHANGES
    
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
            return;
        }

        String idValue = request.getParameter("appointmentId");

        int appointmentId;

        try {
            appointmentId = Integer.parseInt(idValue);
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Invalid appointment id.");
            response.sendRedirect(request.getContextPath() + "/manageAppointments");
            return;
        }

        String patientName     = request.getParameter("patientName");
        String address         = request.getParameter("address");
        String contactNumber   = request.getParameter("contactNumber");
        String gender           = request.getParameter("gender");
        String dentistIdStr     = request.getParameter("dentistId");
        String appointmentDate  = request.getParameter("appointmentDate");
        String appointmentTime  = request.getParameter("appointmentTime");
        String status            = request.getParameter("status");

        if (patientName != null) patientName = patientName.trim();
        if (address != null) address = address.trim();
        if (contactNumber != null) contactNumber = contactNumber.trim();

        
        // VALIDATION
       

        if (patientName == null || patientName.isEmpty() ||
            contactNumber == null || contactNumber.isEmpty() ||
            dentistIdStr == null || dentistIdStr.isEmpty() ||
            appointmentDate == null || appointmentDate.isEmpty() ||
            appointmentTime == null || appointmentTime.isEmpty() ||
            status == null || status.isEmpty()) {

            session.setAttribute("errorMessage", "Please fill in all required fields.");
            response.sendRedirect(
                    request.getContextPath() + "/editAppointment?id=" + appointmentId
            );
            return;
        }

        int dentistId;
        Timestamp appointmentDatetime;

        try {

            dentistId = Integer.parseInt(dentistIdStr);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

            Date parsed = sdf.parse(appointmentDate + " " + appointmentTime);

            appointmentDatetime = new Timestamp(parsed.getTime());

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute("errorMessage", "Invalid dentist or date/time.");
            response.sendRedirect(
                    request.getContextPath() + "/editAppointment?id=" + appointmentId
            );
            return;
        }

       
        // CHECK DENTIST AVAILABILITY (excluding this appointment)
       

        boolean available = appointmentService.isDentistAvailable(
                dentistId,
                appointmentDatetime,
                appointmentId
        );

        if (!available) {

            session.setAttribute(
                    "errorMessage",
                    "The selected dentist is not available at this date and time."
            );

            response.sendRedirect(
                    request.getContextPath() + "/editAppointment?id=" + appointmentId
            );
            return;
        }

        
        // BUILD AND SAVE
       

        appointment appt = new appointment();

        appt.setAppointment_id(appointmentId);
        appt.setP_name(patientName);
        appt.setAddress(address);
        appt.setC_number(contactNumber);
        appt.setGender(gender);
        appt.setD_id(dentistId);
        appt.setAppointment_datetime(appointmentDatetime);
        appt.setStatus(status);

        boolean updated = appointmentService.updateAppointment(appt);

        if (updated) {

            session.setAttribute("successMessage", "Appointment updated successfully.");

        } else {

            session.setAttribute("errorMessage", "Unable to update appointment.");
        }

        response.sendRedirect(request.getContextPath() + "/manageAppointments");
    }
}