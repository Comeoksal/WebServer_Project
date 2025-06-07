<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

String url = "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway";
String dbUser = "root";
String dbPass = "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPass);

    String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, username);
    pstmt.setString(2, password); 

    rs = pstmt.executeQuery();

    if (rs.next()) {
        session.setAttribute("username", username);
        response.sendRedirect("home.jsp");
    } else {
        response.sendRedirect("login.jsp?error=true");
    }
} catch (Exception e) {
    out.println("DB 오류: " + e.getMessage());
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
    try { if (conn != null) conn.close(); } catch (Exception e) {}
}
%>
