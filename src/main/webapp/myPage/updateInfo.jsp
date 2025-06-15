<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="../dbconn.jsp"%>

<c:if test="${empty sessionScope.user_email}">
	<c:redirect url="../signIn/login.jsp" />
</c:if>

<c:set var="userEmail" value="${sessionScope.user_email}" />
<c:set var="action" value="${param.action}" />
<c:set var="value" value="${param[action]}" />

<c:if test="${action eq 'phone'}">
	<sql:query var="phoneCheck" dataSource="${ds}">
		SELECT COUNT(*) AS cnt FROM user WHERE phone = ? AND email != ?
		<sql:param value="${value}" />
		<sql:param value="${userEmail}" />
	</sql:query>
	<c:if test="${phoneCheck.rows[0].cnt > 0}">
		<c:redirect url="info.jsp?error=phone_exists" />
	</c:if>
</c:if>

<c:if test="${action eq 'email'}">
	<sql:query var="emailCheck" dataSource="${ds}">
		SELECT COUNT(*) AS cnt FROM user WHERE email = ? AND email != ?
		<sql:param value="${value}" />
		<sql:param value="${userEmail}" />
	</sql:query>
	<c:if test="${emailCheck.rows[0].cnt > 0}">
		<c:redirect url="info.jsp?error=email_exists" />
	</c:if>
</c:if>

<c:choose>
	<c:when test="${action eq 'nickname'}">
		<sql:update dataSource="${ds}">
			UPDATE user SET nickname = ? WHERE email = ?
			<sql:param value="${value}" />
			<sql:param value="${userEmail}" />
		</sql:update>
		<c:set var="nickname" value="${value}" scope="session" />
	</c:when>

	<c:when test="${action eq 'phone'}">
		<sql:update dataSource="${ds}">
			UPDATE user SET phone = ? WHERE email = ?
			<sql:param value="${value}" />
			<sql:param value="${userEmail}" />
		</sql:update>
	</c:when>

	<c:when test="${action eq 'email'}">
		<sql:update dataSource="${ds}">
			UPDATE user SET email = ? WHERE email = ?
			<sql:param value="${value}" />
			<sql:param value="${userEmail}" />
		</sql:update>
		<c:set var="user_email" value="${value}" scope="session" />
	</c:when>
</c:choose>

<c:redirect url="info.jsp?updated=true" />
