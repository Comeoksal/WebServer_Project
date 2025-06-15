<%@ page contentType="text/html; charset=utf-8"%>
<%
String uri = request.getRequestURI();
%>
<style>
.sidebar ul li a {
	font-size: 20px !important;
	text-decoration: none;
	color: black;
	font-weight: bold;
}

.sidebar ul li a.active {
	color: #5D9CEC;
}

.sidebar {
	height: 170px !important;
	width: 200px !important;
	padding: 20px !important;
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
	margin-bottom: 20px !important;
}

.sidebar ul li a {
	text-decoration: none;
	color: black;
}

.sidebar ul li a:hover {
	color: #3b82f6;
}

.sidebar .btn-group {
	display: flex;
	justify-content: space-between;
	margin-top: 80px;
	margin-right: 30px;
	gap: 30px;
}

.sidebar .btn-group form {
	flex: 1;
}

.sidebar .btn-group button {
	width: 130%;
	padding: 6px 13px;
	border-radius: 20px;
	border: 1px solid #3b82f6;
	background-color: white;
	color: #3b82f6;
	cursor: pointer;
	font-size: 18px;
}

.sidebar .btn-group button:hover {
	background-color: #e6f0ff;
}
</style>
<div class="sidebar">
	<ul>
		<li><a href="info.jsp"
			class="<%=uri.contains("info.jsp") ? "active" : ""%>">내 정보</a></li>
		<li><a href="membership.jsp"
			class="<%=uri.contains("membership.jsp") ? "active" : ""%>">멤버십</a></li>
		<li><a href="security.jsp"
			class="<%=uri.contains("security.jsp") ? "active" : ""%>">보안</a></li>
	</ul>
	
	<div class="btn-group">
		<form action="${pageContext.request.contextPath}/home.jsp">
			<button type="submit">돌아가기</button>
		</form>
		<form action="<%=request.getContextPath()%>/signIn/logout.jsp" method="post">
			<button type="submit">로그아웃</button>
		</form>
	</div>
</div>


