<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}">
	<fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">

<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<header class="d-flex justify-content-between align-items-center px-4 py-3 bg-dark text-white">
	<div class="d-flex gap-2 align-items-center">
		<div class="fs-4 fw-bold">
			<a href="${pageContext.request.contextPath}/admin/home_admin.jsp" style="text-decoration: none; color: #FFFFFF;">
				<fmt:message key="admin_header_title" />
			</a>
		</div>
		<a href="<c:url value='/admin/movie/movies_admin.jsp' />" class="btn btn-outline-light">
			<fmt:message key="admin_header_movie" />
		</a>
		<a href="<c:url value='/admin/user/users_admin.jsp' />" class="btn btn-outline-light">
			<fmt:message key="admin_header_user" />
		</a>
		<a href="<c:url value='/admin/review/reviews_admin.jsp' />" class="btn btn-outline-light">
			<fmt:message key="admin_header_review" />
		</a>
		<a href="<c:url value='/admin/membership/memberships_admin.jsp' />" class="btn btn-outline-light">
			<fmt:message key="admin_header_membership" />
		</a>
	</div>
	<div class="d-flex ms-auto gap-2">
		<a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-outline-light">
			<fmt:message key="admin_header_userpage" />
		</a>
		<a href="?lang=ko" class="btn btn-light btn-sm me-1">
			<fmt:message key="admin_header_korean" />
		</a>
		<a href="?lang=en" class="btn btn-light btn-sm">
			<fmt:message key="admin_header_english" />
		</a>
	</div>
</header>
</fmt:bundle>