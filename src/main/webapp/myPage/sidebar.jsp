<%@ page contentType="text/html; charset=utf-8" %>
<%
  String uri = request.getRequestURI();
%>
<style>
.sidebar ul li a {
  text-decoration: none;
  color: black;
  font-weight: bold;
}

.sidebar ul li a.active {
  color: #5D9CEC;
}

</style>
<div class="sidebar">
  <ul>
    <li><a href="info.jsp" class="<%= uri.contains("info.jsp") ? "active" : "" %>">내 정보</a></li>
    <li><a href="membership.jsp" class="<%= uri.contains("membership.jsp") ? "active" : "" %>">멤버십</a></li>
    <li><a href="language.jsp" class="<%= uri.contains("language.jsp") ? "active" : "" %>">언어 설정</a></li>
    <li><a href="security.jsp" class="<%= uri.contains("security.jsp") ? "active" : "" %>">보안</a></li>
  </ul>
  <button onclick="history.back()">돌아가기</button>
</div>
