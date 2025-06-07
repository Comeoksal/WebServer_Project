<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

out.println("email: " + email + "<br>");
out.println("password: " + password + "<br>");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String jdbcUrl = "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway";
    String dbUser = "root";
    String dbPassword = "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt";

    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

    String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, email);
    pstmt.setString(2, password);  

    rs = pstmt.executeQuery();

    if (rs.next()) {
        session.setAttribute("user_email", email);
        session.setAttribute("nickname", rs.getString("nickname"));  
        response.sendRedirect("../header.jsp");
    } else {
        response.sendRedirect("login.jsp?error=1");
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("login.jsp?error=exception");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>

