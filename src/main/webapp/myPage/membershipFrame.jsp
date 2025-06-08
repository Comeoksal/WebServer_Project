<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%@ page session="true" %>

<%
    if (userEmail == null) {
        response.sendRedirect("../signIn/login.jsp");
        return;
    }

    String cardNumber = null;
    String currentPlanName = null;
    int currentPlanId = -1;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<div class="info-panel membership-panel">
  <h1 style="font-size: 45px;">
    멤버십
    <span style="font-size: 20px; color: #5D9CEC;">
      <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
            );

            // 현재 플랜 ID 가져오기
            pstmt = conn.prepareStatement("SELECT membership_id, card_number FROM user WHERE email = ?");
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                currentPlanId = rs.getInt("membership_id");
                cardNumber = rs.getString("card_number");
            }
            rs.close();
            pstmt.close();

            // 현재 플랜 이름 가져오기
            if (currentPlanId != 0) {
                pstmt = conn.prepareStatement("SELECT name FROM membership WHERE id = ?");
                pstmt.setInt(1, currentPlanId);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    currentPlanName = rs.getString("name");
                    out.print("현재 플랜: " + currentPlanName);
                }
            } else {
                out.print("현재 플랜: 없음");
            }
          } catch (Exception e) {
              out.print("플랜 조회 오류: " + e.getMessage());
          } finally {
              try { if (rs != null) rs.close(); } catch (Exception e) {}
              try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
          }
      %>
    </span>
  </h1>

  <!-- 멤버십 리스트 -->
<form method="post" action="membershipPay.jsp">
  <%
    try {
        pstmt = conn.prepareStatement("SELECT id, name, content, price FROM membership");
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String content = rs.getString("content");
            int price = rs.getInt("price");
            boolean isCurrent = (id == currentPlanId);
  %>
  <div class="membership-box" style="<%= isCurrent ? "background-color: #ECF7FF; border: 2px solid #2196F3;" : "" %>">
    <div>
      <div class="membership-name" style="color: #5D9CEC; font-weight: bold;"><%= name %></div>
      <div class="membership-content" style="font-size: smaller;"><%= content %></div>
      <div class="membership-price"><%= price %>원</div>
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
    }
  %>
</form>


  <!-- 카드번호 등록 -->
  <form action="cardRegister.jsp" method="post" style="margin-top: 30px;">
    <label class="membership-label">카드번호 등록</label>
    <div class="membership-input-row">
      <input type="text" name="card" placeholder="카드번호 입력" required class="membership-input" pattern="\d{16}" title="16자리 숫자를 입력하세요">
      <button type="submit" class="membership-btn">등록</button>
    </div>

    <div style="margin-top: 10px; font-size: 14px; color: #333;">
      현재 등록된 카드번호:
      <strong><%= (cardNumber != null && !cardNumber.isEmpty()) ? cardNumber : "등록된 카드가 없습니다." %></strong>
    </div>
  </form>
</div>

<%
    try { if (conn != null) conn.close(); } catch (Exception e) {}
%>
