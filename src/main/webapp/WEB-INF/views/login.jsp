<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/header.jsp">
    <jsp:param name="title" value="Connexion"/>
</jsp:include>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Connexion</title>
</head>
<body>
	<h1>Connexion</h1>
	
	<c:if test="${not empty erreur}">
		<p style="color:red;"> <c:out value="${erreur}"/> </p>
	</c:if>
	
	<form method="post" action="${ctx}/login">
		<label for="username">Nom:</label>
		<input type="text" id="username" name="username" value="<c:out value='${username}'/>" required>
		<br><br>
		<label for="password">Mot de passe :</label><br>
        <input type="password" id="password" name="password" required>
        <br><br>
        <button type="submit">Se connecter</button>
	</form>
</body>
</html>