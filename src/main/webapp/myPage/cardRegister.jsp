<%@ page contentType="text/html; charset=utf-8" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../dbconn.jsp" %>

<c:set var="card" value="${param.card}" />
<c:set var="email" value="${sessionScope.user_email}" />

<sql:update dataSource="${ds}" var="updateResult">
  UPDATE user SET card_number = ? WHERE email = ?
  <sql:param value="${card}" />
  <sql:param value="${email}" />
</sql:update>

<c:choose>
  <c:when test="${updateResult >= 1}">
    <script>
      alert("카드번호가 성공적으로 등록되었습니다.");
      location.href = "membership.jsp";
    </script>
  </c:when>
  <c:otherwise>
    <script>
      alert("등록에 실패했습니다.");
      history.back();
    </script>
  </c:otherwise>
</c:choose>
