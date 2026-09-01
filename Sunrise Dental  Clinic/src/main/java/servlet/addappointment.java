package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dentist;
import model.treatment;
import services.appointmentService;

@WebServlet("/addappointment")
public class addappointment extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private appointmentService appointmentService =
            new appointmentService();

    // =========================================================
    // DISPLAY ADD APPOINTMENT PAGE
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Get active dentists
            ArrayList<dentist> dentistList =
                    appointmentService.getActiveDentists();

            // Get active treatments
            ArrayList<treatment> treatmentList =
                    appointmentService.getActiveTreatments();

            // Debug
            System.out.println("=================================");
            System.out.println(
                    "Dentists found: " + dentistList.size()
            );

            for (dentist d : dentistList) {

                System.out.println(
                        d.getDentist_id()
                        + " | "
                        + d.getDentist_name()
                        + " | "
                        + d.getSpecialization()
                        + " | "
                        + d.getContact_number()
                        + " | "
                        + d.getStatus()
                );
            }

            System.out.println(
                    "Treatments found: "
                    + treatmentList.size()
            );

            System.out.println("=================================");

            // Send dentist list to JSP
            request.setAttribute(
                    "dentistList",
                    dentistList
            );

            // Send treatment list to JSP
            request.setAttribute(
                    "treatmentList",
                    treatmentList
            );

            // Forward to JSP
            request.getRequestDispatcher(
                    "/addappointment.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/addappointment.jsp?error=system"
            );
        }
    }

    // =========================================================
    // CREATE APPOINTMENT
    // =========================================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Appointment creation logic goes here

        response.sendRedirect(
                request.getContextPath()
                + "/addappointment"
        );
    }
}