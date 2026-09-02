package servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.appointment;
import model.dentist;
import model.treatment;
import services.appointmentService;

@WebServlet("/viewAppointment")
public class viewAppointment extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private appointmentService appointmentService = new appointmentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/adminlogin.jsp"
            );
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

        dentist d = appointmentService.getDentistById(appt.getD_id());

        ArrayList<treatment> treatments =
                appointmentService.getTreatmentsForAppointment(appointmentId);

        BigDecimal billTotal = appointmentService.calculateBillTotal(treatments);

        request.setAttribute("appt", appt);
        request.setAttribute("dentist", d);
        request.setAttribute("treatments", treatments);
        request.setAttribute("billTotal", billTotal);
        request.setAttribute("consultationFee", appointmentService.CONSULTATION_FEE);

        request.getRequestDispatcher("/viewappointment.jsp")
               .forward(request, response);
    }
}