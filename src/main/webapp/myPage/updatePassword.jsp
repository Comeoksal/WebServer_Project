<%@ page contentType="text/html; charset=utf-8" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../dbconn.jsp" %>

<c:set var="userId" value="${sessionScope.userId}" />
<c:set var="currentPw" value="${param.currentPw}" />
<c:set var="newPw" value="${param.newPw}" />
<c:set var="confirmPw" value="${param.confirmPw}" />

<c:choose>
	<c:when test="${empty userId}">
		<c:redirect url="../signIn/login.jsp" />
	</c:when>

	<c:when test="${newPw ne confirmPw}">
		<script>
			alert("새 비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
	</c:when>

	<c:otherwise>
		<sql:query dataSource="${ds}" var="userInfo">
			SELECT * FROM user WHERE id = ? AND password = ?
			<sql:param value="${userId}" />
			<sql:param value="${currentPw}" />
		</sql:query>

		<c:choose>
			<c:when test="${not empty userInfo.rows}">
				<sql:update dataSource="${ds}">
					UPDATE user SET password = ? WHERE id = ?
					<sql:param value="${newPw}" />
					<sql:param value="${userId}" />
				</sql:update>

				<script>
					alert("비밀번호가 변경되었습니다.");
					location.href = "info.jsp";
				</script>
			</c:when>
			<c:otherwise>
				<script>
					alert("현재 비밀번호가 일치하지 않습니다.");
					history.back();
				</script>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
