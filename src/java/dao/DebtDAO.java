package dao;

import DBContext.DatabaseConnection;
import dto.DebtDTO;
import model.Debt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DebtDAO extends GenericDAO<Debt> {

    @Override
    protected Debt mapResultSetToEntity(ResultSet rs) throws SQLException {
        Debt debt = new Debt();
        debt.setDebtId(rs.getInt("DebtID"));
        debt.setCustomerId(rs.getInt("CustomerID"));
        debt.setDebtType(rs.getString("DebtType"));
        debt.setAmount(rs.getDouble("Amount"));
        debt.setNote(rs.getString("Note"));
        debt.setDebtDate(rs.getDate("DebtDate"));
        return debt;
    }

    // Đếm tổng số phiếu nợ phù hợp với điều kiện tìm kiếm
    public int getTotalDebtCount(String phoneNumber, String debtDate) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM Debts d JOIN Customers c ON d.CustomerID = c.CustomerID WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            query.append(" AND c.PhoneNumber = ?");
            params.add(phoneNumber.trim());
        }
        if (debtDate != null && !debtDate.trim().isEmpty()) {
            query.append(" AND CAST(d.DebtDate AS DATE) = ?");
            params.add(debtDate.trim());
        }

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy danh sách phiếu nợ theo điều kiện tìm kiếm + phân trang (trả về DebtDTO)
    public List<DebtDTO> searchDebts(String phoneNumber, String debtDate, int page, int pageSize) {
        List<DebtDTO> debts = new ArrayList<>();
        StringBuilder query = new StringBuilder("""
            SELECT d.DebtID, d.CustomerID, c.FullName, c.PhoneNumber, d.DebtType, d.Amount, d.Note, d.DebtDate
            FROM Debts d
            JOIN Customers c ON d.CustomerID = c.CustomerID
            WHERE 1=1
        """);
        List<Object> params = new ArrayList<>();

        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            query.append(" AND c.PhoneNumber = ?");
            params.add(phoneNumber.trim());
        }
        if (debtDate != null && !debtDate.trim().isEmpty()) {
            query.append(" AND CAST(d.DebtDate AS DATE) = ?");
            params.add(debtDate.trim());
        }

        query.append(" ORDER BY d.DebtDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                DebtDTO debt = new DebtDTO();
                debt.setDebtId(rs.getInt("DebtID"));
                debt.setCustomerId(rs.getInt("CustomerID"));
                debt.setCustomerName(rs.getString("FullName"));
                debt.setPhoneNumber(rs.getString("PhoneNumber"));
                debt.setDebtType(rs.getString("DebtType"));
                debt.setAmount(rs.getDouble("Amount"));
                debt.setNote(rs.getString("Note"));
                debt.setDebtDate(rs.getDate("DebtDate"));
                debts.add(debt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return debts;
    }

    // Lấy 1 công nợ
    public Debt getDebtById(int debtId) {
        return getAllWithParams("SELECT * FROM Debts WHERE DebtID = ?", debtId)
                .stream()
                .findFirst()
                .orElse(null);
    }

    public DebtDTO getDebtByIdDTO(int debtId) {
        String query = """
        SELECT d.DebtID, d.CustomerID, c.FullName AS CustomerName, d.DebtType, d.Amount, d.Note, d.DebtDate
        FROM Debts d
        JOIN Customers c ON d.CustomerID = c.CustomerID
        WHERE d.DebtID = ?
    """;

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, debtId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                DebtDTO debt = new DebtDTO();
                debt.setDebtId(rs.getInt("DebtID"));
                debt.setCustomerId(rs.getInt("CustomerID"));
                debt.setCustomerName(rs.getString("CustomerName"));
                debt.setDebtType(rs.getString("DebtType"));
                debt.setAmount(rs.getDouble("Amount"));
                debt.setNote(rs.getString("Note"));
                debt.setDebtDate(rs.getDate("DebtDate"));
                return debt;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy tất cả công nợ
    public List<Debt> getAllDebts() {
        return getAll("SELECT * FROM Debts ORDER BY DebtDate DESC");
    }

    // Lấy công nợ theo ID khách hàng
    public List<Debt> getDebtsByCustomerId(int customerId) {
        return getAllWithParams("SELECT * FROM Debts WHERE CustomerID = ? ORDER BY DebtDate DESC", customerId);
    }

    // Thêm công nợ mới
    public boolean insertDebt(Debt debt) {
        return executeUpdate("INSERT INTO Debts (CustomerID, DebtType, Amount, Note, DebtDate) VALUES (?, ?, ?, ?, ?)",
                debt.getCustomerId(), debt.getDebtType(), debt.getAmount(), debt.getNote(), debt.getDebtDate());
    }

    // Xóa công nợ theo ID
    public boolean deleteDebt(int debtId) {
        return executeUpdate("DELETE FROM Debts WHERE DebtID = ?", debtId);
    }
}
