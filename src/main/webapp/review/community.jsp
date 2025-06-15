<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<c:set var="sort" value="${param.sort}" />
<%@ include file="../dbconn.jsp"%>

	<title>커뮤니티</title>
<c:set var="sort" value="${param.sort}" />
<c:set var="userId" value="${sessionScope.userId}" />
<%@ include file="../dbconn.jsp"%>

</head>
<body>
	<%@ include file="../header.jsp"%>
	<div style="margin-top: 60px;"></div>
	<%@ include file="../search_header.jsp"%>
	<div class="container">
		<table
			style="width: 100%; border-collapse: collapse; color: white; margin-top: 20px;">
			<thead style="background-color: #444;">
				<tr>
					<th
						style="width: 30%; padding: 8px; border: 1px solid #ccc; text-align: left;">영화
						제목</th>
					<th style="padding: 8px; border: 1px solid #ccc; text-align: left;">리뷰
						내용</th>
					<th style="padding: 8px; border: 1px solid #ccc; text-align: left;">평점</th>
					<th style="padding: 8px; border: 1px solid #ccc; text-align: left;">좋아요
						수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="review" items="${reviewList}">
					<tr>
						<td style="padding: 8px; border: 1px solid #ccc;">
							${review.title}</td>
						<td style="padding: 8px; border: 1px solid #ccc;"><c:choose>
								<c:when test="${fn:length(review.content) > 50}">
									${fn:substring(review.content, 0, 50)}...
								</c:when>
								<c:otherwise>
									${review.content}
								</c:otherwise>
							</c:choose></td>
						<td style="padding: 8px; border: 1px solid #ccc;">
							${review.score}</td>
						<td style="padding: 8px; border: 1px solid #ccc;">
							<form action="${pageContext.request.contextPath}/ReviewLikeToggle.do" method="post" style="display: inline;">
							    <input type="hidden" name="review_id" value="${review.id}" />
							    <input type="hidden" name="user_id" value="${userId}" />
							    <button type="submit" class="like-button"
							        <c:if test="${empty userId}">disabled</c:if>>
							        <img src="${pageContext.request.contextPath}/resources/images/heart.png" width="15px"/>
							        ${review.likes}
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