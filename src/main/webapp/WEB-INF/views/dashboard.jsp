<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/header.jsp">
    <jsp:param name="title" value="Tableau de bord"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tableau de board</title>
</head>
<body>
	<h1> Bienvenue ${user} </h1>
	<ul>
		<li> <a href="${ctx}/produits">Gérer les produis</a></li>
		<li> <a href="${ctx}/logout">Déconnexion</a></li>
	</ul>
</body>
</html>