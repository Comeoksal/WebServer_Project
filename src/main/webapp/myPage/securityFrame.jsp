<%@ page contentType="text/html; charset=utf-8"%>

<div class="info-panel">
	<h1 style="font-size: 45px;">보안</h1>
	<h3>비밀번호 설정</h3>

	<div class="form-wrapper">
		<form method="post" action="updatePassword.jsp">
			<div class="form-group">
				<label>현재 비밀번호</label>
				<div class="input-button-wrapper">
					<input type="password" name="currentPw" required />
				</div>
			</div>

			<div class="form-group">
				<label>새로운 비밀번호</label>
				<div class="input-button-wrapper">
					<input type="password" name="newPw" required />
				</div>
			</div>

			<div class="form-group">
				<label>새로운 비밀번호 확인</label>
				<div class="input-button-wrapper">
					<input type="password" name="confirmPw" required />
				</div>
			</div>

			<div class="form-group">
				<button type="submit">변경</button>
			</div>
		</form>
	</div>

</div>
