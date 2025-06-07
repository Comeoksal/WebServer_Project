<%@ page import="java.io.*, java.util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");

    String relativePath = "/resources/images";
    String realFolder = application.getRealPath(relativePath);
    int maxSize = 5 * 1024 * 1024;

    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, "utf-8", new DefaultFileRenamePolicy());

    String id = multi.getParameter("id");
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    String price = multi.getParameter("price");
    String release_date = multi.getParameter("release_date");
    String link = multi.getParameter("link");
    String oldImage = multi.getParameter("oldImage");
    String image = multi.getFilesystemName("image");

    if (image == null || image.trim().equals("")) {
        image = oldImage;
    }
%>

<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    UPDATE movie
    SET title = ?, content = ?, price = ?, release_date = ?, link = ?, image = ?
    WHERE id = ?
    <sql:param value="<%= title %>" />
    <sql:param value="<%= content %>" />
    <sql:param value="<%= price %>" />
    <sql:param value="<%= release_date %>" />
    <sql:param value="<%= link %>" />
    <sql:param value="<%= image %>" />
    <sql:param value="<%= id %>" />
</sql:update>

<script>
    alert("영화 정보가 수정되었습니다.");
    location.href = "movies_admin.jsp";
</script>
