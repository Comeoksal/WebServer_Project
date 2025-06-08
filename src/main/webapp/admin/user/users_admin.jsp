<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
    <title>관리자 페이지[유저]</title>
</head>
<body>
	<c:if test="${not empty param.lang}">
    	<fmt:setLocale value="${param.lang}" scope="session" />
	</c:if>
	<fmt:bundle basename="bundle.admin" >
    <%@ include file="../header_admin.jsp" %>
   	<%@ include file="../../dbconn.jsp" %>
    <sql:query dataSource="${ds}" var="result">
        SELECT * FROM user
    </sql:query>

<div class="container mt-5">
    <!-- 상단 타이틀 + 버튼을 flex로 구성 -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0"><fmt:message key="admin_users_main" /></h2>
        <a href="addUser_admin.jsp" class="btn btn-success btn-sm">
            <fmt:message key="admin_users_add" />
        </a>
    </div>

    <!-- 테이블을 중앙 정렬 -->
    <div class="table-responsive">
        <table class="table table-bordered text-center mx-auto" style="max-width: 1200px;">
            <thead class="table-light">
                <tr>
                    <th><fmt:message key="admin_users_userId" /></th>
                    <th><fmt:message key="admin_users_email" /></th>
                    <th><fmt:message key="admin_users_password" /></th>
                    <th><fmt:message key="admin_users_nickname" /></th>
                    <th><fmt:message key="admin_users_role" /></th>
                    <th><fmt:message key="admin_membership_membershipId" /></th>
                    <th><fmt:message key="admin_users_cardnumber" /></th>
                    <th><fmt:message key="admin_update" /></th>
                    <th><fmt:message key="admin_delete" /></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${result.rows}">
                    <tr>
                        <td>${row.id}</td>
                        <td>${row.email}</td>
                        <td>${row.password}</td>
                        <td>${row.nickname}</td>
                        <td>${row.role}</td>
                        <td>${row.membership_id}</td>
                        <td>${row.card_number}</td>
                        <td>
                            <a href="editUser_admin.jsp?id=${row.id}" class="btn btn-primary btn-sm">
                                <fmt:message key="admin_update" />
                            </a>
                        </td>
                        <td>
                            <a href="processDeleteUser_admin.jsp?id=${row.id}" class="btn btn-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">
                                <fmt:message key="admin_delete" />
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</fmt:bundle>
</body>
</html>
