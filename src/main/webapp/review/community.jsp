<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="sort" value="${param.sort}" />

<c:choose>
	<c:when test="${sort eq 'popular'}">
		<c:set var="orderBy" value="like_count desc" />
	</c:when>
	<c:when test="${sort eq 'oldest'}">
		<c:set var="orderBy" value="r.created_at asc" />
	</c:when>
	<c:otherwise>
		<c:set var="orderBy" value="r.created_at desc" />
	</c:otherwise>
</c:choose>

<%@ include file="../dbconn.jsp"%>
<sql:query dataSource="${ds}" var="reviews">
	select r.id, r.content, r.score, m.title, count(l.id) as like_count
	from review r
	join movie m on r.movie_id = m.id
	left join like_review l on r.id = l.review_id
	where m.title like ?
	group by r.id, r.content, r.score, m.title, m.id
	order by ${orderBy}
	limit 50
	<sql:param value="%${param.query}%" />
</sql:query>

<!DOCTYPE html>
<html>
<head>
	<style>
		body {
			margin: 0;
			background-color: #0d1117;
			color: #e0e0e0;
			font-family: 'Arial', sans-serif;
		}
		a {
			color: inherit;
			text-decoration: none;
		}
		.container {
			max-width: 1000px;
			margin: 0 auto;
			margin-top: 20px;
		}
	</style>
	<title>커뮤니티</title>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div style="margin-top: 60px;"></div>
	<%@ include file="../search_header.jsp"%>
	<div class="container">
		<table style="width: 100%; border-collapse: collapse; color: white; margin-top: 20px;">
			<thead style="background-color: #444;">
				<tr>
					<th style="width: 30%; padding: 8px; border: 1px solid #ccc; text-align: left;">영화 제목</th>
					<th style="padding: 8px; border: 1px solid #ccc; text-align: left;">리뷰 내용</th>
					<th style="padding: 8px; border: 1px solid #ccc; text-align: left;">평점</th>
					<th style="padding: 8px; border: 1px solid #ccc; text-align: left;">좋아요 수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="review" items="${reviews.rows}">
					<tr>
						<td style="padding: 8px; border: 1px solid #ccc;">
							${review.title}
						</td>
						<td style="padding: 8px; border: 1px solid #ccc;">
							<c:choose>
								<c:when test="${fn:length(review.content) > 50}">
									${fn:substring(review.content, 0, 50)}...
								</c:when>
								<c:otherwise>
									${review.content}
								</c:otherwise>
							</c:choose>
						</td>
						<td style="padding: 8px; border: 1px solid #ccc;">
							${review.score}
						</td>
						<td style="padding: 8px; border: 1px solid #ccc;">
							<form action="processLikeReview.jsp" method="post" style="display: inline;">
								<input type="hidden" name="review_id" value="${review.id}" />
								<button type="submit"
									style="background: none; border: 1px solid #ccc; color: #58a6ff; cursor: pointer; border-radius: 8px; padding: 4px 10px;">
									❤️ ${review.like_count}
								</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>