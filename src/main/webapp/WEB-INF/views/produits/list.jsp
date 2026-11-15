<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/header.jsp">
    <jsp:param name="title" value="Produits"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Produits</title>
    <style>
        .flash { color: green; font-weight: bold; padding: 5px; border: 1px solid green; margin-bottom: 10px; }
        .out-of-stock { color: red; font-weight: bold; }
        table, th, td { border: 1px solid #ccc; border-collapse: collapse; padding: 8px; }
    </style>
</head>
<body>
    <h1>Catalogue de produits</h1>

    <c:if test="${not empty sessionScope.flash}">
        <div class="flash"><c:out value="${sessionScope.flash}"/></div>
        <c:remove var="flash" scope="session"/>
    </c:if>

    <p><a href="${ctx}/produits?action=new">Ajouter un produit</a></p>
        <form method="get" action="${ctx}/produits" style="margin-bottom: 15px;">
		    <input type="text" name="q" value="<c:out value='${q}'/>" placeholder="Rechercher par nom...">
		    <button type="submit">Rechercher</button>
		    <c:if test="${not empty q}">
		        <a href="${ctx}/produits">Réinitialiser</a>
		    </c:if>
		</form>

    <c:choose>
        <c:when test="${empty produits}">
            <p>Aucun produit</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Description</th>
                        <th>Prix</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${produits}">
                        <tr>
                            <td><c:out value="${p.nom}"/></td>
                            <td><c:out value="${p.description}"/></td>
                            <td><fmt:formatNumber value="${p.prix}" minFractionDigits="2" maxFractionDigits="2"/> DH</td>
                            <td class="${p.stock == 0 ? 'out-of-stock' : ''}">${p.stock}</td>
                            <td>
                                <a href="${ctx}/produits?action=edit&id=${p.id}">Éditer</a>
                                |
                                <form method="post" action="${ctx}/produits?action=delete" style="display:inline;" onsubmit="return confirm('Confirmer la suppression ?');">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button type="submit">Supprimer</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <br>
    <a href="${ctx}/dashboard">Retour au tableau de bord</a>
</body>
</html>