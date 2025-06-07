<%@ page contentType="text/html; charset=utf-8"%>

<div class="info-panel">
	<h1 style="font-size: 45px;">내 정보</h1>

	<div class="form-wrapper">
		<form action="updateInfo.jsp" method="post">
			<div class="form-group">
				<label>닉네임</label>
				<div class="input-button-wrapper">
					<input type="text" name="nickname" placeholder="새 닉네임 입력" />
					<button type="submit" name="action" value="nickname">변경</button>
				</div>
			</div>

			<div class="form-group">
				<label>전화번호</label>
				<div class="input-button-wrapper">
					<input type="text" name="phone" placeholder="새 전화번호 입력" />
					<button type="submit" name="action" value="phone">변경</button>
				</div>
			</div>

			<div class="form-group">
				<label>이메일 주소</label>
				<div class="input-button-wrapper">
					<input type="email" name="email" placeholder="새 이메일 주소 입력"/>
					<button type="submit" name="action" value="email">변경</button>
				</div>
			</div>
		</form>
	</div>
</div>
<% 
    String updated = request.getParameter("updated"); 
    if ("true".equals(updated)) { 
%>
<script>
    alert("변경되었습니다!");
</script>
<% } %>

