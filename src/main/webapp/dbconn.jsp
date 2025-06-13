<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context, javax.naming.InitialContext" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%
	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/MovitDB");
		pageContext.setAttribute("ds", ds);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>