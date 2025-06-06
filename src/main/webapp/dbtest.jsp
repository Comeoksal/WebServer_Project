<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>DB 연결 테스트</title>
</head>
<body>
<%
    String url = "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway";
    String user = "root";
    String password = "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt";

    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        out.println("연결 성공");
    } 
    catch (Exception e) {
        out.println("연결 실패");
        out.println("<pre>" + e.toString() + "</pre>");
    } 
    finally {
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
