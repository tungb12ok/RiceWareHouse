package controller;

import dao.DebtDAO;
import dao.CustomerDAO;
import dto.DebtDTO;
import model.Debt;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DebtController", urlPatterns = {"/DebtController"})
public class DebtController extends HttpServlet {

    private final DebtDAO debtDAO = new DebtDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getCustomerByPhone".equals(action)) {
            String phoneNumber = request.getParameter("phoneNumber");
            Customer customer = customerDAO.getCustomerByPhone(phoneNumber);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            if (customer != null) {
                response.getWriter().write(String.format("{\"customerId\": %d, \"customerName\": \"%s\"}",
                        customer.getCustomerId(), customer.getFullName()));
            } else {
                response.getWriter().write("{}");
            }
            return;
        }
        if ("edit".equals(action)) {
            int debtId = Integer.parseInt(request.getParameter("debtId"));
            DebtDTO debt = debtDAO.getDebtByIdDTO(debtId);

            if (debt == null) {
                response.sendRedirect("DebtController?error=Debt not found");
                return;
            }

            request.setAttribute("debt", debt);
            request.getRequestDispatcher("edit_debt.jsp").forward(request, response);
            return;
        }
        String phoneNumber = request.getParameter("phoneNumber");
        String debtDate = request.getParameter("debtDate");
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int totalRecords = debtDAO.getTotalDebtCount(phoneNumber, debtDate);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        List<DebtDTO> debts = debtDAO.searchDebts(phoneNumber, debtDate, page, pageSize);

        request.setAttribute("debtList", debts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("debtDate", debtDate);

        request.getRequestDispatcher("manage_debt.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String debtType = request.getParameter("debtType");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String note = request.getParameter("note");

            Debt debt = new Debt();
            debt.setCustomerId(customerId);
            debt.setDebtType(debtType);
            debt.setAmount(amount);
            debt.setNote(note);
            debt.setDebtDate(new java.util.Date());

            debtDAO.insertDebt(debt);

        } else if ("delete".equals(action)) {
            int debtId = Integer.parseInt(request.getParameter("debtId"));
            debtDAO.deleteDebt(debtId);
        }

        response.sendRedirect("DebtController");
    }
}
