<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true"%>

<style>
.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 300px;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  background-color: #fff;
  margin: 100px auto;
  padding: 30px;
  border: 2px solid #5D9CEC;
  border-radius: 12px;
  width: 400px;
  text-align: center;
}

.modal-buttons {
  margin-top: 20px;
}

.modal-buttons .btn {
  display: inline-block;
  margin: 5px 10px;
  padding: 10px 20px;
  background-color: #5D9CEC;
  color: white;
  border: none;
  border-radius: 5px;
  text-decoration: none;	
}

.modal-buttons .btn:hover {
  background-color: #4a8be0;
}
</style>

<%
	request.setCharacterEncoding("utf-8");

	String movieId = null;
	String password = null;
	String cardNumber = null;
	String bank = null;

	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			switch (cookie.getName()) {
				case "movie_id":
					movieId = URLDecoder.decode(cookie.getValue(), "utf-8");
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

	request.setAttribute("movieId", movieId);
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

<%@ include file="../dbconn.jsp"%>
<sql:query dataSource="${ds}" var="userInfo">
	select id, card_number, password from user where id = ?
	<sql:param value="${userId}" />
</sql:query>
<c:set var="userInfo" value="${userInfo.rows[0]}" />

<sql:query dataSource="${ds}" var="movieInfo">
	select title, price from movie where id = ?
	<sql:param value="${movieId}" />
</sql:query>
<c:set var="movieInfo" value="${movieInfo.rows[0]}" />

<%@ include file="../header.jsp"%>
<c:choose>
	<c:when test="${not empty userInfo and userInfo.password eq inputPassword}">
		<%
			String[] cookieNames = { "movie_id", "password", "card_number", "bank" };
			for (String cookieName : cookieNames) {
				Cookie cookie = new Cookie(cookieName, "");
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		%>
    	<sql:update dataSource="${ds}">
          insert into purchase (user_id, movie_id) values (?, ?)
          <sql:param value="${userInfo.id}" />
          <sql:param value="${movieId}" />
        </sql:update>
	<div id="purchaseModal" class="modal" style="display:flex; justify-content:center; align-items:center; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5);">
		<div class="modal-content" style="background:white; padding:30px; border-radius:10px; text-align:center;">
            <h2>구매가 완료되었습니다!</h2>
            <div class="info">
              <p><strong>영화 제목:</strong> ${movieInfo.title}</p>
              <p><strong>결제 금액:</strong> ${movieInfo.price}원</p>
              <p><strong>은행 정보:</strong> ${bank}</p>
              <p><strong>카드 번호:</strong> ${cardNumber}</p>
            </div>
            <div class="modal-buttons" style="margin-top:20px;">
              <a class="btn" href="movie.jsp?id=${movieId}" style="margin-right:10px;">영화 보러가기</a>
              <a class="btn" href="../home.jsp">홈으로</a>
            </div>
		</div>
	</div>
	</c:when>
	<c:otherwise>
		<%
			String[] cookieNames = { "movie_id", "password", "card_number", "bank" };
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
	</c:otherwise>
</c:choose>