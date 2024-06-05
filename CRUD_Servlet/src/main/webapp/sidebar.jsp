<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <!-- Liên kết font Google để lấy biểu tượng -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
  <style>
  /* Nhập font Google - Poppins */
@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap");

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Poppins", sans-serif;
}

body {
    height: 100vh;
    width: 100%;
    background-image: url("images/hero-bg.jpg");
    background-position: center;
    background-size: cover;
}

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 110px;
    height: 100%;
    display: flex;
    align-items: center;
    flex-direction: column;
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(17px);
    --webkit-backdrop-filter: blur(17px);
    border-right: 1px solid rgba(255, 255, 255, 0.7);
    transition: width 0.3s ease;
}

.sidebar:hover {
    width: 260px;
}

.sidebar .logo {
    color: #000;
    display: flex;
    align-items: center;
    padding: 25px 10px 15px;
}

.logo img {
    width: 43px;
    border-radius: 50%;
}

.logo h2 {
    font-size: 1.15rem;
    font-weight: 600;
    margin-left: 15px;
    display: none;
}

.sidebar:hover .logo h2 {
    display: block;
}

.sidebar .links {
    list-style: none;
    margin-top: 20px;
    overflow-y: auto;
    scrollbar-width: none;
    height: calc(100% - 140px);
}

.sidebar .links::-webkit-scrollbar {
    display: none;
}

.links li {
    display: flex;
    border-radius: 4px;
    align-items: center;
}

.links li:hover {
    cursor: pointer;
    background: #fff;
}

.links h4 {
    color: #222;
    font-weight: 500;
    display: none;
    margin-bottom: 10px;
}

.sidebar:hover .links h4 {
    display: block;
}

.links hr {
    margin: 10px 8px;
    border: 1px solid #4c4c4c;
}

.sidebar:hover .links hr {
    border-color: transparent;
}

.links li span {
    padding: 12px 10px;
}

.links li a {
    padding: 10px;
    color: #000;
    display: none;
    font-weight: 500;
    white-space: nowrap;
    text-decoration: none;
}

.sidebar:hover .links li a {
    display: block;
}

.links .logout-link {
    margin-top: 20px;
}
  </style>
    <aside class="sidebar">
      <div class="logo">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" alt="logo">
        <h2>Nhóm 7</h2>
      </div>
      <ul class="links">
        <h4>Menu Chính</h4>
        <li>
          <span class="material-symbols-outlined">dashboard</span>
          <a href="list">Bảng Điều Khiển</a>
        </li>
        <li>
          <span class="material-symbols-outlined">show_chart</span>
          <a href="list">Thống Kê</a>
        </li>
        <li>
          <span class="material-symbols-outlined">flag</span>
          <a href="hoangboy.github.io/cv/">Báo Cáo</a>
        </li>
        <hr>
        <h4>Nâng Cao</h4>
        <li>
          <span class="material-symbols-outlined">person</span>
          <a href="Form.jsp">Thêm NV</a>
        </li>
        <li>
          <span class="material-symbols-outlined">group</span>
          <a href="">Chỉnh Sửa NV</a>
        </li>
        <li>
          <span class="material-symbols-outlined">ambient_screen</span>
          <a href="https://hoangboy.github.io/cv/">Tạo CV</a>
        </li>
        <li>
          <span class="material-symbols-outlined">pacemaker</span>
          <a href="https://hoangboy.github.io/cv/">Tạo Chủ Đề</a>
        </li>
        <li>
          <span class="material-symbols-outlined">monitoring</span>
          <a href="https://hoangboy.github.io/cv/">Phân Tích</a>
        </li>
        <hr>
        <h4>Tài Khoản</h4>
        <li>
          <span class="material-symbols-outlined">bar_chart</span>
          <a href="https://hoangboy.github.io/cv/">Tổng Quan</a>
        </li>
        <li>
          <span class="material-symbols-outlined">mail</span>
          <a href="https://hoangboy.github.io/cv/">Tin Nhắn</a>
        </li>
        <li>
          <span class="material-symbols-outlined">settings</span>
          <a href="homepage.jsp">Cài Đặt</a>
        </li>
        <li class="logout-link">
          <span class="material-symbols-outlined">logout</span>
          <a href="dangXuat">Đăng Xuất</a>
        </li>
      </ul>
    </aside>
  </body>
</html>
