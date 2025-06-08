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

    String cardNumber = "";
    String userName = "";
    String planName = "";
    int planPrice = 0;
    int planId = Integer.parseInt(request.getParameter("membership_id"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );

        pstmt = conn.prepareStatement("SELECT card_number, name FROM user WHERE email = ?");
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            cardNumber = rs.getString("card_number") != null ? rs.getString("card_number") : "";
            userName = rs.getString("name") != null ? rs.getString("name") : "";
        }
        rs.close();
        pstmt.close();

        pstmt = conn.prepareStatement("SELECT name, price FROM membership WHERE id = ?");
        pstmt.setInt(1, planId);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            planName = rs.getString("name");
            planPrice = rs.getInt("price");
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>데이터 조회 오류: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<style>
  .pay-container {
    max-width: 500px;
    margin: 40px auto;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    font-family: 'Segoe UI', sans-serif;
  }
  .pay-container h2 {
    margin-bottom: 25px;
    color: #333;
  }
  .pay-container label {
    font-weight: bold;
    margin-bottom: 5px;
    display: block;
  }
  .pay-container input, .pay-container select {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }
  .pay-container .info-line {
    font-size: 14px;
    margin-bottom: 15px;
    color: #555;
  }
  .pay-container button {
    width: 100%;
    padding: 12px;
    background-color: #5D9CEC;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
  .pay-container button:hover {
    background-color: #4a8be0;
  }
</style>

<div class="pay-container">
	<h2>결제 정보 입력</h2>
	<div class="info-line">
		선택한 멤버십: <strong><%= planName %></strong><br>
		결제 금액: <strong><%= planPrice %>원</strong>
	</div>
	<form method="post" action="processPayment.jsp" onsubmit="return validateForm(event)">
		<input type="hidden" name="membership_id" value="<%= planId %>">
		<label>이름</label>
		<input type="text" name="user_name" value="<%= userName %>" required />
		<label>카드번호</label>
		<input type="text" name="card_number" value="<%= cardNumber %>" pattern="\d{16}" title="16자리 숫자" required />
		<label>은행 선택</label>
		<select name="bank" required>
			<option value="">은행을 선택하세요</option>
			<option value="국민은행">국민은행</option>
			<option value="신한은행">신한은행</option>
			<option value="우리은행">우리은행</option>
			<option value="하나은행">하나은행</option>
			<option value="농협은행">농협은행</option>
			<option value="카카오뱅크">카카오뱅크</option>
			<option value="토스뱅크">토스뱅크</option>
		</select>
		<button type="submit">결제하기</button>
		<button type="button" onclick="window.location.href='membership.jsp'">돌아가기</button>
	</form>
</div>

<script>
function validateForm(event) {
  const card = document.querySelector('input[name="card_number"]').value;
  if (!/^\d{16}$/.test(card)) {
    alert("카드번호는 16자리 숫자여야 합니다.");
    event.preventDefault();
    return false;
  }
  return true;
}
</script>