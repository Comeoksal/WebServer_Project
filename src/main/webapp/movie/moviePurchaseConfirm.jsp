<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="../dbconn.jsp" %>
<%@ include file="../header.jsp" %>

<%
    if (userEmail == null) {
%>
    <script>
        alert("로그인이 필요합니다.");
        location.href = "<c:url value='/signIn/login.jsp' />";
    </script>
<%
        return;
    }

    String movieId = request.getParameter("movie_id");
    String cardNumber = "";
    String userName = "";
    String movieTitle = "";
    int price = 0;
    String errorMsg = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );

        // 사용자 정보 조회
        pstmt = conn.prepareStatement("SELECT id, name, card_number FROM user WHERE email = ?");
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        String userId = null;
        if (rs.next()) {
            userId = rs.getString("id");
            userName = rs.getString("name") != null ? rs.getString("name") : "";
            cardNumber = rs.getString("card_number") != null ? rs.getString("card_number") : "";
        }
        rs.close();
        pstmt.close();

        if (userId == null) {
            errorMsg = "사용자 정보를 찾을 수 없습니다.";
        } else {
            // 영화 정보 조회
            pstmt = conn.prepareStatement("SELECT title, price FROM movie WHERE id = ?");
            pstmt.setString(1, movieId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                movieTitle = rs.getString("title");
                price = rs.getInt("price");
            }
            rs.close();
            pstmt.close();

            // 구매 INSERT
            pstmt = conn.prepareStatement("INSERT INTO purchase (user_id, movie_id) VALUES (?, ?)");
            pstmt.setString(1, userId);
            pstmt.setString(2, movieId);
            pstmt.executeUpdate();
            pstmt.close();
        }
    } catch (Exception e) {
        errorMsg = "구매 처리 중 오류가 발생했습니다: " + e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<style>
.purchase-container {
    max-width: 500px;
    margin: 40px auto;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    font-family: 'Segoe UI', sans-serif;
}
.purchase-container h2 {
    margin-bottom: 20px;
    color: #333;
}
.purchase-container .info {
    margin-bottom: 20px;
    font-size: 15px;
    color: #444;
}
.purchase-container .btn {
    padding: 10px 20px;
    background-color: #5D9CEC;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    margin-right: 10px;
    text-decoration: none;
}
.purchase-container .btn:hover {
    background-color: #4a8be0;
}
</style>

<div class="purchase-container">
<% if (!errorMsg.isEmpty()) { %>
    <h2 style="color:red;">오류 발생</h2>
    <p><%= errorMsg %></p>
<% } else { %>
    <h2>구매가 완료되었습니다!</h2>
    <div class="info">
        <p><strong>영화 제목:</strong> <%= movieTitle %></p>
        <p><strong>결제 금액:</strong> <%= price %>원</p>
        <p><strong>구매자:</strong> <%= userName %></p>
        <p><strong>카드 번호:</strong> <%= cardNumber %></p>
    </div>
    <a class="btn" href="movie.jsp?id=<%= movieId %>">영화 보러가기</a>
    <a class="btn" href="/index.jsp">홈으로</a>
<% } %>
</div>
