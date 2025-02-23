package dao;

import DBContext.DatabaseConnection;
import model.User;
import java.sql.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO extends GenericDAO<User> {

    public static UserDAO INSTANCE = new UserDAO();
    private Connection con;
    
    public UserDAO() {
         if (INSTANCE == null) {
            try {
                con = DatabaseConnection.getConnection();
            } catch (SQLException e) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e.getMessage());
            }
        }
    }

    @Override
    protected User mapResultSetToEntity(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setFullName(rs.getString("FullName"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        user.setAddress(rs.getString("Address"));
        user.setStoreName(rs.getString("StoreName"));
        user.setUsername(rs.getString("Username"));
        user.setPasswordHash(rs.getString("PasswordHash"));
        user.setRole(rs.getString("Role"));
        user.setEmail(rs.getString("Email"));
        user.setBanned(rs.getBoolean("IsBanned"));
        return user;
    }

    public List<User> getAllUsers() {
        return getAll("SELECT * FROM Users");
    }

    public boolean insertUser(User user) {
        return executeUpdate("INSERT INTO Users (FullName, PhoneNumber, Address, StoreName, Username, PasswordHash, Role, Email, IsBanned) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                user.getFullName(), user.getPhoneNumber(), user.getAddress(), user.getStoreName(), user.getUsername(), user.getPasswordHash(), user.getRole(), user.getEmail(), user.isBanned());
    }

    public boolean updateUser(User user) {
        return executeUpdate("UPDATE Users SET FullName=?, PhoneNumber=?, Address=?, StoreName=?, Username=?, PasswordHash=?, Role=?, Email=?, IsBanned=? WHERE UserID=?",
                user.getFullName(), user.getPhoneNumber(), user.getAddress(), user.getStoreName(), user.getUsername(), user.getPasswordHash(), user.getRole(), user.getEmail(), user.isBanned(), user.getUserId());
    }

    public boolean deleteUser(int userId) {
        return executeUpdate("DELETE FROM Users WHERE UserID=?", userId);
    }

    public User login(String username, String password) {
        String query = "SELECT * FROM Users WHERE Username = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("PasswordHash"); 
                if (password.equals(storedPassword)) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        
        String username = "owner";
        String password = "hashed_password2"; 
        
        User user = userDAO.login(username, password);
        
        if (user != null) {
            System.out.println(user.getFullName());
        } else {
            System.out.println("Invalid username or password.");
        }
    }
}
