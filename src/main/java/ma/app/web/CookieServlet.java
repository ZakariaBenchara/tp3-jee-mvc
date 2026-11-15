package ma.app.web;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cookies")
public class CookieServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
		
		String action = req.getParameter("action");
		String themeValue = "set".equals(action) ? "dark" : "light";
		
		Cookie cookie = new Cookie("theme", themeValue);
		cookie.setMaxAge(30 * 24 * 60 * 60);
		cookie.setPath("/");
		resp.addCookie(cookie);		
		
		String referer = req.getHeader("Referer");
		resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/dashboard");
	}
}
