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
	margin: 0;
	background-color: #0d1117; /* 어두운 배경색 */
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
<meta charset="utf-8">
<title>커뮤니티</title>
</head>
<body>

	<%@ include file="../header.jsp"%>
	<div style="margin-top: 60px;"></div>
	<%@ include file="../search_header.jsp"%>
	<%@ include file="../dbconn.jsp"%>

	<%
	int currentPage = 1;
	int pageSize = 10;
	if (request.getParameter("page") != null) {
		currentPage = Integer.parseInt(request.getParameter("page"));
	}
	int offset = (currentPage - 1) * pageSize;

	request.setAttribute("page", currentPage);
	request.setAttribute("pageSize", pageSize);
	request.setAttribute("offset", offset);
	%>

	<!-- 정렬 기준 설정 -->
	<c:choose>
		<c:when test="${param.sort eq 'popular'}">
			<c:set var="orderBy" value="like_count DESC" />
		</c:when>
		<c:when test="${param.sort eq 'oldest'}">
			<c:set var="orderBy" value="r.created_at ASC" />
		</c:when>
		<c:otherwise>
			<c:set var="orderBy" value="r.created_at DESC" />
		</c:otherwise>
	</c:choose>

	<!-- 리뷰 데이터 조회 -->
	<sql:query dataSource="${ds}" var="result">
  SELECT
  	r.id,
    r.content,
    r.score,
    m.title,
    COUNT(l.id) AS like_count
  FROM review r
  JOIN movie m ON r.movie_id = m.id
  LEFT JOIN like_review l ON r.id = l.review_id
  WHERE m.title LIKE ?
  GROUP BY r.id, r.content, r.score, m.title, m.id
  ORDER BY ${orderBy}
  LIMIT ?
  OFFSET ?
  <sql:param value="%${param.query}%" />
		<sql:param value="${pageSize}" />
		<sql:param value="${offset}" />
	</sql:query>

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
   <c:forEach var="row" items="${result.rows}">
  <tr>
    <td style="padding: 8px; border: 1px solid #ccc;">
	    ${row.title}
	</td>
    <td style="padding: 8px; border: 1px solid #ccc;">
      <c:choose>
        <c:when test="${fn:length(row.content) > 50}">
          ${fn:substring(row.content, 0, 50)}...
        </c:when>
								<c:otherwise>
          ${row.content}
        </c:otherwise>
							</c:choose></td>
						<td style="padding: 8px; border: 1px solid #ccc;">${row.score}</td>
						<td style="padding: 8px; border: 1px solid #ccc;">
							<form action="processLikeReview.jsp" method="post"
								style="display: inline;">
								<input type="hidden" name="review_id" value="${row.id}" />
								<button type="submit"
									style="background: none; border: 1px solid #ccc; color: #58a6ff; cursor: pointer; border-radius: 8px; padding: 4px 10px;">
									❤️ ${row.like_count}</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>


	<!-- 페이지 네비게이션 -->
	<div style="text-align: center; margin-top: 20px;">
		<form method="get">
			<button type="submit" name="page" value="${page - 1}"
				${page <= 1 ? "disabled" : ""}>이전</button>
			<span>페이지 ${page}</span>
			<button type="submit" name="page" value="${page + 1}">다음</button>

			<!-- 정렬/검색 유지 -->
			<input type="hidden" name="sort" value="${param.sort}" /> <input
				type="hidden" name="query" value="${param.query}" />
		</form>
	</div>

</body>
</html>
