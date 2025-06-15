<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../dbconn.jsp" %>

<%
  request.setCharacterEncoding("UTF-8");
%>

<c:set var="email" value="${param.email}" />
<c:set var="password" value="${param.password}" />
<c:set var="confirm" value="${param.confirm}" />
<c:set var="phone" value="${param.phone}" />

<c:if test="${empty email or empty password or empty confirm or empty phone}">
	<c:redirect url="register.jsp?error=empty" />
</c:if>

<c:if test="${password ne confirm}">
	<c:redirect url="register.jsp?error=mismatch" />
</c:if>

<sql:query dataSource="${ds}" var="emailCheck">
	SELECT COUNT(*) AS cnt FROM user WHERE email = ?
	<sql:param value="${email}" />
</sql:query>

<sql:query dataSource="${ds}" var="phoneCheck">
	SELECT COUNT(*) AS cnt FROM user WHERE phone = ?
	<sql:param value="${phone}" />
</sql:query>

<c:choose>
	<c:when test="${emailCheck.rows[0].cnt > 0}">
		<c:redirect url="register.jsp?error=email_exists" />
	</c:when>

	<c:when test="${phoneCheck.rows[0].cnt > 0}">
		<c:redirect url="register.jsp?error=phone_exists" />
	</c:when>

	<c:otherwise>
		<sql:update dataSource="${ds}">
			INSERT INTO user (email, password, nickname, role, created_at, membership_id, phone)
			VALUES (?, ?, '', 'user', NOW(), 1, ?)
			<sql:param value="${email}" />
			<sql:param value="${password}" />
			<sql:param value="${phone}" />
		</sql:update>
		<c:redirect url="login.jsp?registered=true" />
	</c:otherwise>
</c:choose>
