package model;

import lombok.Data;

@Data
public class User {
    private int userId;
    private String fullName;
    private String phoneNumber;
    private String address;
    private String storeName;
    private String username;
    private String passwordHash;
    private String role;
    private boolean isBanned;
}
