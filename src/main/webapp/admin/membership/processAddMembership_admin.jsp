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
	insert into membership (name, content, price)
	values (?, ?, ?)
	<sql:param value="${param.name}" />
	<sql:param value="${param.content}" />
	<sql:param value="${param.price}" />
</sql:update>

<script>
	alert("멤버십 추가를 성공했습니다.");
	location.href = "memberships_admin.jsp";
</script>