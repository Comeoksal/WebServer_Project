<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("user_email") == null) {
        response.sendRedirect("../signIn/login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<div class="info-panel membership-panel">
  <h1 style="font-size: 45px;">멤버십</h1>

  <form method="post" action="membership.jsp">
    <%
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection(
              "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
          );
          pstmt = conn.prepareStatement("SELECT id, name, content, price FROM membership");
          rs = pstmt.executeQuery();

          while (rs.next()) {
              int id = rs.getInt("id");
              String name = rs.getString("name");
              String content = rs.getString("content");
              int price = rs.getInt("price");
    %>
    <div class="membership-box">
      <div>
        <div class="membership-name"><%= name %></div>
        <div class="membership-content"><%= content %></div>
        <div class="membership-price">₩<%= price %>원</div>
      </div>
      <button type="submit" name="membership_id" value="<%= id %>" class="membership-btn">결제</button>
    </div>
    <%
          }
      } catch (Exception e) {
          out.println("<p style='color: red;'>데이터베이스 오류: " + e.getMessage() + "</p>");
      } finally {
          try { if (rs != null) rs.close(); } catch (Exception e) {}
          try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
          try { if (conn != null) conn.close(); } catch (Exception e) {}
      }
    %>
  </form>

  <form action="cardRegister.jsp" method="post" style="margin-top: 30px;">
    <label class="membership-label">카드번호 등록</label>
    <div class="membership-input-row">
      <input type="text" name="card" placeholder="카드번호 입력" required class="membership-input">
      <button type="submit" class="membership-btn">등록</button>
    </div>
  </form>
</div>
