<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>이메일 찾기</title>
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

.findemail-container {
	width: 450px;
	margin: 0 auto;
	background-color: #0F111A;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.findemail-container h2 {
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
	width: 440px;
	border: none;
	outline: none;
	flex: 1;
	font-size: 18px;
	background-color: transparent;
}

.form-group input {
	width: 440px;
	padding: 5px;
	border-radius: 8px;
	font-size: 16px;
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
	width: 440px;
	cursor: pointer;
}

.form-group button:hover {
	background-color: #3b82f6;
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
		<c:set var="message" value="전화번호를 입력해주세요." />
	</c:when>
	<c:when test="${param.error eq 'noexist' }">
		<c:set var="message" value="존재하지 않는 번호입니다." />
	</c:when>
</c:choose>

<c:if test="${not empty message }">
	<script>
		alert("${message}")
	</script>
</c:if>

<c:if test="${not empty param.findemail }">
	<sql:query dataSource="${ds}" var="result">
		select email from user where phone = ?
		<sql:param value="${param.phone }" />
	</sql:query>
	<c:if test="${not empty result.rows}">
        <script>
            alert('당신의 이메일은 ${result.rows[0].email} 입니다.');
        </script>
    </c:if>
</c:if>

<body>

	<%@ include file="../header.jsp"%>

	<div class="findemail-container">
		<div style="text-align: center; margin-bottom: 20px;">
			<img
				src="<%=request.getContextPath()%>/resources/images/movitLogo.png"
				alt="movit 로고" class="login-logo"
				style="width: 80px; height: auto; margin-top: 80px; margin-bottom: 10px;" />
			<h2 style="font-size: 45px; margin: 10px 0;">movit</h2>
		</div>
		<form action="processFindEmail.jsp" method="post">

			<div class="form-group">
				<label>전화번호</label>
				<div class="input-wrapper">
					<img src="<%=request.getContextPath()%>/resources/images/phone.png"
						alt="전화 아이콘"> 
						<input type="text"
						name="phone" required placeholder="전화번호를 입력해주세요.">
				</div>
			</div>

			<div class="form-group">
				<button type="submit">이메일 찾기</button>
			</div>
			
			<div class="link-row">
				<span><a href="login.jsp" style="text-decoration: none; color: #aaa;'">로그인</a></span><span><a href="findPassword.jsp" style="text-decoration: none; color: #aaa;'">비밀번호 찾기</a></span>
			</div>
		</form>

	</div>
</body>
</html>
