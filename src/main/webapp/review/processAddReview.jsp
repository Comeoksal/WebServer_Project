<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8");

    String movieId = request.getParameter("movie_id");
    String userId = request.getParameter("user_id");
    String score = request.getParameter("score");
    String content = request.getParameter("content");

    // JSTL에서 사용할 수 있게 request에 저장
    request.setAttribute("movieId", movieId);
    request.setAttribute("userId", userId);
    request.setAttribute("score", score);
    request.setAttribute("content", content);
%>

<sql:update dataSource="${ds}">
    INSERT INTO review (content, score, user_id, movie_id)
    VALUES (?, ?, ?, ?)
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
