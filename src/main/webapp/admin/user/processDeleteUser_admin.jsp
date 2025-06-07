<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("id");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    DELETE FROM user WHERE id = ?
    <sql:param value="<%= userId %>" />
</sql:update>

<script>
    alert("사용자가 삭제되었습니다.");
    location.href = "users_admin.jsp";
</script>
