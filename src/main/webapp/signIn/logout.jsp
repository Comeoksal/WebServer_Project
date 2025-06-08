<%@ page contentType="text/html; charset=utf-8" %>
<%
  session.invalidate();  // 세션 삭제
  response.sendRedirect(request.getContextPath() + "/home.jsp");  // 헤더 페이지로 이동
%>