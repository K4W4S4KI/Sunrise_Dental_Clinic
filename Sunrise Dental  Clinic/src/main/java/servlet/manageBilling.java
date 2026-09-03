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

import model.bill;
import services.appointmentService;

@WebServlet("/manageBilling")
public class manageBilling extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private appointmentService appointmentService =
            new appointmentService();

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

        String keyword = request.getParameter("keyword");

        ArrayList<bill> billList;

        if (keyword != null && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();
            billList = appointmentService.searchBills(keyword);

        } else {

            keyword = "";
            billList = appointmentService.getAllBills();
        }

        if (billList == null) {
            billList = new ArrayList<bill>();
        }

        
        // TOTAL REVENUE (sum of grand totals)
        

        BigDecimal totalRevenue = BigDecimal.ZERO;

        for (bill b : billList) {

            if (b.getGrand_total() != null) {
                totalRevenue = totalRevenue.add(b.getGrand_total());
            }
        }

        request.setAttribute("billList", billList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("totalBills", billList.size());
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/adbilling.jsp")
               .forward(request, response);
    }
}