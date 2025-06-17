<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty param.lang}">
	<fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">

<%@ include file="../../dbconn.jsp" %>
<sql:query dataSource="${ds}" var="movies">
	select * from movie
</sql:query>

<html>
<head>
	<link rel="stylesheet" href="../../resources/css/bootstrap.min.css" />
	<title>관리자 페이지[영화]</title>
</head>
<body>
	<%@ include file="../header_admin.jsp" %>
	<div class="container mt-5">
		<div class="d-flex justify-content-between align-items-center mb-2">
			<h2 class="mb-0"><fmt:message key="admin_movies_main" /></h2>
			<a href="addMovie_admin.jsp" class="btn btn-success btn-sm"><fmt:message key="admin_movies_add" /></a>
		</div>

		<table class="table table-bordered text-center">
			<thead class="table-light">
				<tr>
					<th><fmt:message key="admin_movies_movieId" /></th>
					<th><fmt:message key="admin_movies_title" /></th>
					<th><fmt:message key="admin_movies_content" /></th>
					<th><fmt:message key="admin_movies_price" /></th>
					<th><fmt:message key="admin_movies_score" /></th>
					<th><fmt:message key="admin_movies_release_date" /></th>
					<th><fmt:message key="admin_update" /></th>
					<th><fmt:message key="admin_delete" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="movie" items="${movies.rows}">
					<tr>
						<td>${movie.id}</td>
						<td>${movie.title}</td>
						<td>${movie.content}</td>
						<td>${movie.price}</td>
						<td>${movie.score}</td>
						<td>${movie.release_date}</td>
						<td>
							<a href="editMovie_admin.jsp?id=${movie.id}" class="btn btn-primary btn-sm">
								<fmt:message key="admin_update" />
							</a>
						</td>
						<td>
							<a href="processDeleteMovie_admin.jsp?id=${movie.id}" class="btn btn-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">
								<fmt:message key="admin_delete" />
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</fmt:bundle>
</body>
</html>