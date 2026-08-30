
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import services.patientService;

@WebServlet(name = "deletePatient", urlPatterns = {"/deletePatient"})
public class deletePatient extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private patientService service;

    @Override
    public void init() throws ServletException {
        service = new patientService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Admin login check
        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adlogin.jsp"
            );
            return;
        }

        // Get patient ID
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

        // Delete patient
        boolean success = service.deletePatient(patientId);

        if (success) {

            session.setAttribute(
                "success",
                "Patient record deleted successfully."
            );

        } else {

            session.setAttribute(
                "error",
                "Unable to delete patient record."
            );
        }

        // Back to patient management
        response.sendRedirect(
            request.getContextPath() + "/managePatients"
        );
    }
}

