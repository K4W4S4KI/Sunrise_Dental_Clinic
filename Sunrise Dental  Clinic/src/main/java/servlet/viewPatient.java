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

@WebServlet("/viewPatient")
public class viewPatient extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public viewPatient() {
        super();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // ADMIN LOGIN CHECK
        // =====================================================

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/adlogin.jsp"
            );

            return;
        }

        // =====================================================
        // GET PATIENT ID
        // =====================================================

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {

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

            patientId = Integer.parseInt(id);

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

        // =====================================================
        // GET PATIENT FROM DATABASE
        // =====================================================

        patientService service = new patientService();

        patient pat = service.getPatientById(patientId);

        // =====================================================
        // PATIENT NOT FOUND
        // =====================================================

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

        // =====================================================
        // SEND PATIENT TO JSP
        // =====================================================

        request.setAttribute(
                "patient",
                pat
        );

        // =====================================================
        // OPEN VIEW PAGE
        // =====================================================

        request.getRequestDispatcher(
                "/viewPatient.jsp"
        ).forward(request, response);
    }
}