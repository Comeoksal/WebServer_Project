<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page session="true"%>
<%@ include file="../dbconn.jsp"%>
<%@ include file="../header.jsp"%>

<c:choose>
  <c:when test="${empty sessionScope.user_email}">
    <script>
      alert("로그인이 필요합니다.");
      location.href = "${pageContext.request.contextPath}/signIn/login.jsp";
    </script>
  </c:when>
  <c:otherwise>
    <c:set var="userEmail" value="${sessionScope.user_email}" />
    <c:set var="movieId" value="${param.movie_id}" />

    <!-- 사용자 정보 조회 -->
    <sql:query dataSource="${ds}" var="userInfo">
      SELECT id, card_number FROM user WHERE email = ?
      <sql:param value="${userEmail}" />
    </sql:query>

    <!-- 영화 정보 조회 -->
    <sql:query dataSource="${ds}" var="movieInfo">
      SELECT title, price FROM movie WHERE id = ?
      <sql:param value="${movieId}" />
    </sql:query>

    <!-- 구매 INSERT -->
    <c:if test="${not empty userInfo.rows and not empty movieInfo.rows}">
      <sql:update dataSource="${ds}">
        INSERT INTO purchase (user_id, movie_id) VALUES (?, ?)
        <sql:param value="${userInfo.rows[0].id}" />
        <sql:param value="${movieId}" />
      </sql:update>
    </c:if>

<style>
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

</style>

<c:if test="${not empty userInfo.rows and not empty movieInfo.rows}">
  <div id="purchaseModal" class="modal">
    <div class="modal-content">
      <h2>구매가 완료되었습니다!</h2>
      <div class="info">
        <p><strong>영화 제목:</strong> ${movieInfo.rows[0].title}</p>
        <p><strong>결제 금액:</strong> ${movieInfo.rows[0].price}원</p>
        <p><strong>카드 번호:</strong> ${userInfo.rows[0].card_number}</p>
      </div>
      <div class="modal-buttons">
        <a class="btn" href="movie.jsp?id=${movieId}">영화 보러가기</a>
        <a class="btn" href="../home.jsp">홈으로</a>
      </div>
    </div>
  </div>
  
</c:if>

  </c:otherwise>
</c:choose>