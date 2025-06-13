<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}">
	<fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin" />

<%@ include file="../../dbconn.jsp" %>
<sql:update dataSource="${ds}">
	insert into user (email, password, nickname, role, membership_id, card_number)
	values (?, ?, ?, ?, ?, ?)
	<sql:param value="${param.email}" />
	<sql:param value="${param.password}" />
	<sql:param value="${param.nickname}" />
	<sql:param value="${param.role}" />
	<sql:param value="${param.membership_id}" />
	<sql:param value="${param.card_number}" />
</sql:update>

<script>
	alert("사용자 추가를 성공했습니다.");
	location.href = "users_admin.jsp";
</script>