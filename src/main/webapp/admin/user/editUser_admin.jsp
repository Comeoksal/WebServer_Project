<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}">
	<fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">

<%@ include file="../../dbconn.jsp" %>
<sql:query dataSource="${ds}" var="user">
	select * from user where id = ?
	<sql:param value="${param.id}" />
</sql:query>
<c:set var="user" value="${user.rows[0]}" />

<sql:query dataSource="${ds}" var="memberships">
	select id, name from membership
</sql:query>

<html>
<head>
	<link rel="stylesheet" href="../../resources/css/bootstrap.min.css" />
	<title><fmt:message key="admin_users_edit" /></title>
</head>
<body>
	<%@ include file="../header_admin.jsp" %>
	<div class="container mt-5">
		<h3><fmt:message key="admin_users_edit" /></h3>
		<form action="processEditUser_admin.jsp" method="post">
			<input type="hidden" name="id" value="${user.id}" />
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_users_email" /></label>
				<input type="text" name="email" class="form-control" value="${user.email}" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_users_password" /></label>
				<input type="text" name="password" class="form-control" value="${user.password}" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_users_nickname" /></label>
				<input type="text" name="nickname" class="form-control" value="${user.nickname}" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_users_role" /></label>
				<select name="role" class="form-select" required>
					<option value="user" <c:if test="${user.role == 'user'}">selected</c:if>>User</option>
					<option value="admin" <c:if test="${user.role == 'admin'}">selected</c:if>>Admin</option>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_membershipId" /></label>
				<select name="membership_id" class="form-select" required>
					<c:forEach var="membership" items="${memberships.rows}">
						<option value="${membership.id}" <c:if test="${membership.id == user.membership_id}">selected</c:if>>
							${membership.name} (ID: ${membership.id})
						</option>
					</c:forEach>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_users_cardnumber" /></label>
				<input type="text" name="card_number" class="form-control" value="${user.card_number}" />
			</div>
			<button type="submit" class="btn btn-primary"><fmt:message key="admin_users_edit" /></button>
		</form>
	</div>
</fmt:bundle>
</body>
</html>