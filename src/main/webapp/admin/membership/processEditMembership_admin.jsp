<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String content = request.getParameter("content");
    String price = request.getParameter("price");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    UPDATE membership
    SET name = ?, content = ?, price = ?
    WHERE id = ?
    <sql:param value="<%= name %>" />
    <sql:param value="<%= content %>" />
    <sql:param value="<%= price %>" />
    <sql:param value="<%= id %>" />
</sql:update>

<script>
    alert("멤버십 정보가 수정되었습니다.");
    location.href = "memberships_admin.jsp";
</script>
