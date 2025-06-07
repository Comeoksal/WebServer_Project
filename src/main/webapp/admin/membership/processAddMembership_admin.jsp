<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<c:if test="${not empty param.lang}">
    <fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin" />

<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String content = request.getParameter("content");
	String price = request.getParameter("price");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    INSERT INTO membership (name, content, price)
    VALUES (?, ?, ?)
    <sql:param value="<%= name %>" />
    <sql:param value="<%= content %>" />
    <sql:param value="<%= price %>" />
</sql:update>

<script>
    alert("멤버십 추가를 성공했습니다.");
    location.href = "memberships_admin.jsp";
</script>