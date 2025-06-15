<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<c:if test="${empty param.phone or empty param.email}">
	<c:redirect url="findPassword.jsp?error=empty"/>
</c:if>

<%@ include file="../dbconn.jsp" %>

<sql:query dataSource="${ds}" var="result">
	select count(*) as cnt from user where phone = ? and email = ?
	<sql:param value = "${param.phone}" />
	<sql:param value = "${param.email}" />
</sql:query>

<c:choose>
    <c:when test="${result.rows[0].cnt == 0}">
        <c:redirect url="findPassword.jsp?error=noexist" />
    </c:when>
    <c:otherwise>
		<c:redirect url="findPassword.jsp?findpassword=true&phone=${param.phone}&email=${param.email}" />
    </c:otherwise>
</c:choose>