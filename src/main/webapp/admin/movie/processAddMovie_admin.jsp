<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.io.*, java.util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String relativePath = "/resources/images";
	String realFolder = application.getRealPath(relativePath);

	int maxSize = 5 * 1024 * 1024;
	String encType = "utf-8";

	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	String lang = multi.getParameter("lang");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String price = multi.getParameter("price");
	String release_date = multi.getParameter("release_date");
	String link = multi.getParameter("link");

	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String image = multi.getFilesystemName(fname);

	if (lang != null && !lang.isEmpty()) {
%>
	<fmt:setLocale value="<%= lang %>" scope="session" />
<%
	}
%>

<fmt:bundle basename="bundle.admin" />
<%@ include file="../../dbconn.jsp" %>

<sql:update dataSource="${ds}">
	insert into movie (title, content, price, score, release_date, image, link)
	values (?, ?, ?, 0, ?, ?, ?)
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
