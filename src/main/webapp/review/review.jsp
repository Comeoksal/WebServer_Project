<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>리뷰 작성</title>
  <style>
    body {
      margin: 0;
      background-color: #0d1117;
      color: #e0e0e0;
      font-family: 'Arial', sans-serif;
    }

    .review-form-container {
      max-width: 600px;
      margin: 80px auto;
      padding: 30px;
      background-color: #161b22;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.6);
    }

    .review-form-container h2 {
      margin-bottom: 20px;
    }

    .review-form-container label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }

    .review-form-container input[type="number"],
    .review-form-container textarea {
      width: 100%;
      padding: 10px;
      background-color: #0d1117;
      color: white;
      border: 1px solid #30363d;
      border-radius: 6px;
      margin-bottom: 20px;
      box-sizing: border-box;
    }

    .review-form-container button {
      background-color: #238636;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
    }

    .review-form-container button:hover {
      background-color: #2ea043;
    }
  </style>
</head>
<body>

<%@ include file="../header.jsp" %>
<%@ include file="../dbconn.jsp" %>
<%-- JSP 변수 movieId를 JSTL 변수로 설정 --%>
<%
  String movieId = request.getParameter("id");
/*   String userId = String.valueOf(session.getAttribute("userId"));
 */  request.setAttribute("movieId", movieId);  // 이것도 유지
  request.setAttribute("userId", userId);
%>

<sql:query dataSource="${ds}" var="movieInfo">
  SELECT title FROM movie WHERE id = ?
  <sql:param value="${movieId}" />
</sql:query>

<!-- 닉네임 또는 이메일 표시 -->
<c:set var="displayName" value="${empty sessionScope.nickname ? sessionScope.email : sessionScope.nickname}" />

<div class="review-form-container">
  <h2>리뷰 작성</h2>

  <p style="margin-bottom: 20px; font-size: 16px;">
    <strong>${displayName}</strong>님! <strong>${movieInfo.rows[0].title}</strong> 어떠셨나요?
  </p>

  <form action="processAddReview.jsp" method="post">
    <input type="hidden" name="movie_id" value="${movieId}" />
    <input type="hidden" name="user_id" value="${userId}" />

    <label for="score">평점 (0.0 ~ 5.0)</label>
    <input type="number" name="score" step="0.1" min="0" max="5" required />

    <label for="content">리뷰 내용</label>
    <textarea name="content" rows="6" required></textarea>

    <button type="submit">작성 완료</button>
  </form>
</div>

</body>
</html>
