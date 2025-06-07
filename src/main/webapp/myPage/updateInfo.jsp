<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="../dbconn.jsp" %>

<%
request.setCharacterEncoding("UTF-8");

String userEmail = (String) session.getAttribute("user_email");
if (userEmail == null) {
    response.sendRedirect("../signIn/login.jsp");
    return;
}

String action = request.getParameter("action");
String value = null;
String sql = "";

if ("nickname".equals(action)) {
    value = request.getParameter("nickname");
    sql = "UPDATE user SET nickname = ? WHERE email = ?";
    session.setAttribute("nickname", value); // ✅ 세션 반영
} else if ("phone".equals(action)) {
    value = request.getParameter("phone");
    sql = "UPDATE user SET phone = ? WHERE email = ?";
} else if ("email".equals(action)) {
    value = request.getParameter("email");
    sql = "UPDATE user SET email = ? WHERE email = ?";
}

if (value != null && !sql.isEmpty()) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, value);
        pstmt.setString(2, userEmail);
        pstmt.executeUpdate();
        pstmt.close();
        conn.close();

        if ("email".equals(action)) {
            session.setAttribute("user_email", value);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}

response.sendRedirect("info.jsp?updated=true");
%>
