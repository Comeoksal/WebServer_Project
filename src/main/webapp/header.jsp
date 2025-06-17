<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

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
    margin: 0;
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
<%
String role = (String) session.getAttribute("role");
%>
<c:set var="userId" value="${sessionScope.userId}" />

<%@ include file="dbconn.jsp" %>
<sql:query dataSource="${ds}" var="user">
	select u.*, m.name, m.id as membership_id
	from user u
	join membership m on u.membership_id = m.id
	where u.id = ?
	<sql:param value="${userId}" />
</sql:query>
<c:set var="user" value="${user.rows[0]}" />

<nav class="navbar">
	<div class="nav-left">
		<a href ="${pageContext.request.contextPath}/home.jsp" class="logo">movit</a>
		<a href="${pageContext.request.contextPath}/home.jsp">홈</a> 
		<a href="${pageContext.request.contextPath}/movie/movies/movies.jsp">영화</a> 
		<c:if test="${user.membership_id == 1}">
			<a href="${pageContext.request.contextPath}/movie/mylist/mylists.jsp">마이리스트</a>
		</c:if>
		<c:if test="${not empty userId}">
			<a href="${pageContext.request.contextPath}/movie/wishlist/wishlists.jsp">찜 목록</a>
		</c:if>
		<a href="${pageContext.request.contextPath}/Review.do">커뮤니티</a>
	</div>
	<div class="nav-right">
		<c:choose>
			<c:when test="${empty userId}">
				<form action="${pageContext.request.contextPath}/signIn/login.jsp">
					<button class="login-btn">로그인</button>
				</form>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${user.role eq 'user'}">
						<form action="${pageContext.request.contextPath}/myPage/membership.jsp" style="font-weight: bold; margin-right: 15px;">
							<button class="login-btn">현재 멤버십: ${user.name}</button>
						</form>
					</c:when>
					<c:when test="${user.role eq 'admin'}">
						<form action="${pageContext.request.contextPath}/admin/home_admin.jsp" style="margin-right: 15px;">
							<button class="login-btn">관리자 페이지</button>
						</form>
					</c:when>
				</c:choose>
				<span style="color: white; font-size: large; font-weight: bold; margin-right: 20px;">
					${not empty user.nickname ? user.nickname : user.email}님
				</span>
				<form action="${pageContext.request.contextPath}/myPage/info.jsp">
					<button class="login-btn">마이페이지</button>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
</nav>