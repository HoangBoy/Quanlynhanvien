package com.dao;

import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


import com.model.User;

public class UserDAO {
    private String jdbcURL;
    private String jdbcUsername;
    private String jdbcPassword;
    private Connection jdbcConnection;
     
    public UserDAO(String jdbcURL, String jdbcUsername, String jdbcPassword) {
        this.jdbcURL = jdbcURL;
        this.jdbcUsername = jdbcUsername;
        this.jdbcPassword = jdbcPassword;
    }
     
    protected void connect() throws SQLException {
        if (jdbcConnection == null || jdbcConnection.isClosed()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            jdbcConnection = DriverManager.getConnection(
                                        jdbcURL, jdbcUsername, jdbcPassword);
        }
    }
     
    protected void disconnect() throws SQLException {
        if (jdbcConnection != null && !jdbcConnection.isClosed()) {
            jdbcConnection.close();
        }
    }
     
    public boolean insertUser(User user) throws SQLException {
        // Kiểm tra xem tài khoản đã tồn tại hay chưa
        if (isUserExists(user.getUsername())) {
            return false; // Trả về false nếu tài khoản đã tồn tại
        }

        // Tiếp tục thêm tài khoản mới vào cơ sở dữ liệu
        String sql = "INSERT INTO user (username, email, password) VALUES (?, ?, ?)";
        String hashedPassword = hashPassword(user.getPassword());
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, user.getUsername());
        statement.setString(2, user.getEmail());
        statement.setString(3, hashedPassword);

        boolean rowInserted = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowInserted;
    }

    // Phương thức kiểm tra xem tài khoản đã tồn tại hay chưa
    private boolean isUserExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
        connect();
        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, username);
        ResultSet rs = statement.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        statement.close();
        disconnect();
        return count > 0;
    }

    
    public boolean login(User user) throws SQLException {
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
        String hashedPassword = hashPassword(user.getPassword());
        connect();
        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, user.getUsername());
        statement.setString(2, hashedPassword);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            return true;
        } else {
           return false;
        }    
       
    }

  

//    }
    
   
    public static String hashPassword(String password) {
        try {
            // Khởi tạo đối tượng MessageDigest với thuật toán SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Mã hóa mật khẩu thành mảng byte
            byte[] encodedHash = digest.digest(password.getBytes());

            // Chuyển đổi mảng byte thành chuỗi hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            // Xử lý nếu thuật toán không tồn tại
            return null;
        }
    }
}

