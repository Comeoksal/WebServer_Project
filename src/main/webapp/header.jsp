<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>MOVIT</title>
  <style>
    body {
      margin: 0;
      background-color: #0F111A;
    }
    
    .navbar {
      position: fixed;              
      top: 0;
      left: 0;
      width: 100%;
      z-index: 1000;              
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #5D9CEC;
      padding: 12px 24px;
      overflow-x: hidden;
    }

    .nav-left {
      display: flex;
      align-items: center;
      gap: 32px;
    }

    .nav-left .logo {
      font-weight: bold;
      font-size: 20px;
      color: #E5EAF2;
      font-family: 'Courier New', monospace;
    }

    .nav-left a {
      text-decoration: none;
      color: #E5EAF2;
      font-size: 15px;
    }

    .nav-right .login-btn {
      position: relative;
      right: 90px;
      background-color: #E5EAF2;
      color: #5D9CEC;
      margin-left: auto;
      font-weight: 500;
      padding: 10px 18px;
      border-radius: 20px;
      border: none;
      cursor: pointer;
    }

  </style>
</head>
<body>

  <nav class="navbar">
    <div class="nav-left">
      <div class="logo">movit</div>
      <a href="<c:url value='/home.jsp' />">홈</a>
      <a href="<c:url value='/movies.jsp' />">영화</a>
      <a href="<c:url value='/mylist.jsp' />">마이리스트</a>
      <a href="<c:url value='/purchasesList.jsp' />">구매 목록</a>
      <a href="<c:url value='/community.jsp' />">커뮤니티</a>
    </div>
    <div class="nav-right">
      <button class="login-btn"> 로그인</button>
    </div>
  </nav>