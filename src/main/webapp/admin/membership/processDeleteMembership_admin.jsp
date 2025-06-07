<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
    String membershipId = request.getParameter("id");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    DELETE FROM membership WHERE id = ?
    <sql:param value="<%= membershipId %>" />
</sql:update>

<script>
    alert("멤버십 정보가 삭제되었습니다.");
    location.href = "memberships_admin.jsp";
</script>
