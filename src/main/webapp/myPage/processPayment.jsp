<%@ page contentType="text/html; charset=utf-8" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../dbconn.jsp" %>

<c:set var="userId" value="${sessionScope.userId}" />
<c:set var="inputPassword" value="${param.password}" />
<c:set var="membershipId" value="${param.membership_id}" />

<c:if test="${empty userId}">
	<c:redirect url="../signIn/login.jsp" />
</c:if>

<sql:query var="userCheck" dataSource="${ds}">
<<<<<<< HEAD
	SELECT password FROM user WHERE id = ?
	<sql:param value="${userId}" />
=======
	SELECT password FROM user WHERE email = ?
	<sql:param value="${userEmail}" />
>>>>>>> aacbdb5f048caea98dd35f9eb881867f2251279a
</sql:query>

<c:set var="storedPassword" value="${userCheck.rows[0].password}" />
<c:set var="passwordMatch" value="${storedPassword eq inputPassword}" />

<c:if test="${passwordMatch}">
	<sql:update dataSource="${ds}">
		UPDATE user SET membership_id = ? WHERE id = ?
		<sql:param value="${membershipId}" />
		<sql:param value="${userId}" />
	</sql:update>

	<script>
		window.onload = function() {
			document.getElementById("modal").style.display = "flex";
		};
		function redirectToMembership() {
			window.location.href = "membership.jsp";
		}
	</script>

  <div id="modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
	<div style="background:white; padding:30px; border-radius:10px; text-align:center;">
		<h3>구매해 주셔서 감사합니다!</h3>
		<p>
			회원님의 멤버십이 정상적으로 활성화되었습니다.<br>
			해지는 언제든지 <strong>마이페이지</strong>에서 가능합니다.<br>
			환불 및 약관은 관련 페이지를 참조하세요.
		</p>
		<button onclick="redirectToMembership()" style="padding:10px 20px; background:#5D9CEC; color:white; border:none; border-radius:5px;">확인</button>
		</div>
	</div>
</c:if>

<c:if test="${not passwordMatch}">
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
</c:if>

