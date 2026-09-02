package servlet;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import services.appointmentService;
import services.patientService;

@WebServlet("/dashboard")
public class dashboard extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private appointmentService appointmentService = new appointmentService();

    private patientService patientService = new patientService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/adlogin.jsp"
            );
            return;
        }

        try {

            int totalPatients = patientService.getTotalPatientCount();

            int totalAppointments = appointmentService.getTotalAppointmentCount();

            int todayAppointments = appointmentService.getTodayAppointmentCount();

            BigDecimal totalRevenue = appointmentService.getTotalRevenue();

            request.setAttribute("totalPatients", totalPatients);
            request.setAttribute("totalAppointments", totalAppointments);
            request.setAttribute("todayAppointments", todayAppointments);
            request.setAttribute("totalRevenue", totalRevenue);

            request.getRequestDispatcher("/adminhomes.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load dashboard.",
                    e
            );
        }
    }
}