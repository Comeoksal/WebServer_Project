<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="../dbconn.jsp"%>

<c:if test="${empty sessionScope.userId}">
    <c:redirect url="../signIn/login.jsp" />
</c:if>

<c:set var="userId" value="${sessionScope.userId}" />
<c:set var="action" value="${param.action}" />
<c:set var="value" value="${param[action]}" />

<c:choose>
    <c:when test="${action eq 'phone'}">
        <sql:query var="phoneCheck" dataSource="${ds}">
            SELECT COUNT(*) AS cnt FROM user WHERE phone = ? AND id != ?
            <sql:param value="${value}" />
            <sql:param value="${userId}" />
        </sql:query>
        <p style="color: gray;">[DEBUG] phone 중복 수: ${phoneCheck.rows[0].cnt}</p>
        <c:if test="${phoneCheck.rows[0].cnt > 0}">
            <c:redirect url="info.jsp?error=phone_exists" />
        </c:if>
    </c:when>

    <c:when test="${action eq 'email'}">
        <sql:query var="emailCheck" dataSource="${ds}">
            SELECT COUNT(*) AS cnt FROM user WHERE email = ? AND id != ?
            <sql:param value="${value}" />
            <sql:param value="${userId}" />
        </sql:query>
        <p style="color: gray;">[DEBUG] email 중복 수: ${emailCheck.rows[0].cnt}</p>
        <c:if test="${emailCheck.rows[0].cnt > 0}">
            <c:redirect url="info.jsp?error=email_exists" />
        </c:if>
    </c:when>
</c:choose>

<sql:update dataSource="${ds}">
    <c:choose>
        <c:when test="${action eq 'nickname'}">
            UPDATE user SET nickname = ? WHERE id = ?
        </c:when>
        <c:when test="${action eq 'phone'}">
            UPDATE user SET phone = ? WHERE id = ?
        </c:when>
        <c:when test="${action eq 'email'}">
            UPDATE user SET email = ? WHERE id = ?
        </c:when>
    </c:choose>
    <sql:param value="${value}" />
    <sql:param value="${userId}" />
</sql:update>

<c:if test="${action eq 'nickname'}">
    <c:set var="nickname" value="${value}" scope="session" />
</c:if>
<c:if test="${action eq 'email'}">
    <c:set var="user_email" value="${value}" scope="session" />
</c:if>

<c:redirect url="info.jsp?updated=true" />
