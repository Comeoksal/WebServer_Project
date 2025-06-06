<%@ page contentType="text/html; charset=UTF-8"%>
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

.container {
	font-size: large;
	display: flex;
	gap: 40px;
	padding: 80px 40px 40px 40px;
	background-color: #e5eaf5;
	justify-content: center;
}

.sidebar {
	height: 170px;
	width: 200px;
	padding: 20px;
	background-color: white;
	border-radius: 12px;
	font-weight: bold;
	border: 2px solid #5D9CEC;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 20px;
}

.sidebar ul li a {
	text-decoration: none;
	color: black;
}

.sidebar ul li a:hover {
	color: #3b82f6;
}

.sidebar button {
	display: block;
	font-size: large;
	margin: 60px auto 0 auto;
	padding: 6px 20px;
	border-radius: 20px;
	border: 1px solid #3b82f6;
	background-color: white;
	color: #3b82f6;
	cursor: pointer;
}

.info-panel {
	border: 2px solid #5D9CEC;
	width: 800px;
	background-color: white;
	padding: 40px;
	border-radius: 12px;
}

.info-panel h2 {
	font-size: 24px;
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 24px;
	position: relative;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 6px;
}

.form-group input {
	width: 50%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 16px;
}

.form-group button {
	position: absolute; 
	top: 30px;
	left: 500px; 
	padding: 6px 14px;
	background-color: #3b82f6;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.form-group button:hover {
	background-color: #2563eb;
}
</style>
</head>
<body>

	<div class="container">
		<%@ include file="../header.jsp"%>
		<%@ include file="sidebar.jsp"%>
		<%@ include file="info.jsp"%>

	</div>

</body>
</html>
