<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
body {
	margin: 0;
	background: #0F111A;
	color: #fff;
	font-family: Arial, sans-serif;
}

.wrapper {
	padding-top: 95px;
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
	min-width: 500px;
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

.movie-info h1 {
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

<c:set var="userId" value="${sessionScope.userId}" />
<c:set var="movieId" value="${param.id}" />

<%@ include file="../dbconn.jsp"%>
<sql:query dataSource="${ds}" var="movie">
    select * from movie where id = ?
    <sql:param value="${movieId}" />
</sql:query>
<c:set var="movie" value="${movie.rows[0]}" />

<c:if test="${empty movie}">
    <c:redirect url="exceptionNoMovieId.jsp" />
</c:if>

<sql:query dataSource="${ds}" var="user">
    select * from user where id = ?
    <sql:param value="${userId}" />
</sql:query>
<c:set var="user" value="${user.rows[0]}" />

<sql:query dataSource="${ds}" var="wishCount">
    select COUNT(*) as count from wishlist where movie_id = ?
    <sql:param value="${movieId}" />
</sql:query>
<c:set var="wishCount" value="${wishCount.rows[0]}" />

<sql:query dataSource="${ds}" var="hasPurchased">
    select COUNT(*) as count from purchase where user_id = ? and movie_id = ?
    <sql:param value="${userId}" />
	<sql:param value="${movieId}" />
</sql:query>
<c:set var="hasPurchased" value="${hasPurchased.rows[0]}" />

<sql:query dataSource="${ds}" var="hasReviewed">
    select COUNT(*) AS count from review 
    where user_id = ? and movie_id = ?
    <sql:param value="${userId}" />
	<sql:param value="${movieId}" />
</sql:query>
<c:set var="hasReviewed" value="${hasReviewed.rows[0]}" />

<sql:query dataSource="${ds}" var="isWished">
  select COUNT(*) as count from wishlist
  where user_id = ? and movie_id = ?
  <sql:param value="${userId}" />
  <sql:param value="${movieId}" />
</sql:query>
<c:set var="isWished" value="${isWished.rows[0]}" />

<c:if test="${param.action == 'wish' && not empty userId}">
	<c:choose>
		<c:when test="${isWished.count > 0}">
			<sql:update dataSource="${ds}">
				delete from wishlist where user_id = ? and movie_id = ?
				<sql:param value="${userId}" />
				<sql:param value="${movieId}" />
			</sql:update>
			<script>
				alert("찜이 취소되었습니다.");
				location.replace("${pageContext.request.contextPath}/movie/movie.jsp?id=${movieId}");
			</script>
		</c:when>
		<c:otherwise>
			<sql:update dataSource="${ds}">
				insert into wishlist (user_id, movie_id) values (?, ?)
				<sql:param value="${userId}" />
				<sql:param value="${movieId}" />
			</sql:update>
			<script>
				alert("찜 목록에 추가되었습니다.");
				location.replace("${pageContext.request.contextPath}/movie/movie.jsp?id=${movieId}");
			</script>
		</c:otherwise>
	</c:choose>
</c:if>

<%@ include file="../header.jsp"%>
<div class="wrapper">
	<div class="movie-detail-container">
		<div class="movie-poster">
			<img src="<c:url value='/resources/images/${movie.image}' />">
		</div>
		<div class="movie-info">
			<h1>
				${movie.title} <span class="release-date">${movie.release_date}</span>
			</h1>
			<div class="movie-description">
				<p>${movie.content}</p>
			</div>
			<div class="movie-bottom">
				<div class="meta-row">
					<span>찜한 수: ${wishCount.count} 개</span>
					<c:choose>
						<c:when test="${empty userId}">
							<button class="btn" onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/signIn/login.jsp';"> 
							영화 찜하기</button>
						</c:when>
						<c:otherwise>
							<form method="post">
								<input type="hidden" name="action" value="wish" />
								<button type="submit" class="btn">
									<c:choose>
										<c:when test="${isWished.count > 0}">찜 취소하기</c:when>
										<c:otherwise>영화 찜하기</c:otherwise>
									</c:choose>
								</button>
							</form>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="meta-row">
					<span>평점: 
						<c:choose>
							<c:when test="${empty movie.score}"> 등록된 평점 없음</c:when>
							<c:otherwise> ${movie.score} / 5.0 </c:otherwise>
						</c:choose>
					</span>
					<c:choose>
						<c:when test="${empty userId}">
							<button class="btn" onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/signIn/login.jsp';">리뷰 남기기</button>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${hasReviewed.count > 0}">
									<button class="btn" onclick="alert('리뷰는 한 번만 작성할 수 있습니다.');">리뷰남기기</button>
								</c:when>
								<c:when test="${hasPurchased.count > 0 or user.membership_id == 2 or user.membership_id == 3}">
									<form
										action="${pageContext.request.contextPath}/ReviewWriteForm.do"
										method="get" style="display: inline;">
										<input type="hidden" name="id" value="${movieId}" />
										<button type="submit" class="btn">리뷰 남기기</button>
									</form>
								</c:when>
								<c:otherwise>
									<button class="btn"onclick="alert('리뷰는 구매자 혹은 멤버십 사용자만 작성 가능합니다.');">리뷰 남기기</button>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
				<c:choose>
					<c:when test="${empty userId}">
						<button class="btn btn-large" onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/signIn/login.jsp';">영화 보기</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${hasPurchased.count > 0}">
								<a href="${movie.link}" class="btn btn-large" target="_blank">영화 보기</a>
							</c:when>
							<c:when test="${user.membership_id == 1}">
								<form action="moviePurchase.jsp" method="post">
									<input type="hidden" name="movie_id" value="${movieId}" />
									<button type="submit" class="btn btn-large">영화 보기</button>
								</form>
							</c:when>
							<c:when
								test="${user.membership_id == 2 || user.membership_id == 3}">
								<a href="${movie.link}" class="btn btn-large" target="_blank">영화 보기</a>
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
