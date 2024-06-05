package com.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.NhanVienDAO;
import com.dao.UserDAO;
import com.model.NhanVien;
import com.model.User;

@WebServlet("/")
public class NhanVienController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NhanVienDAO nhanVienDAO;
    UserDAO userDAO;
    public void init() {
        String jdbcURL = "jdbc:mysql://localhost:3307/NhanVienDB?useUnicode=true&characterEncoding=UTF-8";
        String jdbcUsername = "root";
        String jdbcPassword = "";
        userDAO = new UserDAO(jdbcURL, jdbcUsername, jdbcPassword);
        nhanVienDAO = new NhanVienDAO(jdbcURL, jdbcUsername, jdbcPassword);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String action = request.getServletPath();
    	 try {
             switch (action) {
                 case "/login":
                	 login(request, response);
                     break;
                 case "/register":
                	 register(request, response);
                     break;
                 case "/insert":
                     insertNhanVien(request, response);
                     break;
                 case "/update":
                     updateNhanVien(request, response);
                     break;    
             }
         } catch (SQLException e) {
             throw new ServletException(e);
         }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        // Kiểm tra session trước khi truy cập các trang yêu cầu đăng nhập
        if (action.equals("/") || action.equals("/register") || action.equals("/login")) {
            // Trang đăng nhập và đăng ký không yêu cầu session, cho phép truy cập
            super.doGet(request, response);
            return;
        }

        // Kiểm tra session
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            // Nếu không có session, chuyển hướng đến trang đăng nhập
            response.sendRedirect("Login.jsp");
            return;
        }

        // Xử lý các trang khác sau khi đã đăng nhập
        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
               
                case "/delete":
                    deleteNhanVien(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/search":
                    searchNhanVien(request, response);
                    break;
       
                case "/dangXuat":
                	dangXuat(request, response);
                break;
                default:
                    listNhanVien(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void searchNhanVien(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String keyword = request.getParameter("keyword");
        String gender = request.getParameter("gender");

        List<NhanVien> listNhanVien = nhanVienDAO.searchNhanVien(keyword, gender);
        request.setAttribute("listNhanVien", listNhanVien);
        RequestDispatcher dispatcher = request.getRequestDispatcher("List.jsp");
        dispatcher.forward(request, response);
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
    // Lấy thông tin người dùng từ request
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Kiểm tra xem username và password có rỗng không
    if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
        // Nếu username hoặc password rỗng, hiển thị thông báo lỗi
        request.setAttribute("error", "Vui lòng nhập tên người dùng và mật khẩu.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
        dispatcher.forward(request, response);
        return;
    }
    
    // Kiểm tra độ dài của mật khẩu
    if (password.length() < 8 || password.length() > 12) {
        // Nếu mật khẩu không đủ độ dài, hiển thị thông báo lỗi
        request.setAttribute("error", "Mật khẩu phải có từ 8 đến 12 ký tự.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
        dispatcher.forward(request, response);
        return;
    }
    
    // Kiểm tra xác thực người dùng
    User user = new User(username, password);
    boolean authenticated = userDAO.login(user);
    
    if (authenticated) {
    	 request.getSession().setAttribute("username", username);
    	    // Chuyển hướng đến trang danh sách
    	    response.sendRedirect("homepage.jsp");

    } else {
        // Nếu xác thực không thành công, hiển thị thông báo lỗi
        request.setAttribute("error", "Tên người dùng hoặc mật khẩu không chính xác.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
        dispatcher.forward(request, response);
    }
}

    
    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra xem mật khẩu và mật khẩu xác nhận có khớp nhau không
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem mật khẩu có đủ độ dài từ 8 đến 12 ký tự không
        if (password.length() < 8 || password.length() > 12) {
            request.setAttribute("error", "Mật khẩu phải có từ 8 đến 12 ký tự.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng User từ dữ liệu nhận được từ form
        User user = new User(username, email, password);

        // Thử thêm người dùng vào cơ sở dữ liệu
        try {
            boolean inserted = userDAO.insertUser(user);
            if (inserted) {
                // Nếu thêm thành công, chuyển hướng đến trang thành công hoặc trang đăng nhập
                response.sendRedirect("Login.jsp");
            } else {
                // Nếu thất bại, hiển thị thông báo lỗi
                request.setAttribute("error", "Tài khoản đã tồn tại vui lòng thử lại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log, thông báo lỗi, v.v.
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi đăng ký tài khoản.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    private void listNhanVien(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<NhanVien> listNhanVien = nhanVienDAO.listAllNhanVien();
        request.setAttribute("listNhanVien", listNhanVien);
        RequestDispatcher dispatcher = request.getRequestDispatcher("List.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
        dispatcher.forward(request, response);
    }

    private void insertNhanVien(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        if (request.getCharacterEncoding() == null) request.setCharacterEncoding("UTF-8");
        String maNV = request.getParameter("maNV");
        String ho = request.getParameter("ho");
        String ten = request.getParameter("ten");
        String gioiTinh = request.getParameter("gioiTinh");
        String ngaySinh = request.getParameter("ngaySinh");
        String diaChi = request.getParameter("diaChi");

        NhanVien newNhanVien = new NhanVien(maNV, ho, ten, gioiTinh, ngaySinh, diaChi);
        boolean isInserted = nhanVienDAO.insertNhanVienWithCheck(newNhanVien);
        if (isInserted) {
        	 String suss = "Thêm nhân viên thành công!";
             request.setAttribute("successMessage", suss);
            response.sendRedirect("list");
        } else {
            // Mã nhân viên đã tồn tại, chuyển hướng đến trang error.jsp với thông báo lỗi
            String errorMessage = "Mã nhân viên đã tồn tại!";
            request.setAttribute("loi", errorMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
            dispatcher.forward(request, response);
        }
    }


    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String maNV = request.getParameter("maNV");
        NhanVien existingNhanVien = nhanVienDAO.getNhanVien(maNV);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
        request.setAttribute("nhanVien", existingNhanVien);
        dispatcher.forward(request, response);
    }

    private void updateNhanVien(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        if (request.getCharacterEncoding() == null) request.setCharacterEncoding("UTF-8");
        String maNV = request.getParameter("maNV");
        String ho = request.getParameter("ho");
        String ten = request.getParameter("ten");
        String gioiTinh = request.getParameter("gioiTinh");
        String ngaySinh = request.getParameter("ngaySinh");
        String diaChi = request.getParameter("diaChi");

        // Tạo đối tượng nhân viên với thông tin mới từ form
        NhanVien nhanVien = new NhanVien(maNV, ho, ten, gioiTinh, ngaySinh, diaChi);
        
        // Gọi phương thức updateNhanVien từ DAO để cập nhật thông tin nhân viên vào cơ sở dữ liệu
        nhanVienDAO.updateNhanVien(nhanVien);
        
        // Sau khi cập nhật thành công, chuyển hướng đến trang danh sách nhân viên
        response.sendRedirect("list");
    }


    private void deleteNhanVien(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String maNV = request.getParameter("maNV");

        NhanVien nhanVien = new NhanVien(maNV);
        nhanVienDAO.deleteNhanVien(nhanVien);
        response.sendRedirect("list");
    }
    
    protected void dangXuat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại (nếu có)
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Hủy session nếu tồn tại
            session.invalidate();
        }
        // Chuyển hướng người dùng đến trang đăng nhập sau khi đăng xuất
        response.sendRedirect("Login.jsp");
    }
}
