<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.setCharacterEncoding("utf-8");
    String movieId = request.getParameter("id");
%>

<c:if test="${not empty param.lang}">
    <fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">
<%@ include file="../../dbconn.jsp" %>
<sql:query dataSource="${ds}" var="movieData">
    SELECT * FROM movie WHERE id = ?
    <sql:param value="<%= movieId %>" />
</sql:query>

<c:set var="movie" value="${movieData.rows[0]}" />

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title><fmt:message key="admin_movies_edit" /></title>
</head>
<body>
    <%@ include file="../header_admin.jsp" %>

    <div class="container mt-5">
        <h3><fmt:message key="admin_movies_edit" /></h3>
        <form action="processEditMovie_admin.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${movie.id}" />

            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_movies_title" /></label>
                <input type="text" name="title" class="form-control" value="${movie.title}" required />
            </div>
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_movies_content" /></label>
                <textarea name="content" class="form-control" rows="3" required>${movie.content}</textarea>
            </div>
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_movies_price" /></label>
                <input type="number" name="price" class="form-control" value="${movie.price}" required />
            </div>
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_movies_release_date" /></label>
                <input type="date" name="release_date" class="form-control" value="${movie.release_date}" required />
            </div>
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_movies_link" /></label>
                <input type="text" name="link" class="form-control" value="${movie.link}" required />
            </div>

            <div class="mb-3">
        		<label class="form-label"><fmt:message key="admin_movies_image" /></label><br>
        		<img src="${pageContext.request.contextPath}/resources/images/${movie.image}" width="150" />
        		<input type="hidden" name="oldImage" value="${movie.image}" />
				<input type="file" name="image" class="form-control mt-2" accept="image/*" />
        		<small class="text-muted">※ 새 이미지를 선택하지 않으면 기존 이미지가 유지됩니다.</small>
    		</div>
            <button type="submit" class="btn btn-primary"><fmt:message key="admin_movies_edit" /></button>
        </form>
    </div>
</fmt:bundle>
</body>
</html>
