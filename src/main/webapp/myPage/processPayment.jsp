<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%@ page session="true" %>

<%
    String userEmail = (String) session.getAttribute("user_email");
    if (userEmail == null) {
        response.sendRedirect("../signIn/login.jsp");
        return;
    }

    String password = request.getParameter("password");
    int membershipId = Integer.parseInt(request.getParameter("membership_id"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    boolean passwordMatch = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );

        pstmt = conn.prepareStatement("SELECT password FROM user WHERE email = ?");
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            String storedPassword = rs.getString("password");
            if (storedPassword != null && storedPassword.equals(password)) {
                passwordMatch = true;
            }
        }
        rs.close();
        pstmt.close();

        if (passwordMatch) {
            pstmt = conn.prepareStatement("UPDATE user SET membership_id = ? WHERE email = ?");
            pstmt.setInt(1, membershipId);
            pstmt.setString(2, userEmail);
            pstmt.executeUpdate();
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>오류: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<% if (passwordMatch) { %>
<script>
  window.onload = function() {
    document.getElementById("modal").style.display = "flex";
  };

  function redirectToMembership() {
    window.location.href = "membership.jsp";
  }
</script>

<div id="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
  <div style="background:white; padding:30px; border-radius:10px; text-align:center;">
    <h3>구매해 주셔서 감사합니다!</h3>
    <p>
      회원님의 멤버십이 정상적으로 활성화되었습니다.<br>
      해지는 언제든지 <strong>마이페이지</strong>에서 가능합니다.<br>
      환불 및 약관은 관련 페이지를 참조하세요.
    </p>
    <button onclick="redirectToMembership()" style="padding:10px 20px; background:#5D9CEC; color:white; border:none; border-radius:5px;">확인</button>
  </div>
</div>
<% } else { %>
<script>
  alert("비밀번호가 일치하지 않습니다.");
  history.back();
</script>
<% } %>
