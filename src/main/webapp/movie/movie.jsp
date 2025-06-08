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
<%@ include file="../header.jsp"%>
<%
    String movieId = request.getParameter("id");
%>

<%@ include file="../dbconn.jsp"%>

<sql:query dataSource="${ds}" var="detail">
    SELECT * FROM movie WHERE id = ${param.id}
</sql:query>

<sql:query dataSource="${ds}" var="wishCount">
    SELECT COUNT(*) AS count FROM wishlist WHERE movie_id = ${param.id}
</sql:query>

<sql:query dataSource="${ds}" var="user">
    SELECT membership_id FROM user WHERE id = ?
    <sql:param value="${sessionScope.userId}" />
</sql:query>

<sql:query dataSource="${ds}" var="hasPurchased">
    SELECT COUNT(*) AS cnt FROM purchase WHERE user_id = ? AND movie_id = ?
    <sql:param value="${sessionScope.userId}" />
    <sql:param value="${param.id}" />
</sql:query>

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
			<img
				src="<c:url value='/resources/images/${detail.rows[0].image}' />"
				alt="영화 포스터">
		</div>

		<div class="movie-info">
			<h2>
				${detail.rows[0].title} <span class="release-date">${detail.rows[0].release_date}</span>
			</h2>

			<div class="movie-description">
				<p>${detail.rows[0].content}</p>
			</div>

			<div class="movie-bottom">
				<div class="meta-row">
					<span>찜한 수: ${wishCount.rows[0].count} 개</span>
					<c:choose>
						<c:when test="${empty sessionScope.userId}">
							<button class="btn" onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/signIn/login.jsp';">영화 찜하기</button>
						</c:when>
						<c:otherwise>
							<form method="post">
								<input type="hidden" name="action" value="wish" />
								<button type="submit" class="btn">영화 찜하기</button>
							</form>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="meta-row">
					<span>평점: ${detail.rows[0].score} / 5.0</span>
					<c:choose>
						<c:when test="${empty sessionScope.userId}">
							<button class="btn" onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/signIn/login.jsp';">리뷰 남기기</button>
						</c:when>
						<c:otherwise>
							<form action="${pageContext.request.contextPath}/review/review.jsp" method="get" style="display:inline;">
    							<input type="hidden" name="id" value="${detail.rows[0].id}" />
    							<button type="submit" class="btn">리뷰 남기기</button>
  							</form>
						</c:otherwise>
					</c:choose>
				</div>
				<c:choose>
					<c:when test="${empty sessionScope.userId}">
						<button class="btn btn-large" onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/signIn/login.jsp';">영화 보기</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${hasPurchased.rows[0].cnt > 0}">
								<a href="${detail.rows[0].link}" class="btn btn-large" target="_blank">영화 보기</a>
							</c:when>
							<c:when test="${user.rows[0].membership_id == 1}">
								<form action="moviePurchase.jsp" method="post">
									<input type="hidden" name="movie_id" value="${param.id}" />
									<button type="submit" class="btn btn-large">영화 보기</button>
								</form>
							</c:when>

							<c:when test="${user.rows[0].membership_id == 2 || user.rows[0].membership_id == 3}">
								<a href="${detail.rows[0].link}" class="btn btn-large" target="_blank">영화 보기</a>
							</c:when>

							<c:otherwise>
								<span class="btn btn-large disabled">회원 정보 오류</span>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
