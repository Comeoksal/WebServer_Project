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

.sidebar button {
	display: block;
	font-size: large;
	margin: 100px auto 0 auto;
	padding: 6px 20px;
	border-radius: 20px;
	border: 1px solid #3b82f6;
	background-color: white;
	color: #3b82f6;
	cursor: pointer;
}

</style>
<div class="sidebar">
	<ul>
		<li><a href="info.jsp"
			class="<%= uri.contains("info.jsp") ? "active" : "" %>">내 정보</a></li>
		<li><a href="membership.jsp"
			class="<%= uri.contains("membership.jsp") ? "active" : "" %>">멤버십</a></li>
		<%-- <li><a href="language.jsp"
			class="<%= uri.contains("language.jsp") ? "active" : "" %>">언어 설정</a></li> --%>
		<li><a href="security.jsp"
			class="<%= uri.contains("security.jsp") ? "active" : "" %>">보안</a></li>
	</ul>
	<button onclick="history.back()">돌아가기</button>
	<form action="<%=request.getContextPath()%>/signIn/logout.jsp"
		method="post" style="text-align: center; margin-top: 20px;">
		<button type="submit">로그아웃</button>
	</form>

</div>
