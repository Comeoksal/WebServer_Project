<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../../dbconn.jsp" %>
<sql:update dataSource="${ds}">
	delete from like_review where review_id = ?
	<sql:param value="${param.id}" />
</sql:update>

<sql:update dataSource="${ds}">
	delete from review where id = ?
	<sql:param value="${param.id}" />
</sql:update>

<script>
	alert("리뷰가 삭제되었습니다.");
	location.href = "reviews_admin.jsp";
</script>