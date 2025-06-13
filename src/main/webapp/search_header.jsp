<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<style>
html, body {
	margin: 0;
	padding: 0;
}

.search-header {
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #4A90E2;
	padding: 6px 24px;
	box-sizing: border-box;
	height: 40px;
	gap: 12px;
}

.search-title {
	font-weight: bold;
	font-size: 16px;
	color: #E5EAF2;
	margin-right: 12px;
}

.search-form {
	display: flex;
	align-items: center;
	flex-grow: 1;
	margin: 0;
	gap: 8px;
}

.search-form input[type="text"] {
	background-color: transparent;
	width: 200px;
	padding: 4px 10px;
	border-radius: 4px;
	border: none;
	border-bottom: 1px solid #E5EAF2;
	font-size: 14px;
}

.search-form select {
	padding: 4px 8px;
	border-radius: 4px;
	border: none;
	font-size: 14px;
}

.search-form input[type="image"] {
	width: 24px;
	height: 24px;
	cursor: pointer;
	border: none;
}
</style>

<form action="<%= request.getRequestURI() %>" method="get"  class="search-header">
	<div class="search-title">검색</div>
	<div class="search-form">
		<input type="text" name="query" value="${param.query}" />
		<input type="image" src="${pageContext.request.contextPath}/resources/images/search.png" />
		<select name="sort">
			<option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신 순</option>
			<option value="popular" ${param.sort == 'popular' ? 'selected' : ''}>인기 순</option>
			<option value="oldest" ${param.sort == 'oldest' ? 'selected' : ''}>오래된 순</option>
		</select>
	</div>
</form>