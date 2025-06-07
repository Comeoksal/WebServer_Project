<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true"%>
<%@ include file="../dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8");

    String phone = "";

    if (userEmail == null) {
        response.sendRedirect("../signIn/login.jsp");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://shortline.proxy.rlwy.net:58435/railway", "root", "pZCeLltpdUdDDzaYfEpPwBIIRTrIomgt"
        );
        PreparedStatement pstmt = conn.prepareStatement("SELECT phone FROM user WHERE email = ?");
        pstmt.setString(1, userEmail);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            phone = rs.getString("phone");
        }
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    String nicknamePlaceholder = (nickname == null || nickname.trim().isEmpty()) ? "닉네임이 없습니다." : nickname;
    String phonePlaceholder = (phone == null || phone.trim().isEmpty()) ? "전화번호가 없습니다." : phone;
    String emailPlaceholder = (userEmail == null || userEmail.trim().isEmpty()) ? "이메일이 없습니다." : userEmail;
%>


<div class="info-panel">
	<h1 style="font-size: 45px;">내 정보</h1>

	<div class="form-wrapper">
		<form action="updateInfo.jsp" method="post">
			<div class="form-group">
				<label>닉네임</label>
				<div class="input-button-wrapper">
					<input type="text" name="nickname" placeholder="<%=nicknamePlaceholder%>" />
					<button type="submit" name="action" value="nickname">변경</button>
				</div>
			</div>

			<div class="form-group">
				<label>전화번호</label>
				<div class="input-button-wrapper">
					<input type="text" name="phone" placeholder="<%=phonePlaceholder%>" />
					<button type="submit" name="action" value="phone">변경</button>
				</div>
			</div>

			<div class="form-group">
				<label>이메일 주소</label>
				<div class="input-button-wrapper">
					<input type="email" name="email" placeholder="<%=emailPlaceholder%>" />
					<button type="submit" name="action" value="email">변경</button>
				</div>
			</div>
		</form>
	</div>
</div>

<%
    String updated = request.getParameter("updated"); 
    if ("true".equals(updated)) { 
%>
<script>
    alert("변경되었습니다!");
</script>
<% } %>
