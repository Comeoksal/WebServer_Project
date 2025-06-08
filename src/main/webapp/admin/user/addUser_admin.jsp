<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<c:if test="${not empty param.lang}">
    <fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin">

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title><fmt:message key="admin_users_add" /></title>
</head>
<body>
    <%@ include file="../header_admin.jsp" %>
    <%@ include file="../../dbconn.jsp" %>
    <sql:query dataSource="${ds}" var="membershipList">
    	SELECT id, name FROM membership
	</sql:query>

    <div class="container mt-5">
        <h3><fmt:message key="admin_users_add" /></h3>
        <form action="processAddUser_admin.jsp" method="post">
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_users_email" /></label>
                <input type="text" name="email" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_users_password" /></label>
                <input type="password" name="password" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label"><fmt:message key="admin_users_nickname" /></label>
                <input type="text" name="nickname" class="form-control" required />
            </div>
            <div class="mb-3">
    			<label class="form-label"><fmt:message key="admin_users_role" /></label>
    			<select name="role" class="form-select" required>
        			<option value="user">User</option>
        			<option value="admin">Admin</option>
    			</select>
			</div>
            <div class="mb-3">
    			<label class="form-label"><fmt:message key="admin_membership_membershipId" /></label>
    			<select name="membership_id" class="form-select" required>
        			<c:forEach var="row" items="${membershipList.rows}">
            			<option value="${row.id}">${row.name} (ID: ${row.id})</option>
       			    </c:forEach>
    			</select>
			</div>
			<div class="mb-3">
    			<label class="form-label"><fmt:message key="admin_users_cardnumber" /></label>
                <input type="text" name="card_number" class="form-control" required />
			</div>
            <button type="submit" class="btn btn-primary"><fmt:message key="admin_users_add" /></button>
        </form>
    </div>
</fmt:bundle>
</body>
</html>
