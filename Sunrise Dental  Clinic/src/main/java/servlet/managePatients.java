package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.patient;
import services.patientService;

@WebServlet("/managePatients")
public class managePatients extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin login
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adlogin.jsp"
            );

            return;
        }

        // Create patient service
        patientService service = new patientService();

        // Get search keyword
        String keyword = request.getParameter("keyword");

        ArrayList<patient> patientList;

        // Search patients
        if (keyword != null && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            patientList = service.searchPatients(keyword);

        } else {

            keyword = "";

            patientList = service.getAllPatients();
        }

        // Prevent null list
        if (patientList == null) {

            patientList = new ArrayList<patient>();
        }

        // Send patient list to JSP
        request.setAttribute(
            "patientList",
            patientList
        );

        // Send search keyword to JSP
        request.setAttribute(
            "keyword",
            keyword
        );

        // Send total patient count
        request.setAttribute(
            "totalPatients",
            patientList.size()
        );

        // Forward to JSP
        RequestDispatcher dispatcher =
            request.getRequestDispatcher(
                "/adpatients.jsp"
            );

        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}