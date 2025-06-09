<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page session="true" %>
<%@ include file="../dbconn.jsp" %>

<c:choose>
  <c:when test="${empty sessionScope.userId}">
    <c:redirect url="../signIn/login.jsp" />
  </c:when>
  <c:otherwise>

    <!-- 현재 유저 정보 조회 (멤버십 ID, 카드번호 등) -->
    <c:set var="userId" value="${sessionScope.userId}" />
    <sql:query dataSource="${ds}" var="userInfo">
      SELECT u.membership_id, u.card_number, m.name AS membership_name
      FROM user u
      LEFT JOIN membership m ON u.membership_id = m.id
      WHERE u.id = ?
      <sql:param value="${userId}" />
    </sql:query>

    <c:forEach var="info" items="${userInfo.rows}">
      <div class="info-panel membership-panel">
        <h1 style="font-size: 45px;">
          멤버십
          <span style="font-size: 20px; color: #5D9CEC;">
            현재 플랜:
            <c:choose>
              <c:when test="${not empty info.membership_name}">
                ${info.membership_name}
              </c:when>
              <c:otherwise>
                없음
              </c:otherwise>
            </c:choose>
          </span>
        </h1>

        <!-- 전체 멤버십 목록 조회 -->
        <sql:query dataSource="${ds}" var="plans">
          SELECT id, name, content, price FROM membership
        </sql:query>

        <form method="post" action="membershipPay.jsp">
          <c:forEach var="plan" items="${plans.rows}">
            <c:set var="isCurrent" value="${plan.id == info.membership_id}" />
            <div class="membership-box"
              style="<c:if test='${isCurrent}'>background-color:#ECF7FF; border:2px solid #2196F3;</c:if>">
              <div>
                <div class="membership-name" style="color:#5D9CEC; font-weight:bold;">${plan.name}</div>
                <div class="membership-content" style="font-size:smaller;">${plan.content}</div>
                <div class="membership-price">${plan.price}원</div>
              </div>
              <button type="submit" name="membership_id" value="${plan.id}" class="membership-btn">결제</button>
            </div>
          </c:forEach>
        </form>

        <!-- 카드번호 등록 -->
        <form action="cardRegister.jsp" method="post" style="margin-top:30px;">
          <label class="membership-label">카드번호 등록</label>
          <div class="membership-input-row">
            <input type="text" name="card" placeholder="카드번호 입력" required class="membership-input"
              pattern="\d{16}" title="16자리 숫자를 입력하세요" />
            <button type="submit" class="membership-btn">등록</button>
          </div>
          <div style="margin-top: 10px; font-size: 14px; color: #333;">
            현재 등록된 카드번호:
            <strong>
              <c:choose>
                <c:when test="${not empty info.card_number}">
                  ${info.card_number}
                </c:when>
                <c:otherwise>등록된 카드가 없습니다.</c:otherwise>
              </c:choose>
            </strong>
          </div>
        </form>
      </div>
    </c:forEach>
  </c:otherwise>
</c:choose>
