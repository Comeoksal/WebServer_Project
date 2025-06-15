<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.net.URLDecoder" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>

<%
	request.setCharacterEncoding("utf-8");

	String membershipId = null;
	String password = null;
	String cardNumber = null;
	String bank = null;

	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			switch (cookie.getName()) {
				case "membership_id":
					membershipId = URLDecoder.decode(cookie.getValue(), "utf-8");
					break;
				case "password":
					password = URLDecoder.decode(cookie.getValue(), "utf-8");
					break;
				case "card_number":
					cardNumber = URLDecoder.decode(cookie.getValue(), "utf-8");
					break;
				case "bank":
					bank = URLDecoder.decode(cookie.getValue(), "utf-8");
					break;
			}
		}
	}

	request.setAttribute("membershipId", membershipId);
	request.setAttribute("inputPassword", password);
	request.setAttribute("cardNumber", cardNumber);
	request.setAttribute("bank", bank);
%>

<c:set var="userId" value="${sessionScope.userId}" />
<c:if test="${empty userId}">
	<script>
		alert("로그인 후 이용 가능합니다.");
		location.href = "../../signIn/login.jsp";
	</script>
</c:if>

<%@ include file="../dbconn.jsp" %>
<sql:query dataSource="${ds}" var="membershipInfo">
    select name, price from membership where id = ?
    <sql:param value="${membershipId}" />
</sql:query>
<c:set var="membershipInfo" value="${membershipInfo.rows[0]}" />

<sql:query dataSource="${ds}" var="userInfo" >
  select password from user where id = ?
  <sql:param value="${userId}" />
</sql:query>
<c:set var="userInfo" value="${userInfo.rows[0]}" />

<c:set var="storedPassword" value="${userInfo.password}" />
<c:set var="passwordMatch" value="${storedPassword eq inputPassword}" />

<c:if test="${passwordMatch}">
	<%
		String[] cookieNames = { "membership_id", "password", "card_number", "bank" };
		for (String cookieName : cookieNames) {
			Cookie cookie = new Cookie(cookieName, "");
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	%>
  <sql:update dataSource="${ds}">
    update user set membership_id = ? where id = ?
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
      <div class="info">
              <p><strong>멤버십 정보:</strong> ${membershipInfo.name}</p>
              <p><strong>결제 금액:</strong> ${membershipInfo.price}원</p>
              <p><strong>은행 정보:</strong> ${bank}</p>
              <p><strong>카드 번호:</strong> ${cardNumber}</p>
      </div>
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
	<%
		String[] cookieNames = { "membership_id", "password", "card_number", "bank" };
		for (String cookieName : cookieNames) {
			Cookie cookie = new Cookie(cookieName, "");
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	%>
  <script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
  </script>
</c:if>
