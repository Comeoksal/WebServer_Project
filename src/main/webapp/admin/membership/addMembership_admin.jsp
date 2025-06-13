<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}">
	<fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">

<html>
<head>
	<link rel="stylesheet" href="../../resources/css/bootstrap.min.css" />
	<title><fmt:message key="admin_membership_add" /></title>
</head>
<body>
	<%@ include file="../header_admin.jsp" %>
	<div class="container mt-5">
		<h3><fmt:message key="admin_membership_add" /></h3>
		<form action="processAddMembership_admin.jsp" method="post">
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_name" /></label>
				<input type="text" name="name" class="form-control" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_content" /></label>
				<textarea name="content" class="form-control" rows="3" required></textarea>
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_membership_price" /></label>
				<input type="number" name="price" class="form-control" required />
			</div>
			<button type="submit" class="btn btn-primary"><fmt:message key="admin_membership_add" /></button>
		</form>
	</div>
</fmt:bundle>
</body>
</html>