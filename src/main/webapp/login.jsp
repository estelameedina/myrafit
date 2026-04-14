<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Acceso | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>

<body class="login-body">

<div class="login-container">

    <div class="login-card">
        <h1>MyraFit</h1>
        <p class="subtitle">
            Accede para gestionar tu entrenamiento, hábitos y bienestar diario
        </p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post" class="login-form">

            <div class="form-group">
                <label for="email">Correo electrónico</label>
                <input id="email" type="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Contraseña</label>
                <input id="password" type="password" name="password" required>
            </div>

            <button type="submit" class="btn-primary">Entrar</button>

        </form>

        <div class="link">
            No tienes cuenta? <a href="registro.jsp">Crear cuenta</a>
        </div>
    </div>

</div>

</body>
</html>