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

    int membershipId = Integer.parseInt(request.getParameter("membership_id"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );

        pstmt = conn.prepareStatement("UPDATE user SET membership_id = ? WHERE email = ?");
        pstmt.setInt(1, membershipId);
        pstmt.setString(2, userEmail);
        pstmt.executeUpdate();

    } catch (Exception e) {
        out.println("<p style='color:red;'>업데이트 오류: " + e.getMessage() + "</p>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
    
%>

<script>
  window.onload = function() {
    alert("구매해 주셔서 감사합니다!\n멤버십 해지 및 환불 정책은 관련 페이지를 확인해 주세요.");
    window.location.href = "membership.jsp";
  }
</script>

