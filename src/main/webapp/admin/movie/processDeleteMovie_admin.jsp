<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
    String movieId = request.getParameter("id");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    DELETE FROM movie WHERE id = ?
    <sql:param value="<%= movieId %>" />
</sql:update>

<script>
    alert("영화가 삭제되었습니다.");
    location.href = "movies_admin.jsp";
</script>
