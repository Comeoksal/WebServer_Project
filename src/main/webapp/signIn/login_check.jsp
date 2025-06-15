<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="true" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
%>

<%@ include file="../dbconn.jsp" %>

<sql:query dataSource="${ds}" var="result" >
	SELECT * FROM user WHERE email = ? AND password = ?
    <sql:param value="${param.email}" />
    <sql:param value="${param.password}" />
</sql:query>

<c:choose>
    <c:when test="${not empty result.rows}">
		<c:set var="user" value="${result.rows[0]}" />
		<c:set var="userId" value="${user.id}" scope="session" />
		<c:set var="nickname" value="${user.nickname}" scope="session" />
		<c:set var="user_email" value="${user.email}" scope="session" />
		<c:set var="role" value="${user.role}" scope="session" />
		<%
    		response.sendRedirect("../home.jsp");
		%>
    </c:when>
    <c:otherwise>
        <%
            response.sendRedirect("login.jsp?error=1");
        %>
    </c:otherwise>
</c:choose>
