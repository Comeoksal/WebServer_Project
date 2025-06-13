<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<c:set var="reviewId" value="${param.review_id}" />
<c:set var="userId" value="${sessionScope.userId}" />
<c:if test="${empty userId}">
	<c:redirect url="../signIn/login.jsp" />
</c:if>

<%@ include file="../dbconn.jsp" %>
<sql:query dataSource="${ds}" var="review">
	select id from like_review
	where user_id = ? and review_id = ?
	<sql:param value="${userId}" />
	<sql:param value="${reviewId}" />
</sql:query>

<c:choose>
	<c:when test="${not empty review.rows}">
		<sql:update dataSource="${ds}">
			delete from like_review
			where user_id = ? and review_id = ?
			<sql:param value="${userId}" />
			<sql:param value="${reviewId}" />
		</sql:update>
	</c:when>
	<c:otherwise>
		<sql:update dataSource="${ds}">
			insert into like_review (user_id, review_id) values (?, ?)
			<sql:param value="${userId}" />
			<sql:param value="${reviewId}" />
		</sql:update>
	</c:otherwise>
</c:choose>

<c:redirect url="community.jsp" />