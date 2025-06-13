<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
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
    margin-top: 20px;
}

.clearfix {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;            
    padding: 0 15px;       
    justify-content: flex-start;
}

.movie-box {
	margin: 15px;
    width: 200px;          
    flex-shrink: 0;        
}

.movie-card {
	margin-left: 50px;
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
    filter: blur(2px) brightness(0.6);
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
.movie-card:hover img {
    filter: blur(2px) brightness(0.4);
}

</style>
	<title>영화 목록</title>
</head>

<body>
<%@ include file="../../header.jsp"%>
<div style="margin-top: 60px;"></div>
<%@ include file="../../search_header.jsp" %>

<%
    String query = request.getParameter("query");
    String sort = request.getParameter("sort");
%>

<div class="container">
    <%@ include file="../../dbconn.jsp" %>

    <sql:query dataSource="${ds}" var="result">
  		SELECT * FROM movie
  		WHERE title LIKE '%${param.query}%' 
  		<c:choose>
    		<c:when test="${param.sort == 'popular'}">
      			ORDER BY score DESC
    		</c:when>
    		<c:when test="${param.sort == 'oldest'}">
      			ORDER BY release_date ASC
    		</c:when>
    		<c:otherwise>
      			ORDER BY release_date DESC
    		</c:otherwise>
  		</c:choose>
	</sql:query>
    <div class="clearfix">
        <c:forEach var="row" items="${result.rows}">
    <div class="movie-box">
        <div class="movie-card">
            <a href="../movie.jsp?id=${row.id}">
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
</body>
</html>
