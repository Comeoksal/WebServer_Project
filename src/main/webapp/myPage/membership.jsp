<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>마이페이지 - 멤버십</title>
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
	left: -220px;
	margin-bottom: 32px;
	text-align: left
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
	height: 530px;
}

.info-panel h1 {
	font-size: 28px;
	margin-bottom: 32px;
	text-align: center;
}

.membership-panel .membership-box {
	margin-bottom: 16px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border: 1px solid #5D9CEC;
	padding: 12px;
	border-radius: 8px;
}

.membership-panel .membership-name {
	font-size: 18px;
}

.membership-panel .membership-btn {
	background-color: #5D9CEC;
	color: white;
	border: none;
	padding: 6px 14px;
	border-radius: 6px;
	cursor: pointer;
}

.membership-panel .membership-label {
	font-weight: bold;
	display: block;
	margin-bottom: 6px;
}

.membership-panel .membership-input-row {
	display: flex;
	gap: 10px;
}

.membership-panel .membership-input {
	flex: 1;
	padding: 10px;
	border-radius: 6px;
	border: 1px solid #5D9CEC;
 }
</style>
</head>
<body>
	<div class="container">
		<%@ include file="../header.jsp"%>
		<%@ include file="sidebar.jsp"%>
		<%@ include file="membershipFrame.jsp"%>
	</div>
</body>
</html>
