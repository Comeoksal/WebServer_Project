<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page session="true"%>
<%@ include file="../dbconn.jsp"%>

<c:choose>
	<c:when test="${empty sessionScope.userId}">
		<c:redirect url="../signIn/login.jsp" />
	</c:when>
	<c:otherwise>
		<c:set var="userId" value="${sessionScope.userId}" />
		<sql:query dataSource="${ds}" var="userResult">
			SELECT nickname, phone, email FROM user WHERE id = ?
			<sql:param value="${userId}" />
		</sql:query>

		<c:forEach var="user" items="${userResult.rows}">
			<c:set var="nicknamePlaceholder"
				value="${empty user.nickname ? '닉네임이 없습니다.' : user.nickname}" />
			<c:set var="phonePlaceholder"
				value="${empty user.phone ? '전화번호가 없습니다.' : user.phone}" />
			<c:set var="emailPlaceholder"
				value="${empty user.email ? '이메일이 없습니다.' : user.email}" />

			<c:if test="${param.error eq 'phone_exists'}">
				<script>
					alert('이미 등록된 전화번호입니다.');
				</script>
			</c:if>

			<c:if test="${param.error eq 'email_exists'}">
				<script>
					alert('이미 등록된 이메일입니다.');
				</script>
			</c:if>

			<c:if test="${param.updated eq 'true'}">
				<script>
					alert('정보가 성공적으로 수정되었습니다.');
				</script>
			</c:if>
			
			<div class="info-panel">
				<h1 style="font-size: 45px;">내 정보</h1>
				<div class="form-wrapper">
					<form action="updateInfo.jsp" method="post">
						<div class="form-group">
							<label>닉네임</label>
							<div class="input-button-wrapper">
								<input type="text" name="nickname"
									placeholder="${nicknamePlaceholder}" />
								<button type="submit" name="action" value="nickname">변경</button>
							</div>
						</div>

						<div class="form-group">
							<label>전화번호</label>
							<div class="input-button-wrapper">
								<input type="text" name="phone"
									placeholder="${phonePlaceholder}" />
								<button type="submit" name="action" value="phone">변경</button>
							</div>
						</div>

						<div class="form-group">
							<label>이메일 주소</label>
							<div class="input-button-wrapper">
								<input type="email" name="email"
									placeholder="${emailPlaceholder}" />
								<button type="submit" name="action" value="email">변경</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
