<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="login-body">
<div class="login-container">
    <div class="login-card">
        <h1>Crear cuenta</h1>
        <p class="subtitle">
            Empieza a registrar tu actividad, tus habitos y tu bienestar en un solo lugar.
        </p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/registro" method="post" class="login-form">
            <div class="form-group">
                <label for="nombre">Nombre</label>
                <input id="nombre" type="text" name="nombre" required>
            </div>

            <div class="form-group">
                <label for="email">Correo electronico</label>
                <input id="email" type="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Contrasena</label>
                <input id="password" type="password" name="password" required>
            </div>

            <button type="submit" class="btn-primary">Crear cuenta</button>
        </form>

        <div class="link">
            Ya tienes cuenta?
            <a href="${pageContext.request.contextPath}/login.jsp">Iniciar sesion</a>
        </div>
    </div>
</div>
</body>
</html>