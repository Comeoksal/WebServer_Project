<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>

body {
	margin: 0;
	padding: 0;
	background-color: #0F111A;
	font-family: 'Noto Sans KR', sans-serif;
	color: white;
	padding-top: 80px;
}

.login-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.login-logo {
	margin-top: 80px;
	width: 90px;
	margin-bottom: 10px;
}

h2 {
	font-family: 'Courier New', monospace;
	margin-bottom: 10px;
}

.error-box{
	margin-top: 40px;
	background-color: #1F2233;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.error-box h2 {
	color: #FF6B6B;
	font-size: 24px;
	margin: 0;
	text-align: center;
}

.home-btn {
    background-color: #E5EAF2;
    color: #5D9CEC;
    font-weight: 500;
    padding: 20px 30px;
    border-radius: 30px;
    border: none;
    font-size: 20px;
    line-height: 1;
    vertical-align: middle;
    display: inline-block;
    box-sizing: border-box;
    margin-top: 20px;
    cursor: pointer;
}

</style>
<title>영화 아이디 오류 페이지</title>
</head>
<body>
<%@ include file="../header.jsp"%>
<div class="login-container">
		<img
			src="<%=request.getContextPath()%>/resources/images/movitLogo.png"
			alt="movit 로고" class="login-logo" />

		<h2 style="font-size: 45px;">movit</h2>
		<div class="error-box">
			<h2>요청하신 영화는 존재하지 않습니다.</h2>
		</div>
		<form action="${pageContext.request.contextPath}/home.jsp">
        	<button class="home-btn">홈으로</button>
        </form>
</div>
</body>
</html>