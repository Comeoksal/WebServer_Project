<%@ page contentType="text/html; charset=utf-8"%>

<div class="info-panel">
	<h1 style="font-size: 45px;">보안</h1>
	<h3>비밀번호 설정</h3>

	<div class="form-wrapper">
		<form method="post" action="updatePassword.jsp">
			<div class="form-group">
				<label>현재 비밀번호</label>
				<div class="input-button-wrapper">
					<input type="password" name="currentPw" required placeholder="현재 비밀번호를 입력해주세요."/>
				</div>
			</div>

			<div class="form-group">
				<label>새로운 비밀번호</label>
				<div class="input-button-wrapper">
					<input type="password" name="newPw" required placeholder="새 비밀번호를 입력해주세요."/>
				</div>
			</div>

			<div class="form-group">
				<label>새로운 비밀번호 확인</label>
				<div class="input-button-wrapper">
					<input type="password" name="confirmPw" required placeholder="새 비밀번호를 다시 입력해주세요."/>
				</div>
			</div>

			<div class="form-group">
				<button type="submit">변경</button>
			</div>
		</form>
	</div>

</div>
