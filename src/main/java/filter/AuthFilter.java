package filter;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AuthFilter implements Filter {
	private DataSource ds;
	
	public void init(FilterConfig config) throws ServletException{}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException{
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		HttpSession session = req.getSession(false);
		
		String role = (session !=null) ? (String) session.getAttribute("role") : null;
		String url = req.getRequestURI();
	    String contextPath = req.getContextPath();
	    String path = url.substring(contextPath.length());
		
		if((path.startsWith("/admin") && (role == null || !role.equals("admin")))){
			res.sendRedirect(req.getContextPath() + "/exceptionUnAuthorized.jsp");
			return;
		}
		
		chain.doFilter(request, response);
	}
	
	public void destroy() {}
}
