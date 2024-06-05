package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.model.NhanVien;

public class NhanVienDAO {
    private String jdbcURL;
    private String jdbcUsername;
    private String jdbcPassword;
    private Connection jdbcConnection;

    public NhanVienDAO(String jdbcURL, String jdbcUsername, String jdbcPassword) {
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
            jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        }
    }

    protected void disconnect() throws SQLException {
        if (jdbcConnection != null && !jdbcConnection.isClosed()) {
            jdbcConnection.close();
        }
    }
    public List<NhanVien> searchNhanVien(String keyword, String gender) throws SQLException {
        List<NhanVien> listNhanVien = new ArrayList<>();
        String sql = "SELECT * FROM NhanVien WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (Ho LIKE ? OR Ten LIKE ?)";
        }
        if (gender != null && !gender.trim().isEmpty()) {
            sql += " AND GioiTinh = ?";
        }

        connect();
        PreparedStatement statement = jdbcConnection.prepareStatement(sql);

        int index = 1;
        if (keyword != null && !keyword.trim().isEmpty()) {
            statement.setString(index++, "%" + keyword + "%");
            statement.setString(index++, "%" + keyword + "%");
        }
        if (gender != null && !gender.trim().isEmpty()) {
            statement.setString(index++, gender);
        }

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String maNV = resultSet.getString("MaNV");
            String ho = resultSet.getString("Ho");
            String ten = resultSet.getString("Ten");
            String gioiTinh = resultSet.getString("GioiTinh");
            String ngaySinh = resultSet.getString("NgaySinh");
            String diaChi = resultSet.getString("DiaChi");

            NhanVien nhanVien = new NhanVien(maNV, ho, ten, gioiTinh, ngaySinh, diaChi);
            listNhanVien.add(nhanVien);
        }

        resultSet.close();
        statement.close();
        disconnect();

        return listNhanVien;
    }
    public boolean insertNhanVien(NhanVien nhanVien) throws SQLException {
        String sql = "INSERT INTO NhanVien (MaNV, Ho, Ten, GioiTinh, NgaySinh, DiaChi) VALUES (?, ?, ?, ?, ?, ?)";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, nhanVien.getMaNV());
        statement.setString(2, nhanVien.getHo());
        statement.setString(3, nhanVien.getTen());
        statement.setString(4, nhanVien.getGioiTinh());
        statement.setString(5, nhanVien.getNgaySinh());
        statement.setString(6, nhanVien.getDiaChi());

        boolean rowInserted = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowInserted;
    }
    
    public boolean insertNhanVienWithCheck(NhanVien nhanVien) throws SQLException {
        if (isNhanVienExists(nhanVien.getMaNV())) {
            // Mã nhân viên đã tồn tại, trả về false hoặc ném một ngoại lệ tùy vào nhu cầu của bạn
            return false;
        } else {
            // Mã nhân viên chưa tồn tại, thêm nhân viên vào cơ sở dữ liệu và trả về true
            return insertNhanVien(nhanVien);
        }
    }

    public boolean isNhanVienExists(String maNV) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM nhanvien WHERE maNV = ?";
        connect();
        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, maNV);
        ResultSet resultSet = statement.executeQuery();
        int count = 0;
        if (resultSet.next()) {
            count = resultSet.getInt("count");
        }
        resultSet.close();
        statement.close();
        disconnect();
        return count > 0;
    }


    public List<NhanVien> listAllNhanVien() throws SQLException {
        List<NhanVien> listNhanVien = new ArrayList<>();

        String sql = "SELECT * FROM NhanVien";

        connect();

        Statement statement = jdbcConnection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            String maNV = resultSet.getString("MaNV");
            String ho = resultSet.getString("Ho");
            String ten = resultSet.getString("Ten");
            String gioiTinh = resultSet.getString("GioiTinh");
            String ngaySinh = resultSet.getString("NgaySinh");
            String diaChi = resultSet.getString("DiaChi");

            NhanVien nhanVien = new NhanVien(maNV, ho, ten, gioiTinh, ngaySinh, diaChi);
            listNhanVien.add(nhanVien);
        }

        resultSet.close();
        statement.close();

        disconnect();

        return listNhanVien;
    }

    public boolean deleteNhanVien(NhanVien nhanVien) throws SQLException {
        String sql = "DELETE FROM NhanVien where MaNV = ?";

        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, nhanVien.getMaNV());

        boolean rowDeleted = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowDeleted;
    }

    public boolean updateNhanVien(NhanVien nhanVien) throws SQLException {
        String sql = "UPDATE NhanVien SET Ho = ?, Ten = ?, GioiTinh = ?, NgaySinh = ?, DiaChi = ?";
        sql += " WHERE MaNV = ?";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, nhanVien.getHo());
        statement.setString(2, nhanVien.getTen());
        statement.setString(3, nhanVien.getGioiTinh());
        statement.setString(4, nhanVien.getNgaySinh());
        statement.setString(5, nhanVien.getDiaChi());
        statement.setString(6, nhanVien.getMaNV());

        boolean rowUpdated = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowUpdated;
    }

    public NhanVien getNhanVien(String maNV) throws SQLException {
        NhanVien nhanVien = null;
        String sql = "SELECT * FROM NhanVien WHERE MaNV = ?";

        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, maNV);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String ho = resultSet.getString("Ho");
            String ten = resultSet.getString("Ten");
            String gioiTinh = resultSet.getString("GioiTinh");
            String ngaySinh = resultSet.getString("NgaySinh");
            String diaChi = resultSet.getString("DiaChi");

            nhanVien = new NhanVien(maNV, ho, ten, gioiTinh, ngaySinh, diaChi);
        }

        resultSet.close();
        statement.close();

        return nhanVien;
    }
}
