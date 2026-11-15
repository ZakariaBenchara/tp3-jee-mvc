package ma.app.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

public class ProduitDAO {
    private final Map<Long, Produit> produits = new ConcurrentHashMap<>();
    private final AtomicLong sequence = new AtomicLong(0);
 
    public ProduitDAO() {
    	save(new Produit(null,"Laptob","Dell XPS 13", new BigDecimal("9500.00"), 5));
    	save(new Produit(null,"Souris","Logitech MX Master", new BigDecimal("650.00"),20));

    }
 
    public List<Produit> findAll() {
    	List<Produit> list = new ArrayList<>(produits.values());
    	list.sort(Comparator.comparing(Produit::getId));
    	return list;
    }
    
    public Produit findById(Long id) {
    	if(id == null) return null;
    	return produits.get(id);
    }
    
    public void save(Produit p) {
    	if(p.getId() == null) {
    		p.setId(sequence.incrementAndGet());
    	}
    	produits.put(p.getId(), p);
    }
    public void delete(Long id) {
    	if(id != null) {
    		produits.remove(id);
    	}
    }
    
    public List<Produit> searchByName(String query) {
        if (query == null || query.trim().isEmpty()) {
            return findAll();
        }
        String lowerQuery = query.trim().toLowerCase();
        List<Produit> result = new ArrayList<>();
        for (Produit p : findAll()) {
            if (p.getNom() != null && p.getNom().toLowerCase().contains(lowerQuery)) {
                result.add(p);
            }
        }
        return result;
    }
}