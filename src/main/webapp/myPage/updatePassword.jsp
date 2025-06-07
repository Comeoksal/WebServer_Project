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

String currentPw = request.getParameter("currentPw");
String newPw = request.getParameter("newPw");
String confirmPw = request.getParameter("confirmPw");

boolean isValid = false;

if (newPw != null && newPw.equals(confirmPw)) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );

        // 현재 비밀번호 확인
        PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
        checkStmt.setString(1, userEmail);
        checkStmt.setString(2, currentPw);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            isValid = true;
        }

        rs.close();
        checkStmt.close();

        if (isValid) {
            PreparedStatement updateStmt = conn.prepareStatement("UPDATE user SET password = ? WHERE email = ?");
            updateStmt.setString(1, newPw);
            updateStmt.setString(2, userEmail);
            updateStmt.executeUpdate();
            updateStmt.close();
            conn.close();

            out.println("<script>alert('비밀번호가 변경되었습니다.'); location.href='info.jsp';</script>");
        } else {
            conn.close();
            out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
    }
} else {
    out.println("<script>alert('새 비밀번호가 일치하지 않습니다.'); history.back();</script>");
}
%>
