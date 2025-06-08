<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<%@ include file="../dbconn.jsp" %>

<%
    String reviewId = request.getParameter("review_id");
    Object userIdObj = session.getAttribute("userId");

    if (reviewId != null && userIdObj != null) {
        request.setAttribute("reviewId", reviewId);
        request.setAttribute("userId", userIdObj.toString());
    } else {
%>
    <script>
        alert("로그인이 필요하거나 요청이 올바르지 않습니다.");
        location.href = "../signIn/login.jsp";
    </script>
<%
        return;
    }
%>

<!-- 1. 이미 좋아요 했는지 확인 -->
<sql:query var="existingLike" dataSource="${ds}">
    SELECT id FROM like_review
    WHERE user_id = ? AND review_id = ?
    <sql:param value="${userId}" />
    <sql:param value="${reviewId}" />
</sql:query>

<!-- 2. 존재하면 삭제, 없으면 삽입 -->
<c:choose>
    <c:when test="${not empty existingLike.rows}">
        <!-- 삭제 -->
        <sql:update dataSource="${ds}">
            DELETE FROM like_review
            WHERE user_id = ? AND review_id = ?
            <sql:param value="${userId}" />
            <sql:param value="${reviewId}" />
        </sql:update>
    </c:when>
    <c:otherwise>
        <!-- 삽입 -->
        <sql:update dataSource="${ds}">
            INSERT INTO like_review (user_id, review_id)
            VALUES (?, ?)
            <sql:param value="${userId}" />
            <sql:param value="${reviewId}" />
        </sql:update>
    </c:otherwise>
</c:choose>

<%
    response.sendRedirect("community.jsp");
%>
