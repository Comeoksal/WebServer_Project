<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../../dbconn.jsp" %>
<sql:update dataSource="${ds}">
	update user set email = ?, password = ?, nickname = ?, role = ?, membership_id = ?, card_number = ?
	where id = ?
	<sql:param value="${param.email}" />
	<sql:param value="${param.password}" />
	<sql:param value="${param.nickname}" />
	<sql:param value="${param.role}" />
	<sql:param value="${param.membership_id}" />
	<sql:param value="${param.card_number}" />
	<sql:param value="${param.id}" />
</sql:update>

<script>
	alert("사용자 정보가 수정되었습니다.");
	location.href = "users_admin.jsp";
</script>