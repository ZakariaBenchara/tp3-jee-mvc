# Réponses aux questions du TP 3

### Question 1 : Pourquoi utilise-t-on un forward quand le login échoue, mais un sendRedirect quand il réussit ?

Le forward permet de conserver l'objet `HttpServletRequest`. Ainsi, on garde le message d'erreur et le login saisi pour ré-afficher dynamiquement la page `login.jsp` sans forcer l'utilisateur à tout resaisir.

Le redirect demande au navigateur d'effectuer une nouvelle requête HTTP GET vers `/dashboard`. Cela modifie l'URL du navigateur et évite le réenvoi du formulaire si l'utilisateur rafraîchit la page.

### Question 2 : Que se passe-t-il si l'utilisateur appuie sur F5 juste après avoir ajouté un produit ?
* **(a) Si doPost fait un forward :** L'URL affichée reste celle du formulaire POST. L'appui sur F5 ré-exécute la dernière requête POST et crée ainsi le même produit une seconde fois.
* **(b) Si doPost fait un redirect :** La requête POST est terminée et le navigateur effectue un GET sur `/produits`. L'appui sur F5 rafraîchit la requête GET sans ré-exécuter l'ajout du produit.
* **Nom du pattern :** Ce pattern s'appelle le pattern **PRG (Post / Redirect / Get)**.

### Question 3 : Saisissez comme nom de produit `<script>alert('XSS')</script>`.
* **Avec `${produit.nom}` :** La chaîne est injectée brute dans le DOM et le navigateur exécute le script (faille XSS stockée).
* **Avec `<c:out value="${produit.nom}"/>` :** Les caractères d'injection HTML (`<`, `>`, `&`, `"`) sont automatiquement échappés en entités HTML (`&lt;script&gt;...`). Le code est affiché comme texte brut et n'est pas exécuté.

C'est pour ça qu'on utilise `<c:out>` pour éviter les attaques XSS.

### Question 4 : Quel est l'avantage du filtre par rapport à la vérification dans chaque servlet ? Citez deux autres usages classiques.
* **Avantage :** Centraliser et factoriser la logique de contrôle d'accès dans une seule composante. Cela élimine le risque d'oubli de protection sur une nouvelle Servlet.
* **Deux usages classiques :**
  1. Encodage uniforme des caractères.
  2. Journalisation et audit des requêtes.