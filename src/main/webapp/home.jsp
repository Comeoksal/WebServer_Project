<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>홈</title>
<style>

body {
    margin: 0;
    background-color: #0F111A; 
    color: #e0e0e0; 
    font-family: 'Arial', sans-serif;
}

a {
    color: inherit;
    text-decoration: none;
}

.container {
    display: flex;
    padding: 30px;
    margin-top: 30px;
    gap: 40px;
}

.left-feature {
    width: 600px;
    flex-shrink: 0;
}

.left-feature img {
    width: 100%;
    border-radius: 12px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.6);
}

.clearfix {
    display: flex;
    flex-wrap: wrap;
    gap: 30px 20px;
    justify-content: flex-start;
}

.movie-box {
	margin: 1px;
    width: 300px;
    flex-shrink: 0;
}

    .right-list {
        flex: 1;
    }

.movie-card {
    background-color: #1c1c1c;
    border: 1px solid #333;
}

.movie-desc {
    background-color: rgba(0, 0, 0, 0.7);
    color: #f0f0f0;
}

    .movie-card {
        position: relative;
        width: 100%;
        padding-bottom: 150%;
        overflow: hidden;
        border-radius: 10px;
        background-color: #111;
        border: 1px solid #444;
    }

    .movie-card img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: filter 0.3s ease;
    }

    .movie-card:hover img {
        filter: blur(2px) brightness(0.4);
    }

    .movie-desc {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 85%;
        max-height: 60%;
        background-color: rgba(0, 0, 0, 0.6);
        color: #fff;
        font-size: 14px;
        font-weight: 500;
        padding: 10px;
        border-radius: 8px;
        overflow: hidden;
        text-align: center;
        line-height: 1.4;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 2;
    }

    .movie-card:hover .movie-desc {
        opacity: 1;
    }
</style>

<body>
<%@ include file="header.jsp"%>
<%@ include file="dbconn.jsp" %>
<sql:query dataSource="${ds}" var="result">
            SELECT * FROM movie
            ORDER BY score DESC
</sql:query>
</head>
<div class="container">
    <div class="left-feature">
    	<h1>공개 예정</h1>
        <img src="<c:url value='/resources/images/starwars_g.gif' />" alt="추천 영화 포스터">
    </div>
    <div class="right-list">
		<h1>모두의 인기작</h1>
        <div class="clearfix">
            <c:forEach var="row" items="${result.rows}">
                <div class="movie-box">
                    <div class="movie-card">
                        <a href="${pageContext.request.contextPath}/movie/movie.jsp?id=${row.id}">
                            <img src="<c:url value='/resources/images/${row.image}' />" alt="영화 포스터">
                            <div class="movie-desc">
                                <c:choose>
                                    <c:when test="${fn:length(row.content) > 50}">
                                        ${fn:substring(row.content, 0, 50)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${row.content}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>