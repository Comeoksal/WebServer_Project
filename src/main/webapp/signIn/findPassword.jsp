<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 찾기</title>

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #0F111A;
	margin: 0;
	padding-top: 80px;
}

.form-group label {
	color: white;
}

.login-logo {
	width: 80px;
	height: auto;
	display: block;
	margin: 0 auto 10px auto;
}

h2 {
	font-family: 'Courier New', monospace;
	margin-bottom: 30px;
}

.register-container {
	width: 450px;
	margin: 0 auto;
	background-color: #0F111A;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.register-container h2 {
	text-align: center;
	margin-bottom: 24px;
	font-size: 28px;
	color: white;
}

.form-group {
	margin-bottom: 18px;
	text-align: center;
}

.form-group label {
	font-weight: bold;
	text-align: left;
	display: block;
	margin-left: 30px;
	margin-bottom: 6px;
}

.input-wrapper {
	margin-left: 27px;
	display: flex;
	align-items: center;
	background-color: white;
	border: 2px solid #5D9CEC;
	border-radius: 8px;
	width: 400px;
	padding: 12px 12px;
	box-sizing: border-box;
}

.input-wrapper img {
	width: 20px;
	height: 20px;
	margin-right: 10px;
}

.input-wrapper input {
	border: none;
	outline: none;
	flex: 1;
	font-size: 16px;
	background-color: transparent;
}

.form-group input {
	width: 380px;
	padding: 5px;
	border-radius: 8px;
	font-size: 16px;
}

.form-group input[type="checkbox"] {
	width: auto;
}

.form-group a {
	font-size: 14px;
	color: white;
	cursor: pointer;
	text-decoration: underline;
}

.form-group button, .submit-btn {
	padding: 12px 20px;
	background-color: #5D9CEC;
	color: white;
	font-size: 16px;
	border: none;
	border-radius: 10px;
	width: 410px;
	cursor: pointer;
}

.form-group button:hover {
	background-color: #3b82f6;
}

.terms-group {
	margin-left: -10px;
	display: flex;
	align-items: center;
	gap: 12px;
	margin-top: 16px;
}

.terms-label {
	display: flex;
	align-items: center;
	gap: 8px;
	font-weight: bold;
	color: white;
	cursor: pointer;
}

.terms-detail {
	color: #ccc;
	font-size: 14px;
	text-decoration: underline;
	cursor: pointer;
}

.terms-detail:hover {
	color: #5D9CEC;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1001;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow-y: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: white;
	margin: 10% auto;
	padding: 30px;
	border-radius: 8px;
	width: 80%;
	max-width: 600px;
}

.modal h3 {
	margin-top: 0;
	color: #5D9CEC;
}

.close-btn {
	float: right;
	font-size: 20px;
	cursor: pointer;
	color: #999;
}

.close-btn:hover {
	color: #333;
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

<%@ include file="../dbconn.jsp" %>

<c:choose>
	<c:when test="${param.error eq 'empty' }">
		<c:set var="message" value="전화번호 또는 이메일을 입력해주세요." />
	</c:when>
	<c:when test="${param.error eq 'noexist' }">
		<c:set var="message" value="해당 번호 또는 이메일과 일치하는 계정이 없습니다." />
	</c:when>
</c:choose>

<c:if test="${not empty message }">
	<script>
		alert("${message}")
	</script>
</c:if>

<c:if test="${not empty param.findpassword }">
	<sql:query dataSource="${ds}" var="result">
		select password from user where phone = ? and email = ?
		<sql:param value="${param.phone }" />
		<sql:param value="${param.email }" />
	</sql:query>
	<c:if test="${not empty result.rows}">
        <script>
            alert('당신의 비밀번호는 ${result.rows[0].password} 입니다.');
        </script>
    </c:if>
</c:if>

<body>

	<%@ include file="../header.jsp"%>

	<div class="register-container">
		<div style="text-align: center; margin-bottom: 20px;">
			<img
				src="<%=request.getContextPath()%>/resources/images/movitLogo.png"
				alt="movit 로고" class="login-logo"
				style="width: 80px; height: auto; margin-top: 80px; margin-bottom: 10px;" />
			<h2 style="font-size: 45px; margin: 10px 0;">movit</h2>
		</div>
		<form action="processFindPassword.jsp" method="post">

			<div class="form-group">
				<label>전화번호</label>
				<div class="input-wrapper">
					<img src="<%=request.getContextPath()%>/resources/images/phone.png"
						alt="전화 아이콘"> <input type="text"
						name="phone" required placeholder="전화번호를 입력해주세요.">
				</div>
			</div>
			
			<div class="form-group">
				<label>이메일</label>
				<div class="input-wrapper">
					<img src="<%=request.getContextPath()%>/resources/images/email.png"
						alt="이메일 아이콘"> <input type="email" name="email" required
						placeholder="이메일 주소를 입력해주세요.">
				</div>
			</div>
			

			<div class="form-group">
				<button type="submit">비밀번호 찾기</button>
			</div>
			</form>
			<div class="link-row">
				<span><a href="login.jsp" style="text-decoration: none; color: #aaa;'">로그인</a></span><span><a href="findEmail.jsp" style="text-decoration: none; color: #aaa;'">이메일 찾기</a></span>
			</div>

	</div>
</body>
</html>
