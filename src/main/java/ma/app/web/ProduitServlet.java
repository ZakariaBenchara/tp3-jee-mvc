package ma.app.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.app.model.Produit;
import ma.app.model.ProduitDAO;

@WebServlet("/produits")
public class ProduitServlet extends HttpServlet {

    private ProduitDAO dao;

    @Override
    public void init() {
        dao = (ProduitDAO) getServletContext().getAttribute("produitDAO");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String action = req.getParameter("action");

        if ("new".equals(action)) {
            req.setAttribute("produit", new Produit());
            req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            String idStr = req.getParameter("id");
            try {
                Long id = Long.parseLong(idStr);
                Produit p = dao.findById(id);
                if (p == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Produit non trouve");
                    return;
                }
                req.setAttribute("produit", p);
                req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "ID invalide");
            }
        } else {
        	String q = req.getParameter("q");
        	if(q != null && !q.trim().isEmpty()) {
        		req.setAttribute("produits", dao.searchByName(q));
                req.setAttribute("q", q.trim());
        	}else {
        		req.setAttribute("produits", dao.findAll());        		
        	}
            req.getRequestDispatcher("/WEB-INF/views/produits/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            try {
                Long id = Long.parseLong(req.getParameter("id"));
                Produit p = dao.findById(id);
                if (p != null) {
                    dao.delete(id);
                    req.getSession().setAttribute("flash", "Produit « " + p.getNom() + " » supprime.");
                }
            } catch (NumberFormatException ignored) {}
            resp.sendRedirect(req.getContextPath() + "/produits");
            return;
        }

        String idStr = req.getParameter("id");
        String nom = req.getParameter("nom");
        String description = req.getParameter("description");
        String prixStr = req.getParameter("prix");
        String stockStr = req.getParameter("stock");

        Map<String, String> erreurs = new HashMap<>();

        if (nom == null || nom.trim().length() < 2 || nom.trim().length() > 50) {
            erreurs.put("nom", "Le nom doit comporter entre 2 et 50 caracteres.");
        }

        BigDecimal prix = null;
        if (prixStr == null || prixStr.trim().isEmpty()) {
            erreurs.put("prix", "Le prix est obligatoire.");
        } else {
            try {
                prix = new BigDecimal(prixStr.trim());
                if (prix.compareTo(BigDecimal.ZERO) <= 0) {
                    erreurs.put("prix", "Le prix doit etre strictement positif.");
                }
            } catch (NumberFormatException e) {
                erreurs.put("prix", "Format du prix invalide.");
            }
        }

        int stock = 0;
        if (stockStr != null && !stockStr.trim().isEmpty()) {
            try {
                stock = Integer.parseInt(stockStr.trim());
                if (stock < 0) {
                    erreurs.put("stock", "Le stock doit etre supérieur ou egal a 0.");
                }
            } catch (NumberFormatException e) {
                erreurs.put("stock", "Format du stock invalide.");
            }
        }

        if (description != null && description.length() > 255) {
            erreurs.put("description", "La description ne doit pas depasser 255 caracteres.");
        }

        Long id = null;
        if (idStr != null && !idStr.trim().isEmpty()) {
            try { id = Long.parseLong(idStr.trim()); } catch (NumberFormatException ignored) {}
        }

        Produit p = new Produit(id, nom, description, prix, stock);

        if (!erreurs.isEmpty()) {
            req.setAttribute("erreurs", erreurs);
            req.setAttribute("produit", p);
            req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp").forward(req, resp);
        } else {
            dao.save(p);
            String message = (id == null) ? 
                "Produit « " + nom + " » enregistre." : 
                "Produit « " + nom + " » modifie.";
            req.getSession().setAttribute("flash", message);
            resp.sendRedirect(req.getContextPath() + "/produits");
        }
    }
}