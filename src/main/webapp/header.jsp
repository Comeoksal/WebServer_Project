<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<%
String userEmail = (String) session.getAttribute("user_email");
String nickname = (String) session.getAttribute("nickname");
%>
<style>
.navbar {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #5D9CEC;
	padding: 12px 24px;
	box-sizing: border-box;
	height: 60px;
}

.nav-left {
	display: flex;
	align-items: center;
	gap: 32px;
}

.nav-left .logo {
	font-weight: bold;
	font-size: 20px;
	color: #E5EAF2;
	font-family: 'Courier New', monospace;
}

.nav-left a {
	text-decoration: none;
	color: #E5EAF2;
	font-size: 15px;
}


.nav-right {
  display: flex;
  align-items: center;
  height: 100%;
}

.nav-right form {
  margin: 0; /* form의 기본 margin 제거 */
}

.nav-right .login-btn {
  background-color: #E5EAF2;
  color: #5D9CEC;
  font-weight: 500;
  padding: 8px 18px;
  border-radius: 30px;
  border: none;
  font-size: 14px;
  line-height: 1;           
  vertical-align: middle;  
  display: inline-block;   
  box-sizing: border-box;
  cursor: pointer;
}
</style>


<nav class="navbar">

	<div class="nav-left">
		<div class="logo">movit</div>
		<a href="<c:url value='/home.jsp' />">홈</a> <a
			href="<c:url value='/movie/movies.jsp' />">영화</a> <a
			href="<c:url value='/mylist/mylists.jsp' />">마이리스트</a> <a
			href="<c:url value='/wishlist/wishlists.jsp' />">찜 목록</a> <a
			href="<c:url value='/community.jsp' />">커뮤니티</a>
	</div>
	<div class="nav-right">
		<%
		if (userEmail == null) {
		%>
		<form action="<%=request.getContextPath()%>/signIn/login.jsp">
			<button class="login-btn">로그인</button>
		</form>
		<%
		} else {
		String displayName = (nickname != null && !nickname.trim().isEmpty()) ? nickname : userEmail;
		%>
		<span style="color: white; font-weight: bold; margin-right: 20px;"><%=displayName%>님</span>
		<form action="/myPage/info.jsp">
			<button class="login-btn">마이페이지</button>
		</form>
		<%
		}
		%>
	</div>
</nav>
