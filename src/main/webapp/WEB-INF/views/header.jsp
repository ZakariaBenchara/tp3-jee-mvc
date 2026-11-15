<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:out value="${param.title != null ? param.title : 'Mini-Site MVC'}"/></title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #ffffff; color: #222222; margin: 20px; }
        body.dark { background-color: #1e1e1e; color: #f1f1f1; }
        body.dark a { color: #66b2ff; }
        body.dark table, body.dark th, body.dark td { border-color: #555555; }
        .theme-bar { text-align: right; margin-bottom: 15px; }
        .error { color: #ff4d4d; font-size: 0.85em; }
        .flash { color: #2ecc71; font-weight: bold; padding: 8px; border: 1px solid #2ecc71; margin-bottom: 10px; }
        .out-of-stock { color: #ff4d4d; font-weight: bold; }
        table, th, td { border: 1px solid #ccc; border-collapse: collapse; padding: 8px; }
    </style>
</head>
<body class="${cookie.theme.value == 'dark' ? 'dark' : ''}">
    <div class="theme-bar">
        <c:choose>
            <c:when test="${cookie.theme.value == 'dark'}">
                <a href="${ctx}/cookies?action=light">Passer en mode clair</a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/cookies?action=set">Passer en mode sombre</a>
            </c:otherwise>
        </c:choose>
    </div>