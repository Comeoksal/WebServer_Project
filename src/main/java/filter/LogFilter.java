package filter;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class LogFilter implements Filter {
	private DataSource ds;

	public void init(FilterConfig config) throws ServletException{
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/MovitDB");
		} catch (Exception e) {
			throw new ServletException("connect db error", e);
		}
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException{
		HttpServletRequest req = (HttpServletRequest) request;
		Object userIdObj = req.getSession().getAttribute("userId");
		String userId = userIdObj != null ? userIdObj.toString() : "anonymous";
		String userIp = request.getRemoteAddr();
		String userURL = getURLPath(request);
		String userAgent = req.getHeader("User-Agent");
		long start = System.currentTimeMillis();
		
		chain.doFilter(request, response);
		
		long end = System.currentTimeMillis();
		long clearTime = end - start;
		Timestamp startTime = new Timestamp(start);
		
		try(Connection conn = ds.getConnection(); PreparedStatement ps = conn.prepareStatement("insert into log (user_id, ip, url, user_agent, start_time, clear_time) "
				+ "values (?, ?, ?, ?, ?, ?)")){
			ps.setString(1, userId);
			ps.setString(2, userIp);
			ps.setString(3, userURL);
			ps.setString(4, userAgent);
			ps.setTimestamp(5, startTime);
			ps.setInt(6, (int)clearTime);
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void destroy() {}
	
	private String getURLPath(ServletRequest request) {
		HttpServletRequest req;
		String currentPath="";
		String queryString ="";
		if(request instanceof HttpServletRequest) {
			req = (HttpServletRequest) request;
			currentPath = req.getRequestURI();
			queryString = req.getQueryString();
			queryString = queryString == null ? "" : "?" + queryString;
		}
		return currentPath + queryString;
	}
}
