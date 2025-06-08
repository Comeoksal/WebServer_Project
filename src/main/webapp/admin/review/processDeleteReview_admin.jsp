<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
    String reviewId = request.getParameter("id");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    DELETE FROM review WHERE id = ?
    <sql:param value="<%= reviewId %>" />
</sql:update>

<script>
    alert("리뷰가 삭제되었습니다.");
    location.href = "reviews_admin.jsp";
</script>
