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
  width: 200px;
  padding: 4px 10px;
  border-radius: 4px;
  border: none;
  font-size: 14px;
}

.search-form select {
  padding: 4px 8px;
  border-radius: 4px;
  border: none;
  font-size: 14px;
}

.search-form button {
  background-color: #E5EAF2;
  color: #5D9CEC;
  font-weight: 500;
  padding: 4px 10px;
  border-radius: 20px;
  border: none;
  font-size: 14px;
  cursor: pointer;
}
</style>

<form action="<%= request.getRequestURI() %>" method="GET" class="search-header">
  <div class="search-title">검색</div>

  <div class="search-form">
    <input type="text" name="query" placeholder="영화 제목" value="${param.query}" />

    <select name="sort">
      <option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신 순</option>
      <option value="popular" ${param.sort == 'popular' ? 'selected' : ''}>인기 순</option>
      <option value="oldest" ${param.sort == 'oldest' ? 'selected' : ''}>오래된 순</option>
    </select>

    <button type="submit">🔍</button>
  </div>
</form>
