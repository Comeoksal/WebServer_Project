<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="movieId" value="${param.movie_id}" />
<c:set var="userId" value="${param.user_id}" />
<c:set var="score" value="${param.score}" />
<c:set var="content" value="${param.content}" />

<%@ include file="../dbconn.jsp" %>
<sql:update dataSource="${ds}">
    insert into review (content, score, user_id, movie_id)
    values (?, ?, ?, ?)
    <sql:param value="${content}" />
    <sql:param value="${score}" />
    <sql:param value="${userId}" />
    <sql:param value="${movieId}" />
</sql:update>

<sql:update dataSource="${ds}">
	update movie set score = (select avg(score) from review where movie_id = ?)
	where id = ?
	<sql:param value="${movieId}" />
	<sql:param value="${movieId}" />
</sql:update>

<script>
    alert("리뷰가 성공적으로 등록되었습니다.");
    location.href = "../movie/movie.jsp?id=${movieId}";
</script>
