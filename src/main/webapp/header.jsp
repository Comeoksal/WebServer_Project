<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<%
String userId = String.valueOf(session.getAttribute("userId"));
String role = (String) session.getAttribute("role");
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

<%@ include file="dbconn.jsp" %>

<c:set var="userId" value="${sessionScope.userId}" />
<sql:query dataSource="${ds}" var="result">
    SELECT u.*, m.name
    FROM user u
    JOIN membership m ON u.membership_id = m.id
    WHERE u.id = ?
    <sql:param value="${userId}" />
</sql:query>

<nav class="navbar">
    <div class="nav-left">
        <a href ="<c:url value='/home.jsp'/>" class="logo">movit</a>
        <a href="<c:url value='/home.jsp' />">홈</a> 
        <a href="<c:url value='/movie/movies/movies.jsp' />">영화</a> 
        <a href="<c:url value='/movie/mylist/mylists.jsp' />">마이리스트</a> 
        <a href="<c:url value='/movie/wishlist/wishlists.jsp' />">찜 목록</a> 
        <a href="<c:url value='/review/community.jsp' />">커뮤니티</a>
    </div>
    <div class="nav-right">
        <c:choose>
            <c:when test="${empty sessionScope.userId}">
                <form action="${pageContext.request.contextPath}/signIn/login.jsp">
                    <button class="login-btn">로그인</button>
                </form>
            </c:when>
            <c:otherwise>
                <c:forEach var="row" items="${result.rows}">
                    <c:choose>
                        <c:when test="${row.role eq 'user'}">
                            <form action="${pageContext.request.contextPath}/myPage/membership.jsp" style="font-weight: bold; margin-right: 15px;">
                                <button class="login-btn">현재 멤버십: ${row.name}</button>
                            </form>
                        </c:when>
                        <c:when test="${row.role eq 'admin'}">
                            <form action="${pageContext.request.contextPath}/admin/header_admin.jsp" style="margin-right: 15px;">
                                <button class="login-btn">관리자 페이지</button>
                            </form>
                        </c:when>
                    </c:choose>

                    <span style="color: white; font-size: large; font-weight: bold; margin-right: 20px;">
                        ${not empty row.nickname ? row.nickname : row.email}님
                    </span>
                    <form action="${pageContext.request.contextPath}/myPage/info.jsp">
                        <button class="login-btn">마이페이지</button>
                    </form>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</nav>