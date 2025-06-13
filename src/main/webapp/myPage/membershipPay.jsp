<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../dbconn.jsp"%>
<%@ page session="true"%>

<%
    String userEmail = (String) session.getAttribute("user_email");
   
    int planId = Integer.parseInt(request.getParameter("membership_id"));
    pageContext.setAttribute("userEmail", userEmail);
    pageContext.setAttribute("planId", planId);
%>

<sql:query dataSource="${ds}" var="userInfo">
    SELECT card_number FROM user WHERE email = ?
    <sql:param value="${userEmail}" />
</sql:query>

<sql:query dataSource="${ds}" var="planInfo">
    SELECT name, price FROM membership WHERE id = ?
    <sql:param value="${planId}" />
</sql:query>
<style>
body {
    margin: 0;
    padding: 0;
    background-color: #4f82c0; /* 배경은 이미지처럼 파란색 */
    font-family: 'Malgun Gothic', '돋움', sans-serif;
}

.pay-container {
    width: 360px;
    margin: 80px auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 2px;
    border: 1px solid #ccc;
    box-shadow: none;
}

.pay-container h2 {
    font-size: 16px;
    margin-bottom: 15px;
    color: #333;
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 10px;
}

.info-line {
    font-size: 13px;
    background-color: #f7f7f7;
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 15px;
    color: #444;
}

label {
    display: block;
    font-size: 13px;
    margin-bottom: 4px;
    color: #222;
}

input[type="text"],
input[type="password"],
select {
    width: 100%;
    padding: 7px;
    font-size: 13px;
    border: 1px solid #aaa;
    background-color: #fff;
    margin-bottom: 15px;
    box-sizing: border-box;
}

select {
    background-color: #fff;
}

button {
    width: 100%;
    padding: 10px;
    background-color: #2c68bc;
    color: white;
    font-size: 13px;
    font-weight: bold;
    border: none;
    margin-bottom: 8px;
    cursor: pointer;
}

button:hover {
    background-color: #215599;
}

button[type="button"] {
    background-color: #e4e4e4;
    color: #222;
    border: 1px solid #bbb;
}

button[type="button"]:hover {
    background-color: #d0d0d0;
}
</style>



<div class="pay-container">
    <h2>결제 정보 입력</h2>
    <div class="info-line">
        선택한 멤버십: <strong>${planInfo.rows[0].name}</strong><br>
        결제 금액: <strong>${planInfo.rows[0].price}원</strong>
    </div>

    <form method="post" action="processPayment.jsp" onsubmit="return validateForm(event)">
        <input type="hidden" name="membership_id" value="${param.membership_id}" />

        <label>카드번호</label>
        <input type="text" name="card_number"
               value="${userInfo.rows[0].card_number}"
               pattern="\d{16}" title="16자리 숫자" required />

        <label>은행 선택</label>
        <select name="bank" required>
            <option value="">은행을 선택하세요</option>
            <option value="국민은행">국민은행</option>
            <option value="신한은행">신한은행</option>
            <option value="우리은행">우리은행</option>
            <option value="하나은행">하나은행</option>
            <option value="농협은행">농협은행</option>
            <option value="카카오뱅크">카카오뱅크</option>
            <option value="토스뱅크">토스뱅크</option>
        </select>

        <label>비밀번호 확인</label>
        <input type="password" name="password" placeholder="비밀번호를 입력하세요" required />

        <button type="submit">결제하기</button>
        <button type="button" onclick="window.location.href='membership.jsp'">돌아가기</button>
    </form>
</div>


<script>
function validateForm(event) {
  const card = document.querySelector('input[name="card_number"]').value;
  if (!/^\d{16}$/.test(card)) {
    alert("카드번호는 16자리 숫자여야 합니다.");
    event.preventDefault();
    return false;
  }
  return true;
}
</script>