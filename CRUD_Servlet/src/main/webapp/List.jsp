<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<html lang="vi">
<head>
    <title>Quản lý Nhân Viên</title>
      <link rel="icon" href="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" type="image/x-icon">
  
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .starter-template {
            padding: 3rem 1.5rem;
            text-align: center;
        }
        .form-container {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
           body {
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 20px;
        }
        .sidebar {
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            background-color: #f8f9fa;
            padding-top: 20px;
            overflow-x: hidden;
            transition: transform 0.3s ease;
            z-index: 1000;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: #333;
            display: block;
        }
        .sidebar a:hover {
            background-color: #ddd;
            color: #000;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }
        .collapsed-sidebar {
            transform: translateX(-250px);
        }
        .collapsed-content {
            margin-left: 10px;
        }
        h1, h2 {
            text-align: center;
        }
        .hover-area {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 100px;
            background: transparent;
            z-index: 999;
        }
    </style>
   
    <script>
        function confirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa nhân viên này không?");
        }

        
        }
    </script>
</head>
<body>
<%@ include file="sidebar.jsp" %>
<%@ include file="login1.jsp" %>


 <% if (request.getAttribute("successMessage") != null) { %>
    <p style="color: green" class="error-message"><%= request.getAttribute("successMessage") %></p>
<% } %>


<div class="hover-area sidebar a" onclick="showSidebar()" onclick="hideSidebar()" onmouseover="hideSidebar()"></div>
<div class="sidebar collapsed-sidebar" id="sidebar">
    <a href="List.jsp">Trang chủ</a>
    <a href="new">Thêm Nhân Viên Mới</a>
    <a href="list">Danh Sách Nhân Viên</a>
    <a href="profile.jsp">Thông Tin Cá Nhân</a>
    <a href="settings.jsp">Cài Đặt</a>
    <% if (session.getAttribute("username") != null) { %>
        <a href="dangXuat">Đăng xuất</a>
    <% } else { %>
        <a href="Login.jsp">Đăng nhập</a>
    <% } %>
</div>

<div  class="content collapsed-content" id="content" onmouseover="hideSidebar()">
    <div class="container">
      
       
                
            </div>
        </div>



   
            
                <img style="margin-top: 100px ;margin-buton: 0;max-width: 100px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" alt="Logo" class="img-fluid mx-auto d-block" style="max-width: 100px;">
            </div>
        </div>
        <div class="container" onmouseover="hideSidebar()">
            <div style="padding-top:10px" class="starter-template">
                <h1>Quản lý Nhân Viên</h1>
                <div class="row">
                    <div class="col">
                        <h2>
                            <a href="new" class="btn btn-primary">Thêm Nhân Viên Mới</a>
                            <a href="list" class="btn btn-secondary">Danh Sách Nhân Viên</a>
                        </h2>
                    </div>
                </div>
            </div>
            </div>

      <div class="container" style="margin-top: 20px;">
        <form action="search" method="get" class="form-inline">
            <input type="text" name="keyword" class="form-control mr-sm-2" placeholder="Tìm kiếm theo tên" value="${param.keyword}">
            <select name="gender" class="form-control mr-sm-2">
                <option value="">Tất cả</option>
                <option value="Nam" <c:if test="${param.gender == 'Nam'}">selected</c:if>>Nam</option>
                <option value="Nữ" <c:if test="${param.gender == 'Nữ'}">selected</c:if>>Nữ</option>
            </select>
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </form>
    </div>

<div class="container" onmouseover="hideSidebar()">
    <div class="row">
        <c:forEach var="nhanVien" items="${listNhanVien}">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoynJfvZC_OGCX0Bc7jlP9NOgbyWauirNFxlcgD6y1mrV0PHOqY_2xo9R-nkSoB4FVkHQ&usqp=CAU" class="card-img-top" alt="Ảnh nhân viên">
                    <div class="card-body">
                        <h5 class="card-title">${nhanVien.ho} ${nhanVien.ten}</h5>
                        <p class="card-text">
                            <strong>Mã Nhân Viên:</strong> ${nhanVien.maNV}<br>
                            <strong>Giới Tính:</strong> ${nhanVien.gioiTinh}<br>
                            <strong>Ngày Sinh:</strong> ${nhanVien.ngaySinh}<br>
                            <strong>Địa Chỉ:</strong> ${nhanVien.diaChi}<br/>
                               <strong><a href="https://hoangboy.github.io/cv">Xem Cv</a></strong>
                        </p>
                        <a href="edit?maNV=${nhanVien.maNV}" class="btn btn-info">Chỉnh Sửa</a>
                        <a href="${contextPath}/delete?maNV=${nhanVien.maNV}" class="btn btn-danger" onclick="return confirmDelete()">Xóa</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    function showSidebar() {
        document.getElementById("sidebar").classList.remove("collapsed-sidebar");
        document.getElementById("content").classList.remove("collapsed-content");
    }

    function hideSidebar() {
        document.getElementById("sidebar").classList.add("collapsed-sidebar");
        document.getElementById("content").classList.add("collapsed-content");
    }
</script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
