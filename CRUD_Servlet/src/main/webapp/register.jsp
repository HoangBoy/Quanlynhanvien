<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản | Ludiflex</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
        <link rel="icon" href="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" type="image/x-icon">
    
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            background: #ececec;
        }

        .box-area {
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }

        .left-box {
            background: #103cbe;
            border-radius: 20px 0 0 20px;
            padding: 30px;
            color: white;
            text-align: center;
        }

        .left-box img {
            width: 250px;
        }

        .right-box {
            background: white;
            border-radius: 0 20px 20px 0;
            padding: 30px;
        }

        .form-control-lg {
            border-radius: 20px;
        }

        .btn-primary {
            border-radius: 20px;
        }
    </style>
</head>
<body>
<%@ include file="login1.jsp" %>
<div style="height:30px"></div>
<div class="container d-flex justify-content-center align-items-center min-vh-100">

    <div class="row border rounded-5 p-3 bg-white shadow box-area">

        <div class="col-md-6 rounded-4 d-flex justify-content-center align-items-center flex-column left-box">
            <div class="featured-image mb-3">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" class="img-fluid" alt="Hình ảnh nổi bật">
            </div>
            <p class="fs-2">Đăng ký tài khoản</p>
            <small class="text-wrap">Phần mềm quản lý nhân viên Trường Đại Học Tài Nguyên Và Môi Trường Hà Nội.</small>
        </div>

        <div class="col-md-6 right-box">
            <div class="row align-items-center">
                <div class="header-text mb-4">
                    <h2>Xin chào bạn.</h2>
                    <p>Chúng tôi rất vui khi bạn quay lại.</p>
                </div>
                   <% if (request.getAttribute("error") != null) { %>
    <p style="color: red" class="error-message"><%= request.getAttribute("error") %></p>
<% } %>
			 <form action="register" method="post">
                <div class="input-group mb-3">
                    <input type="text"  name="username" class="form-control form-control-lg bg-light fs-6" placeholder="Tài khoản">
                </div>
                <div class="input-group mb-3">
                    <input type="email"  name="email" class="form-control form-control-lg bg-light fs-6" placeholder="Email">
                </div>
                <div class="input-group mb-3">
                    <input type="password"  name="password" class="form-control form-control-lg bg-light fs-6" placeholder="Mật khẩu">
                </div>
                <div class="input-group mb-3">
                    <input type="password"  name="confirmPassword"class="form-control form-control-lg bg-light fs-6" placeholder="Xác nhận mật khẩu">
                </div>
                <div class="input-group mb-3">
                    <button type="submit" class="btn btn-lg btn-primary w-100 fs-6">Đăng ký</button>
                </div>  </form>
                <div class="row">
                    <small>Đã có tài khoản? <a href="Login.jsp">Đăng nhập</a></small>
                </div>
            </div>
            
        </div>

    </div>
</div>

</body>
</html>
