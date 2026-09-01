package servlet;

import model.patient;
import services.patientService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/checkPatient")
public class checkPatient extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private patientService patientService =
            new patientService();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "application/json"
        );

        response.setCharacterEncoding(
                "UTF-8"
        );


        String phone =
                request.getParameter("phone");


        if (phone == null ||
                phone.trim().isEmpty()) {

            response.getWriter().print(
                    "{\"found\":false}"
            );

            return;
        }


        patient p =
                patientService
                        .getPatientByContactNumber(
                                phone.trim()
                        );


        if (p != null) {

            String json =
                    "{"
                    + "\"found\":true,"
                    + "\"p_id\":\""
                    + p.getP_id()
                    + "\","
                    + "\"p_name\":\""
                    + escapeJson(p.getP_name())
                    + "\","
                    + "\"address\":\""
                    + escapeJson(p.getAddress())
                    + "\","
                    + "\"c_number\":\""
                    + escapeJson(p.getC_number())
                    + "\","
                    + "\"gender\":\""
                    + escapeJson(p.getGender())
                    + "\","
                    + "\"status\":\""
                    + escapeJson(p.getStatus())
                    + "\""
                    + "}";

            response.getWriter().print(json);

        } else {

            response.getWriter().print(
                    "{\"found\":false}"
            );
        }
    }


    private String escapeJson(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}