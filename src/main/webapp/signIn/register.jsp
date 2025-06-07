<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #0F111A;
	margin: 0;
	padding-top: 80px;
}

.form-group label {
	color: white;
}

.login-logo {
	width: 80px;
	height: auto;
	display: block;
	margin: 0 auto 10px auto;
}

h2 {
	font-family: 'Courier New', monospace;
	margin-bottom: 30px;
}

.register-container {
	width: 450px;
	margin: 0 auto;
	background-color: #0F111A;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.register-container h2 {
	text-align: center;
	margin-bottom: 24px;
	font-size: 28px;
	color: white;
}

.form-group {
	margin-bottom: 18px;
	text-align: center;
}

.form-group label {
	font-weight: bold;
	text-align: left;
	display: block;
	margin-left: 30px;
	margin-bottom: 6px;
}

.input-wrapper {
	margin-left: 27px;
	display: flex;
	align-items: center;
	background-color: white;
	border: 2px solid #5D9CEC;
	border-radius: 8px;
	width: 400px;
	padding: 12px 12px;
	box-sizing: border-box;
}

.input-wrapper img {
	width: 20px;
	height: 20px;
	margin-right: 10px;
}

.input-wrapper input {
	border: none;
	outline: none;
	flex: 1;
	font-size: 16px;
	background-color: transparent;
}

.form-group input {
	width: 380px;
	padding: 5px;
	border-radius: 8px;
	font-size: 16px;
}

.form-group input[type="checkbox"] {
	width: auto;
}

.form-group a {
	font-size: 14px;
	color: white;
	cursor: pointer;
	text-decoration: underline;
}

.form-group button, .submit-btn {
	padding: 12px 20px;
	background-color: #5D9CEC;
	color: white;
	font-size: 16px;
	border: none;
	border-radius: 10px;
	width: 410px;
	cursor: pointer;
}

.form-group button:hover {
	background-color: #3b82f6;
}

.terms-group {
	margin-left: -10px;
	display: flex;
	align-items: center;
	gap: 12px;
	margin-top: 16px;
}

.terms-label {
	display: flex;
	align-items: center;
	gap: 8px;
	font-weight: bold;
	color: white;
	cursor: pointer;
}

.terms-detail {
	color: #ccc;
	font-size: 14px;
	text-decoration: underline;
	cursor: pointer;
}

.terms-detail:hover {
	color: #5D9CEC;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1001;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow-y: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: white;
	margin: 10% auto;
	padding: 30px;
	border-radius: 8px;
	width: 80%;
	max-width: 600px;
}

.modal h3 {
	margin-top: 0;
	color: #5D9CEC;
}

.close-btn {
	float: right;
	font-size: 20px;
	cursor: pointer;
	color: #999;
}

.close-btn:hover {
	color: #333;
}
</style>
</head>
<body>

	<%@ include file="../header.jsp"%>

	<div class="register-container">
		<div style="text-align: center; margin-bottom: 20px;">
			<img
				src="<%=request.getContextPath()%>/resources/images/movitLogo.png"
				alt="movit 로고" class="login-logo"
				style="width: 80px; height: auto; margin-top: 80px; margin-bottom: 10px;" />
			<h2 style="font-size: 45px; margin: 10px 0;">movit</h2>
		</div>
		<form action="register_process.jsp" method="post">
			<div class="form-group">
				<label>이메일</label>
				<div class="input-wrapper">
					<img src="<%=request.getContextPath()%>/resources/images/email.png"
						alt="이메일 아이콘"> <input type="email" name="email" required
						placeholder="이메일 주소를 입력해주세요.">
				</div>
			</div>

			<div class="form-group">
				<label>비밀번호</label>
				<div class="input-wrapper">
					<img src="<%=request.getContextPath()%>/resources/images/lock.png"
						alt="비밀번호 아이콘"> <input type="password" name="password"
						required placeholder="비밀번호를 입력해주세요.">
				</div>
			</div>

			<div class="form-group">
				<label>비밀번호 확인</label>
				<div class="input-wrapper">
					<img src="<%=request.getContextPath()%>/resources/images/lock.png"
						alt="비밀번호 확인 아이콘"> <input type="password"
						name="confirm" required placeholder="비밀번호를 다시 입력해주세요.">
				</div>
			</div>

			<div class="form-group terms-group">
				<label for="agree" class="terms-label"> <input
					type="checkbox" id="agree" required /> 약관에 동의합니다.
				</label> <a onclick="openModal()" class="terms-detail">[자세히 보기]</a>
			</div>

			<div class="form-group">
				<button type="submit">가입하기</button>
			</div>
		</form>

	</div>

	<div id="termsModal" class="modal">
		<div class="modal-content">
			<span class="close-btn" onclick="closeModal()">&times;</span>
			<h3>이용약관 및 개인정보처리방침</h3>
			<p>
				Movit는 사용자의 개인정보 보호를 최우선으로 생각합니다. 본 약관은 서비스 이용과 관련한 기본적인 조건을 정한
				것입니다.<br> <br> 수집 항목: 이메일, 비밀번호, 닉네임<br> 이용 목적: 서비스
				제공, 개인 맞춤 서비스, 문의 응대 등<br> <br> 자세한 내용은 관리자에게 문의해 주세요.
			</p>
		</div>
	</div>

	<script>
  function openModal() {
    document.getElementById('termsModal').style.display = 'block';
  }

  function closeModal() {
    document.getElementById('termsModal').style.display = 'none';
  }

  window.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') closeModal();
  });

  window.onclick = function(event) {
    const modal = document.getElementById('termsModal');
    if (event.target == modal) {
      closeModal();
    }
  }
 
</script>
<script>
  try {
    navigator.mediaSession.setActionHandler("enterpictureinpicture", null);
  } catch (e) {
    console.warn("enterpictureinpicture is not supported.");
  }
</script>


</body>
</html>
