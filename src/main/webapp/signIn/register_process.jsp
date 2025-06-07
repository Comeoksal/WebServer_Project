<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8");

String email = request.getParameter("email");
String password = request.getParameter("password");
String confirm = request.getParameter("confirm");

if (email == null || password == null || confirm == null ||
    email.trim().equals("") || password.trim().equals("") || confirm.trim().equals("")) {
    response.sendRedirect("register.jsp?error=empty");
    return;
}

if (!password.equals(confirm)) {
    response.sendRedirect("register.jsp?error=mismatch");
    return;
}

Connection conn = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String jdbcUrl = "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway";
    String dbUser = "root";
    String dbPassword = "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt";

    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

    String checkSql = "SELECT COUNT(*) FROM user WHERE email = ?";
    pstmt = conn.prepareStatement(checkSql);
    pstmt.setString(1, email);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next() && rs.getInt(1) > 0) {
        response.sendRedirect("register.jsp?error=exists");
        return;
    }
    pstmt.close();

    String insertSql = "INSERT INTO user (email, password, nickname, role, created_at, membership_id) VALUES (?, ?, ?, ?, NOW(), ?)";
    pstmt = conn.prepareStatement(insertSql);
    pstmt.setString(1, email);
    pstmt.setString(2, password);
    pstmt.setString(3, ""); 
    pstmt.setString(4, "user");
    pstmt.setInt(5, 1); 
    int result = pstmt.executeUpdate();

    if (result > 0) {
        response.sendRedirect("login.jsp?registered=true");
    } else {
        response.sendRedirect("register.jsp?error=fail");
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("register.jsp?error=exception");
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>
