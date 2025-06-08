<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    request.setCharacterEncoding("utf-8");

    String card = request.getParameter("card");
    String email = (String) session.getAttribute("user_email");

    if (card == null || email == null || !card.matches("^\\d{16}$")) {
%>
<script>
    alert("카드번호는 정확히 16자리 숫자여야 합니다.");
    history.back();
</script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );

        String sql = "UPDATE user SET card_number = ? WHERE email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, card);
        pstmt.setString(2, email);

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
<script>
    alert("카드번호가 성공적으로 등록되었습니다.");
    location.href = "membership.jsp";
</script>
<%
        } else {
%>
<script>
    alert("등록에 실패했습니다.");
    history.back();
</script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
<script>
    alert("오류 발생: <%= e.getMessage() %>");
    history.back();
</script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
