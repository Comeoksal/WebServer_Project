<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<c:if test="${empty param.phone}">
	<c:redirect url="findEmail.jsp?error=empty"/>
</c:if>

<%@ include file="../dbconn.jsp" %>

<sql:query dataSource="${ds}" var="result">
            select count(*) as cnt from user where phone = ?
            <sql:param value = "${param.phone}" />
</sql:query>

<c:choose>
    <c:when test="${result.rows[0].cnt == 0}">
        <c:redirect url="findEmail.jsp?error=noexist" />
    </c:when>
    <c:otherwise>
        <c:redirect url="findEmail.jsp?findemail=true&phone=${param.phone}" />
    </c:otherwise>
</c:choose>