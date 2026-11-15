package ma.app;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSession;

@WebServlet("/succes")
public class SuccesServlet extends HttpServlet {
	@Override
	protected void doGet (HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		String utilisateur = (session != null) ? (String) session.getAttribute("utilisateur") : null;
		
		if(utilisateur == null) {
			resp.sendRedirect(req.getContextPath() + "/inscription");
			return;
		}
		
		resp.setContentType("text/html");
		resp.getWriter().println("<h1>Bienvenue " + utilisateur + "</h1>");
	}
}