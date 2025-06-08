<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>마이페이지</title>
<style>
body {
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #E5EAF2;
	padding-top: 80px;
}

.info-panel h1 {	
	position: relative;
	top: -25px;
	left: -280px;
	margin-bottom: 32px;
	text-align: left;
}

.info-panel h3{
	position: relative;
	top: -30px;
	left: 30px;
}

.container {
	font-size: large;
	display: flex;
	gap: 40px;
	padding: 80px 40px 40px 40px;
	background-color: #E5EAF2;
	justify-content: center;
}

.info-panel {
	border: 2px solid #5D9CEC;
	width: 700px;
	background-color: white;
	padding: 40px;
	border-radius: 12px;
	height: 510px;
}

.info-panel h1 {
	font-size: 28px;
	margin-bottom: 32px;
	text-align: center;
}

.form-wrapper {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 24px;
}

.form-group {
	margin-top: -20px;
	margin-bottom: 30px;
	display: flex;
	flex-direction: column;
	width: 100%;
	max-width: 500px;
	gap: 6px;
}

.form-group label {
margin-bottom:7px;
	font-weight: bold;
}

.input-button-wrapper {
	margin-bottom:15px;

	display: flex;
	gap: 12px;
}

.input-button-wrapper input {
	flex: 1;
	width: 350px;
	padding: 10px;
	border: 1px solid #5D9CEC;
	border-radius: 8px;
	font-size: 16px;
}

.form-group button {
	padding: 10px 16px;
	background-color: #5D9CEC;
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
}

</style>
</head>
<body>

	<div class="container">
		<%@ include file="../header.jsp"%>
		<%@ include file="sidebar.jsp"%>
		<%@ include file="securityFrame.jsp"%>

	</div>

</body>
</html>