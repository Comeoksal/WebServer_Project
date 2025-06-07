<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<c:if test="${not empty param.lang}">
    <fmt:setLocale value="${param.lang}" scope="session" />
</c:if>
<fmt:bundle basename="bundle.admin" />

<%
	request.setCharacterEncoding("utf-8");
	
	String relativePath = "/resources/images";
	String realFolder = application.getRealPath(relativePath);

	int maxSize = 5 * 1024 * 1024;
	String encType="utf-8";
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	

	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String price = multi.getParameter("price");
	String release_date = multi.getParameter("release_date");
	String link = multi.getParameter("link");

	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String image = multi.getFilesystemName(fname);

%>

<%@ include file="../dbconn.jsp" %>

<sql:update dataSource="${ds}">
    INSERT INTO movie (title, content, price, score, release_date, image, link)
    VALUES (?, ?, ?, 0, ?, ?, ?)
    <sql:param value="<%= title %>" />
    <sql:param value="<%= content %>" />
    <sql:param value="<%= price %>" />
    <sql:param value="<%= release_date %>" />
    <sql:param value="<%= image %>" />
    <sql:param value="<%= link %>" />
</sql:update>

<script>
    alert("영화 추가를 성공했습니다.");
    location.href = "movies_admin.jsp";
</script>