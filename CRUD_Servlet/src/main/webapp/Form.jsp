<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Trị Nhân Viên</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="icon" href="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" type="image/x-icon">
    
    <style>
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
</head>
<body>

<%@ include file="login1.jsp" %>
<%@ include file="sidebar.jsp" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light" onmouseover="hideSidebar()">
    <div class="container">
        
    </div>
</nav>

<div class="hover-area sidebar a" onclick="showSidebar()" onclick="hideSidebar()"></div>
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
        <div class="row">
            <div class="col">
 <img style="margin-top: 20px ;margin-buton: 0;max-width: 100px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" alt="Logo" class="img-fluid mx-auto d-block" style="max-width: 100px;">            </div>
        </div>
        <div class="row">
            <div class="col">
                <h1>Quản lý Nhân Viên</h1>
                <h2>
                    <a href="new" class="btn btn-primary">Thêm Nhân Viên Mới</a>
                    <a href="list" class="btn btn-secondary">Danh Sách Nhân Viên</a>
                </h2>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <c:if test="${nhanVien != null}">
                    <form action="update" method="post">
                </c:if>
                <c:if test="${nhanVien == null}">
                    <form action="insert" method="post">
                </c:if>
                <caption style="caption-side: top; font-weight: bold; font-size: larger;">
                    <c:if test="${nhanVien != null}">
                        Chỉnh Sửa Thông Tin Nhân Viên
                    </c:if>
                    <c:if test="${nhanVien == null}">
                        Thêm Nhân Viên Mới
                    </c:if>
                    <c:if test="${loi != null}">
                        <i style="color:red">Mã nhân viên đã tồn tại</i>
                    </c:if>
                </caption>
                <table class="table table-bordered table-striped">
                    <tr>
                        <th scope="row">Mã Nhân Viên:</th>
                        <td>
                            <c:if test="${nhanVien != null}">
                                <input type="text" name="maNV" class="form-control" value="<c:out value='${nhanVien.maNV}' />" readonly>
                            </c:if>
                            <c:if test="${nhanVien == null}">
                                <input type="text" name="maNV" class="form-control" required>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Họ:</th>
                        <td>
                            <input type="text" name="ho" class="form-control" value="<c:out value='${nhanVien.ho}' />" required>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Tên:</th>
                        <td>
                            <input type="text" name="ten" class="form-control" value="<c:out value='${nhanVien.ten}' />" required>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Giới Tính:</th>
                        <td>
                            <select name="gioiTinh" class="form-control" required>
                                <option value="Nam" <c:if test="${nhanVien.gioiTinh == 'Nam'}">selected</c:if>>Nam</option>
                                <option value="Nữ" <c:if test="${nhanVien.gioiTinh == 'Nữ'}">selected</c:if>>Nữ</option>
                                <option value="Khác" <c:if test="${nhanVien.gioiTinh == 'Khác'}">selected</c:if>>Khác</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Ngày Sinh:</th>
                        <td>
                            <input type="date" name="ngaySinh" class="form-control" value="<c:out value='${nhanVien.ngaySinh}' />" required>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Địa Chỉ:</th>
                        <td>
                            <input type="text" name="diaChi" class="form-control" value="<c:out value='${nhanVien.diaChi}' />" required>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="Lưu" class="btn btn-success">
                        </td>
                    </tr>
                </table>
                </form>
            </div>
        </div>
    </div>   
</div>

<div class="container">
    <div class="row">
        <c:forEach var="nhanVien" items="${listNhanVien}">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <img src="URL_HINH_ANH" class="card-img-top" alt="Ảnh nhân viên">
                    <div class="card-body">
                        <h5 class="card-title">${nhanVien.ho} ${nhanVien.ten}</h5>
                        <p class="card-text">
                            <strong>Mã Nhân Viên:</strong> ${nhanVien.maNV}<br>
                            <strong>Giới Tính:</strong> ${nhanVien.gioiTinh}<br>
                            <strong>Ngày Sinh:</strong> ${nhanVien.ngaySinh}<br>
                            <strong>Địa Chỉ:</strong> ${nhanVien.diaChi}
                        </p>
                        <a href="edit?maNV=${nhanVien.maNV}" class="btn btn-info">Chỉnh Sửa</a>
                        <a href="${contextPath}/delete?maNV=${nhanVien.maNV}" class="btn btn-danger" onclick="return confirmDelete()">Xóa</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
</body>
</html>
                            
