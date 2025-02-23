package dao;

import DBContext.DatabaseConnection;
import dto.TransactionDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    // Phương thức tìm kiếm tổng hợp (phân trang + tìm kiếm động)
    public List<TransactionDTO> searchTransactions(String customerName, String phoneNumber, String date, int page, int pageSize) {
        List<TransactionDTO> transactions = new ArrayList<>();
        
        // Khởi tạo truy vấn cơ bản
        StringBuilder query = new StringBuilder("""
                SELECT t.TransactionID, t.TransactionType, r.RiceName, c.FullName AS CustomerName, 
                       c.PhoneNumber, t.Quantity, t.TransactionDate, t.PorterService, t.TotalAmount
                FROM Transactions t
                JOIN Rice r ON t.RiceID = r.RiceID
                JOIN Customers c ON t.CustomerID = c.CustomerID
                WHERE 1=1
                """);

        // Danh sách tham số để thêm vào PreparedStatement
        List<Object> params = new ArrayList<>();

        // Nếu có tên khách hàng, thêm điều kiện
        if (customerName != null && !customerName.trim().isEmpty()) {
            query.append(" AND c.FullName LIKE ?");
            params.add("%" + customerName.trim() + "%");
        }

        // Nếu có số điện thoại khách hàng, thêm điều kiện
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            query.append(" AND c.PhoneNumber = ?");
            params.add(phoneNumber.trim());
        }

        // Nếu có ngày giao dịch, thêm điều kiện
        if (date != null && !date.trim().isEmpty()) {
            query.append(" AND CAST(t.TransactionDate AS DATE) = ?");
            params.add(date.trim());
        }

        // Thêm phân trang
        query.append(" ORDER BY t.TransactionDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            // Gán tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                TransactionDTO transaction = new TransactionDTO();
                transaction.setTransactionId(rs.getInt("TransactionID"));
                transaction.setTransactionType(rs.getString("TransactionType"));
                transaction.setRiceName(rs.getString("RiceName"));
                transaction.setCustomerName(rs.getString("CustomerName"));
                transaction.setPhoneNumber(rs.getString("PhoneNumber"));
                transaction.setQuantity(rs.getInt("Quantity"));
                transaction.setTransactionDate(rs.getDate("TransactionDate"));
                transaction.setPorterService(rs.getBoolean("PorterService"));
                transaction.setTotalAmount(rs.getDouble("TotalAmount"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    // Kiểm tra TransactionDAO
    public static void main(String[] args) {
        TransactionDAO transactionDAO = new TransactionDAO();

        System.out.println("📌 Lấy toàn bộ giao dịch (Trang 1, 5 bản ghi)");
        List<TransactionDTO> allTransactions = transactionDAO.searchTransactions(null, null, null, 1, 5);
        allTransactions.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm theo tên khách hàng: 'Nguyen Van A'");
        List<TransactionDTO> byName = transactionDAO.searchTransactions("Nguyen Van A", null, null, 1, 5);
        byName.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm theo số điện thoại: '0987654321'");
        List<TransactionDTO> byPhone = transactionDAO.searchTransactions(null, "0987654321", null, 1, 5);
        byPhone.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm theo ngày: '2025-02-20'");
        List<TransactionDTO> byDate = transactionDAO.searchTransactions(null, null, "2025-02-20", 1, 5);
        byDate.forEach(System.out::println);

        System.out.println("\n📌 Tìm kiếm kết hợp: Tên 'Nguyen Van A' + Ngày '2025-02-20'");
        List<TransactionDTO> combinedSearch = transactionDAO.searchTransactions("Nguyen Van A", null, "2025-02-20", 1, 5);
        combinedSearch.forEach(System.out::println);
    }
}
