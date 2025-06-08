<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String nickname = request.getParameter("nickname");
    String role = request.getParameter("role");
    int membership_id = Integer.parseInt(request.getParameter("membership_id"));
    String card_number = request.getParameter("card_number");
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    UPDATE user
    SET email = ?, password = ?, nickname = ?, role = ?, membership_id = ?, card_number = ?
    WHERE id = ?
    <sql:param value="<%= email %>" />
    <sql:param value="<%= password %>" />
    <sql:param value="<%= nickname %>" />
    <sql:param value="<%= role %>" />
    <sql:param value="<%= membership_id %>" />
    <sql:param value="<%= card_number %>" />
    <sql:param value="<%= id %>" />
</sql:update>

<script>
    alert("사용자 정보가 수정되었습니다.");
    location.href = "users_admin.jsp";
</script>
