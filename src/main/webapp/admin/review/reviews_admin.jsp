<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
    <title>관리자 페이지[리뷰]</title>
</head>
<body>
	<c:if test="${not empty param.lang}">
    	<fmt:setLocale value="${param.lang}" scope="session" />
	</c:if>
	<fmt:bundle basename="bundle.admin" >
    <%@ include file="../header_admin.jsp" %>
   	<%@ include file="../../dbconn.jsp" %>
    <sql:query dataSource="${ds}" var="result">
        SELECT r.id, u.email, u.nickname, m.title, r.content, r.score, COUNT(l.id) AS like_count
		FROM review r
		JOIN movie m ON r.movie_id = m.id
		JOIN user u ON r.user_id = u.id
		LEFT JOIN like_review l ON r.id = l.review_id
		GROUP BY r.id, r.content, r.score, m.title, m.id
    </sql:query>

<div class="container mt-5">
    
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0"><fmt:message key="admin_reviews_main" /></h2>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered text-center mx-auto" style="max-width: 1200px;">
            <thead class="table-light">
                <tr>
                	<th><fmt:message key="admin_reviews_reviewId" /></th>
                    <th><fmt:message key="admin_reviews_user" /></th>
                    <th><fmt:message key="admin_movies_title" /></th>
                    <th><fmt:message key="admin_reviews_content" /></th>
                    <th><fmt:message key="admin_reviews_score" /></th>
                    <th><fmt:message key="admin_reviews_likes" /></th>
                    <th><fmt:message key="admin_delete" /></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${result.rows}">
                    <tr>
                        <td>${row.id}</td>
                        <td>
						  <c:choose>
						    <c:when test="${not empty row.nickname}">
						      ${row.nickname}
						    </c:when>
						    <c:otherwise>
						      ${row.email}
						    </c:otherwise>
						  </c:choose>
						</td>
                        <td>${row.title}</td>
                        <td>${row.content}</td>
                        <td>${row.score}</td>
                        <td>${row.like_count}</td>
                        <td>
                            <a href="processDeleteReview_admin.jsp?id=${row.id}" class="btn btn-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">
                                <fmt:message key="admin_delete" />
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</fmt:bundle>
</body>
</html>
