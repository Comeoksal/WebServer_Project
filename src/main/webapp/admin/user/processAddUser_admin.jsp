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

	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String nickname = request.getParameter("nickname");
	String role = request.getParameter("role");
	int membership_id = Integer.parseInt(request.getParameter("membership_id"));
	String card_number = request.getParameter("card_number");
	
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    INSERT INTO user (email, password, nickname, role, membership_id, card_number)
    VALUES (?, ?, ?, ?, ?, ?)
    <sql:param value="<%= email %>" />
    <sql:param value="<%= password %>" />
    <sql:param value="<%= nickname %>" />
    <sql:param value="<%= role %>" />
    <sql:param value="<%= membership_id %>" />
    <sql:param value="<%= card_number %>" />
</sql:update>

<script>
    alert("사용자 추가를 성공했습니다.");
    location.href = "users_admin.jsp";
</script>