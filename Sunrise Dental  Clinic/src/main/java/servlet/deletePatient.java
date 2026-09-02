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
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ==========================================
        // ADMIN LOGIN CHECK
        // ==========================================
        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adlogin.jsp"
            );
            return;
        }

        // ==========================================
        // GET PATIENT ID
        // ==========================================
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

            patientId = Integer.parseInt(id.trim());

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

        // ==========================================
        // CHECK WHETHER PATIENT EXISTS
        // ==========================================
        if (service.getPatientById(patientId) == null) {

            session.setAttribute(
                "error",
                "Patient record not found."
            );

            response.sendRedirect(
                request.getContextPath() + "/managePatients"
            );
            return;
        }

        // ==========================================
        // DELETE PATIENT
        // ==========================================
        boolean success = service.deletePatient(patientId);

        if (success) {

            session.setAttribute(
                "success",
                "Patient record deleted successfully."
            );

        } else {

            session.setAttribute(
                "error",
                "Unable to delete patient record. The patient may be linked to other records."
            );
        }

        // ==========================================
        // REDIRECT TO PATIENT LIST
        // ==========================================
        response.sendRedirect(
            request.getContextPath() + "/managePatients"
        );
    }
}