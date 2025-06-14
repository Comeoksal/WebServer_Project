<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}">
	<fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">

<%@ include file="../../dbconn.jsp" %>
<sql:query dataSource="${ds}" var="membership">
	select * from membership where id = ?
	<sql:param value="${param.id}" />
</sql:query>
<c:set var="membership" value="${membership.rows[0]}" />

<html>
<head>
	<link rel="stylesheet" href="../../resources/css/bootstrap.min.css" />
	<title><fmt:message key="admin_membership_edit" /></title>
</head>
<body>
	<%@ include file="../header_admin.jsp" %>
	<div class="container mt-5">
		<h3><fmt:message key="admin_membership_edit" /></h3>
		<form action="processEditMembership_admin.jsp" method="post">
			<input type="hidden" name="id" value="${membership.id}" />
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_name" /></label>
				<input type="text" name="name" class="form-control" value="${membership.name}" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_content" /></label>
				<textarea name="content" class="form-control" rows="3" required>${membership.content}</textarea>
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_price" /></label>
				<input type="number" name="price" class="form-control" value="${membership.price}" required />
			</div>
			<button type="submit" class="btn btn-primary"><fmt:message key="admin_membership_edit" /></button>
		</form>
	</div>
</fmt:bundle>
</body>
</html>