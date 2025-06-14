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
    background-color: #0F111A;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 960px;
    margin: 60px auto;
    padding: 0 20px;
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 12px;
}

th {
    text-align: left;
    padding: 14px 16px;
    font-size: 18px;
    color: #f9fafe;
    background-color: #5D9CEC;
}

tbody tr {
    background-color: #f9fafe;
    border-radius: 12px;
}

td {
    padding: 16px;
    color: #333;
    font-size: 17px;
    vertical-align: top;
}

td:first-child {
    font-weight: bold;
    color: #2c2c2c;
}

.like-btn {
    display: inline-flex;
    align-items: center;
    background-color: white;
    border: 1px solid #5D9CEC;
    color: #5D9CEC;
    border-radius: 20px;
    padding: 6px 12px;
    font-size: 13px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.like-btn:hover {
    background-color: #5D9CEC;
    color: #5D9CEC;
}

.like-btn img {
    margin-right: 6px;
    width: 16px;
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
									<img src="../resources/images/heart.png" width="15px">️ ${review.like_count}
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