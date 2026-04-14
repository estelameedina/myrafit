<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi perfil | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">👤</span>
            <h2>Mi perfil</h2>
            <p class="subtitle">Actualiza tu informacion personal para mantener tu cuenta al dia.</p>
        </div>

        <% if (request.getAttribute("mensaje") != null) { %>
            <div class="empty"><%= request.getAttribute("mensaje") %></div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="perfil" method="post">
            <div class="form-grid">
                <div class="form-group form-group-full">
                    <label for="nombre">Nombre</label>
                    <input id="nombre" type="text" name="nombre" value="<%= usuario.getNombre() %>" required>
                </div>
                <div class="form-group form-group-full">
                    <label for="email">Email</label>
                    <input id="email" type="email" name="email" value="<%= usuario.getEmail() %>" required>
                </div>
            </div>
            <button type="submit" class="btn-submit">Guardar cambios</button>
        </form>

        <a class="volver" href="dashboard.jsp">← Volver al dashboard</a>
    </div>

    <div class="sidebar">
        <div class="sidebar-brand"><span>Myra<em>Fit</em></span></div>
        <h3>Entrenamiento</h3>
        <a class="nav-item" href="dashboard.jsp"><span class="nav-icon">🏠</span> Resumen</a>
        <a class="nav-item" href="registrarEntrenamiento.jsp"><span class="nav-icon">➕</span> Registrar entreno</a>
        <a class="nav-item" href="historialEntrenamientos.jsp"><span class="nav-icon">📅</span> Historial</a>
        <a class="nav-item" href="registrarRutina.jsp"><span class="nav-icon">📝</span> Crear rutina</a>
        <a class="nav-item" href="rutinas.jsp"><span class="nav-icon">📋</span> Mis rutinas</a>
        <h3>Hábitos</h3>
        <a class="nav-item" href="registrarHabito.jsp"><span class="nav-icon">✏️</span> Registrar hábitos</a>
        <a class="nav-item" href="historialHabitos.jsp"><span class="nav-icon">📊</span> Consultar hábitos</a>
        <h3>Ciclo menstrual</h3>
        <a class="nav-item" href="registrarCiclo.jsp"><span class="nav-icon">🌸</span> Registrar ciclo</a>
        <a class="nav-item" href="historialCiclo.jsp"><span class="nav-icon">🗓️</span> Historial del ciclo</a>
        <h3>Cuenta</h3>
        <a class="nav-item active" href="perfil.jsp"><span class="nav-icon">👤</span> Mi perfil</a>
        <% if (esAdmin) { %><a class="nav-item" href="admin.jsp"><span class="nav-icon">⚙️</span> Administración</a><% } %>
    </div>
</div>
</body>
</html>
