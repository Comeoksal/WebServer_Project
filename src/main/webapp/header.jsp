<%@ page contentType="text/html; charset=UTF-8" %>
<style>
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

<nav class="navbar">
  <div class="nav-left">
    <div class="logo">movit</div>
    <a href="/mainPage/home.jsp">홈</a>
    <a href="/movies.jsp">영화</a>
    <a href="/mylist.jsp">마이리스트</a>
    <a href="/purchasesList.jsp">구매 목록</a>
    <a href="/community.jsp">커뮤니티</a>
  </div>
  <div class="nav-right">
    <button class="login-btn">로그인</button>
  </div>
</nav>
