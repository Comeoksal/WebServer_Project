<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<%
String registered = request.getParameter("registered");
if ("true".equals(registered)) {
%>
<script>
	alert("회원가입이 완료되었습니다. 로그인해주세요!");
</script>
<%
}
%>
<style>
body {
	margin: 0;
	padding: 0;
	background-color: #0F111A;
	color: white;
	padding-top: 80px;
}

.login-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 40px;
}

.login-logo {
	margin-top: 80px;
	width: 90px;
	margin-bottom: 10px;
}

h2 {
	font-family: 'Courier New', monospace;
	margin-bottom: 30px;
}

.login-form {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
}

.input-box {
	display: flex;
	align-items: center;
	background-color: white;
	border: 2px solid #5D9CEC;
	border-radius: 8px;
	padding: 12px 20px;
	margin-bottom: 20px;
	width: 400px;
}

.input-icon-img {
	width: 24px;
	height: 24px;
	margin-right: 12px;
}

.input-box input {
	border: none;
	outline: none;
	font-size: 18px;
	width: 100%;
	background: transparent;
	color: #333;
}

.login-submit-btn {
	padding: 12px 20px;
	background-color: #5D9CEC;
	color: white;
	font-size: 16px;
	border: none;
	border-radius: 10px;
	width: 440px;
	cursor: pointer;
}

.login-submit-btn:hover {
	background-color: #3b82f6;
}

.link-row {
	display: flex;
	justify-content: space-between;
	width: 440px;
	font-size: 14px;
	margin-top: 20px;
	color: #aaa;
}
</style>
</head>
<body>

	<%@ include file="../header.jsp"%>

	<div class="login-container">
		<img
			src="<%=request.getContextPath()%>/resources/images/movitLogo.png"
			alt="movit 로고" class="login-logo" />

		<h2 style="font-size: 45px;">movit</h2>

		<form class="login-form" action="login_check.jsp" method="post">
			<div class="input-box">
				<img src="<%=request.getContextPath()%>/resources/images/email.png"
					class="input-icon-img" alt="이메일 아이콘" /> <input type="text"
					name="email" placeholder="이메일" required />
			</div>

			<div class="input-box">
				<img src="<%=request.getContextPath()%>/resources/images/lock.png"
					class="input-icon-img" alt="비밀번호 아이콘" /> <input type="password"
					name="password" placeholder="비밀번호" required />
			</div>

			<button type="submit" class="login-submit-btn">로그인</button>

			<div class="link-row">
				<span><a href="register.jsp"
					style="text-decoration: none; color: #aaa;'">회원가입</a></span> <span><a href="${pageContext.request.contextPath}/signIn/findEmail.jsp" style="text-decoration: none; color: #aaa;'">이메일</a>
					| <a href="${pageContext.request.contextPath}/signIn/findPassword.jsp" style="text-decoration: none; color: #aaa;'">비밀번호 찾기</a></span>
			</div>

		</form>
	</div>
	<%
	if (request.getParameter("error") != null) {
	%>
	<script>
		alert("아이디 또는 비밀번호가 잘못되었습니다.");
	</script>
	<%
	}
	%>

</body>
</html>
