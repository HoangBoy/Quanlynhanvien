
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>website</title>
  <link rel="stylesheet" href="/CRUD_Servlet/login.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

  <header>
  <style>
  @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800;900&display=swap");

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
  text-decoration: none;
}

body{
  min-height: 100vh;
  background: url(url(https://static.vecteezy.com/system/resources/previews/032/046/714/non_2x/abstract-blue-wave-gradient-background-vector.jpg));
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}

header{
  width: 100%;
  position:fixed;
  left: 0;
  top: 0;
  right: 0;
  background-color: aliceblue;
  padding: 20px 6%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 999;
}
header .logo{
  font-size: 30px;
  text-transform: capitalize;
  letter-spacing: 1px;

}

nav a{
  font-size: 18px;
  text-transform: capitalize;
  margin: 15px;
  padding: 8px;
  color: #111;
  font-weight: 500;
  border-bottom: solid transparent 3px;
  transition: .3s ease;
}
nav a:hover{
  border-bottom: solid #0050d5 3px;
  color: #0050d5;
}
.btn{
  display: inline-block;
  padding: 10px 30px;
  background-color: #0050d5;
  color: #fff;
  border-radius: 10px;
  transition: .3s ease;
  font-size: 20px;
  text-transform: capitalize;
  font-weight: 600;

}
#chek{
  display: none;
}
#chek:checked ~ nav{
  left: 0;
  opacity: 1;
}

label{
  font-size: 35px;
  cursor: pointer;
  color: #111;
  display: none;
}

@media (max-width:898px){
  header{
    padding: 4%;
    transition: .3s ease;
  }
  nav a{
    margin: 10px;
    transition: .3s ease;
  }
}
@media(max-width:798px){
  header nav {
    position: absolute;
    left: -100%;
    top: 100%;
    right: 0;
    width: 100%;
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    transition: .3s ease;
  opacity: 0;

  }
    header nav a{
      display: block;
      text-align: center;
      padding: 10px;
      box-shadow: 0 0 10px #0050d5;
      border-radius: 10px;
      margin-top: 30px;
      font-size: 22px;
    }

  label{
    display: block;
  }
}

section{
  padding: 6%;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.content{
  text-align: center;
  position: relative;
}

.content h1{
  font-size: 60px;
  color: #fff;
  text-transform: capitalize;
  letter-spacing: 1px;

}

.content p{
  line-height: 1.4;
  font-size: 17px;
  color: #eee;
  margin: 20px 30px;
}
section .content .btn{
  background-color: #fff;
  color: #0050d5;
  transition: .3s ease;
}
.btn:hover{
  transform: scale(1.1);
}
  </style>
    <a onclick="showSidebar()" href="#"><img style="width:1px; cursor: pointer; transition: transform 0.3s ease;" alt="" src="https://cdn.icon-icons.com/icons2/510/PNG/512/navicon-round_icon-icons.com_50087.png">
    </a>
    <h1 class="logo">Quản Lý Nhân Viên</h1>
     <% if (session.getAttribute("username") != null) { %>
                <%-- Nếu session tồn tại, hiển thị tên người dùng --%>
                <span class="username">Chào mừng, <%= session.getAttribute("username") %></span>
            <% } %>
     <nav>
      <a href="homepage.jsp">Trang Chủ</a>
      <a href="https://hoangboy.github.io/cv/">Giới Thiệu</a>
      <a href="https://hoangboy.github.io/cv/">Dịch Vụ</a>
      <a href="https://hoangboy.github.io/cv/">Liên Hệ</a>
     </nav>
      <% if (session.getAttribute("username") == null) { %>
                    <%-- Nếu session không tồn tại, hiển thị liên kết đăng ký và đăng nhập --%>
                    <li class="nav-item">
                        <a href="register.jsp" class="btn">Đăng Ký</a>
                    </li>
                    <li class="nav-item">
                         <a href="Login.jsp" class="btn">Đăng Nhập</a>
                    </li>
                <% } else { %>
                    <%-- Nếu có session tồn tại, hiển thị liên kết đăng xuất --%>
                    <li class="nav-item">
                        <a href="dangXuat" class="btn">Đăng Xuất</a>
                    </li>
                <% } %>
    
  </header>
  <!--
  <section>
    <div class="content">
      <h1>responsive navbar</h1>
      <p>If you follow the step-by-step video <br>you will be able to make a
      beautiful website using HTML & CSS
</p>
  <a href="#" class="btn">let's talk</a>
    </div>
  </section>-->

  
</body>
</html>