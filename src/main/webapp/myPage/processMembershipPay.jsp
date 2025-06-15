<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.net.URLEncoder" %>

<%
	request.setCharacterEncoding("utf-8");

	String membershipId = request.getParameter("membership_id");
	String cardNumber = request.getParameter("card_number");
	String bank = request.getParameter("bank");
	String password = request.getParameter("password");

	int maxAge = 60 * 60 * 12;

	Cookie cookie1 = new Cookie("membership_id", URLEncoder.encode(membershipId, "utf-8"));
	cookie1.setPath("/");
	cookie1.setMaxAge(maxAge);
	response.addCookie(cookie1);

	Cookie cookie2 = new Cookie("card_number", URLEncoder.encode(cardNumber, "utf-8"));
	cookie2.setPath("/");
	cookie2.setMaxAge(maxAge);
	response.addCookie(cookie2);

	Cookie cookie3 = new Cookie("bank", URLEncoder.encode(bank, "utf-8"));
	cookie3.setPath("/");
	cookie3.setMaxAge(maxAge);
	response.addCookie(cookie3);

	Cookie cookie4 = new Cookie("password", URLEncoder.encode(password, "utf-8"));
	cookie4.setPath("/");
	cookie4.setMaxAge(maxAge);
	response.addCookie(cookie4);

	response.sendRedirect("membershipPayConfirm.jsp");
	return;
%>