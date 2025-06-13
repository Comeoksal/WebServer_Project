<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
    <title>관리자 페이지[홈]</title>
</head>
<body>
	<c:if test="${not empty param.lang}">
    	<fmt:setLocale value="${param.lang}" scope="session" />
	</c:if>
	<fmt:bundle basename="bundle.admin" >
    <%@ include file="header_admin.jsp" %>
   	<%@ include file="../dbconn.jsp" %>
    <sql:query dataSource="${ds}" var="result">
        select * from log order by start_time desc limit 20
    </sql:query>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0"><fmt:message key="admin_home_main" /></h2>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered text-center mx-auto" style="max-width: 1200px;">
            <thead class="table-light">
                <tr>
                	<th><fmt:message key="admin_home_startTime" /></th>
                    <th><fmt:message key="admin_users_userId" /></th>
                    <th><fmt:message key="admin_home_userIp" /></th>
                    <th><fmt:message key="admin_home_userUrl" /></th>
                    <th><fmt:message key="admin_home_clearTime" /></th>
                    <th><fmt:message key="admin_home_userAgent" /></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${result.rows}">
                    <tr>
                        <td>${row.start_time}</td>
                        <td>${row.user_id}</td>
                        <td>${row.ip}</td>
                        <td>${row.url}</td>
                        <td>${row.clear_time}</td>
                        <td>${row.user_agent}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</fmt:bundle>
</body>
</html>
