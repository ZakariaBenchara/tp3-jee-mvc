<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/header.jsp">
    <jsp:param name="title" value="${empty produit.id ? 'Nouveau produit' : 'Modifier le produit'}"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty produit.id ? 'Nouveau produit' : 'Modifier le produit'}</title>
    <style>.error { color: red; font-size: 0.85em; }</style>
</head>
<body>
    <h1>${empty produit.id ? 'Nouveau produit' : 'Modifier le produit'}</h1>

    <form method="post" action="${ctx}/produits">
        <c:if test="${not empty produit.id}">
            <input type="hidden" name="id" value="${produit.id}">
        </c:if>

        <div>
            <label for="nom">Nom :</label><br>
            <input type="text" id="nom" name="nom" value="<c:out value='${produit.nom}'/>" required>
            <c:if test="${not empty erreurs.nom}">
                <div class="error"><c:out value="${erreurs.nom}"/></div>
            </c:if>
        </div><br>

        <div>
            <label for="description">Description :</label><br>
            <textarea id="description" name="description"><c:out value="${produit.description}"/></textarea>
            <c:if test="${not empty erreurs.description}">
                <div class="error"><c:out value="${erreurs.description}"/></div>
            </c:if>
        </div><br>

        <div>
            <label for="prix">Prix (DH) :</label><br>
            <input type="text" id="prix" name="prix" value="${produit.prix}" required>
            <c:if test="${not empty erreurs.prix}">
                <div class="error"><c:out value="${erreurs.prix}"/></div>
            </c:if>
        </div><br>

        <div>
            <label for="stock">Stock :</label><br>
            <input type="number" id="stock" name="stock" value="${produit.stock != null ? produit.stock : 0}" min="0">
            <c:if test="${not empty erreurs.stock}">
                <div class="error"><c:out value="${erreurs.stock}"/></div>
            </c:if>
        </div><br>

        <button type="submit">${empty produit.id ? 'Créer' : 'Enregistrer'}</button>
        <a href="${ctx}/produits">Annuler</a>
    </form>
</body>
</html>