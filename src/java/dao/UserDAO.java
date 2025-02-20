package dao;

import model.User;
import java.sql.*;
import java.util.List;

public class UserDAO extends GenericDAO<User> {

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
        user.setBanned(rs.getBoolean("IsBanned"));
        return user;
    }

    public List<User> getAllUsers() {
        return getAll("SELECT * FROM Users");
    }

    public boolean insertUser(User user) {
        return executeUpdate("INSERT INTO Users (FullName, PhoneNumber, Address, StoreName, Username, PasswordHash, Role, IsBanned) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                user.getFullName(), user.getPhoneNumber(), user.getAddress(), user.getStoreName(), user.getUsername(), user.getPasswordHash(), user.getRole(), user.isBanned());
    }

    public boolean updateUser(User user) {
        return executeUpdate("UPDATE Users SET FullName=?, PhoneNumber=?, Address=?, StoreName=?, Username=?, PasswordHash=?, Role=?, IsBanned=? WHERE UserID=?",
                user.getFullName(), user.getPhoneNumber(), user.getAddress(), user.getStoreName(), user.getUsername(), user.getPasswordHash(), user.getRole(), user.isBanned(), user.getUserId());
    }

    public boolean deleteUser(int userId) {
        return executeUpdate("DELETE FROM Users WHERE UserID=?", userId);
    }
    public static void main(String[] args) {
        UserDAO aO = new UserDAO();
        System.out.println( aO.getAllUsers());
    }
}
