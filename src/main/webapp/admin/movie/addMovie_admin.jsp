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
	<title><fmt:message key="admin_movies_add" /></title>
</head>
<body>
	<%@ include file="../header_admin.jsp" %>
	<div class="container mt-5">
		<h3><fmt:message key="admin_movies_add" /></h3>
		<form action="processAddMovie_admin.jsp" method="post" enctype="multipart/form-data">
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_movies_title" /></label>
				<input type="text" name="title" class="form-control" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_movies_content" /></label>
				<textarea name="content" class="form-control" rows="3" required></textarea>
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_movies_price" /></label>
				<input type="number" name="price" class="form-control" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_movies_release_date" /></label>
				<input type="date" name="release_date" class="form-control" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_movies_image" /></label>
				<input type="file" name="image" class="form-control" accept="image/*" required />
			</div>
			<div class="mb-3">
				<label class="form-label"><fmt:message key="admin_movies_link" /></label>
				<input type="text" name="link" class="form-control" required />
			</div>
			<button type="submit" class="btn btn-primary"><fmt:message key="admin_movies_add" /></button>
		</form>
	</div>
</fmt:bundle>
</body>
</html>