<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
body {
  margin: 0;
  background: #1c1c1c;
  color: #fff;
  font-family: Arial, sans-serif;
}

.wrapper {
  padding-top: 60px;
}

.movie-detail-container {
  max-width: 1200px;
  margin: 40px auto;
  display: flex;
  gap: 40px;
  padding: 0 20px;
}

.movie-poster {
  flex: 1;
  min-width: 600px;
}

.movie-poster img {
  width: 100%;
  border-radius: 10px;
}

.movie-info {
  flex: 2;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  font-size: 18px;
}

.movie-info h2 {
  font-size: 36px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 12px;
}

.release-date {
  font-size: 18px;
  color: #aaa;
}

.movie-description {
  flex-grow: 1;
  color: #ddd;
  line-height: 1.6;
  margin-bottom: 20px;
}

.movie-bottom {
  margin-top: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.meta-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 24px;
}

.btn {
  background: #5D9CEC;
  color: #fff;
  padding: 10px 18px;
  border: none;
  border-radius: 20px;
  font-size: 16px;
  cursor: pointer;
  text-decoration: none;
}

.btn:hover {
  background: #4A8AE2;
}

.btn-large {
  font-size: 22px;
  padding: 12px 28px;
  align-self: flex-start;
}
</style>

<%@ include file="../header.jsp" %>
<%
    String movieId = request.getParameter("id");
%>

<%@ include file="../dbconn.jsp" %>

<sql:query dataSource="${ds}" var="detail">
    SELECT * FROM movie WHERE id = ${param.id}
</sql:query>

<sql:query dataSource="${ds}" var="wishCount">
    SELECT COUNT(*) AS count FROM wishlist WHERE movie_id = ${param.id}
</sql:query>

<c:if test="${empty sessionScope.userId}">
    <script>
        alert("로그인 후 이용 가능합니다.");
        location.href = "${pageContext.request.contextPath}/signIn/login.jsp";
    </script>
</c:if>

<c:if test="${param.action == 'wish' && not empty sessionScope.userId}">
    <sql:update dataSource="${ds}">
        INSERT INTO wishlist (user_id, movie_id)
        VALUES (?, ?)
        <sql:param value="${sessionScope.userId}" />
        <sql:param value="${param.id}" />
    </sql:update>

    <script>
        alert("찜 목록에 추가되었습니다.");
        location.replace("${pageContext.request.contextPath}/movie/movie.jsp?id=${param.id}");
    </script>
</c:if>


<div class="wrapper">
  <div class="movie-detail-container">
    <div class="movie-poster">
      <img src="<c:url value='/resources/images/${detail.rows[0].image}' />" alt="영화 포스터">
    </div>

    <div class="movie-info">
      <h2>
        ${detail.rows[0].title}
        <span class="release-date">${detail.rows[0].release_date}</span>
      </h2>

      <div class="movie-description">
        <p>${detail.rows[0].content}</p>
      </div>

      <div class="movie-bottom">
        <div class="meta-row">
          <span>찜한 수: ${wishCount.rows[0].count} 개</span>
          <form method="post">
  			<input type="hidden" name="action" value="wish" />
  			<button type="submit" class="btn">영화 찜하기</button>
		</form>
        </div>

        <div class="meta-row">
          <span>평점: ${detail.rows[0].score} / 5.0</span>
          <button class="btn">리뷰 남기기</button>
        </div>

        <a href="${detail.rows[0].link}" class="btn btn-large" target="_blank">영화 보기</a>
      </div>
    </div>
  </div>
</div>
