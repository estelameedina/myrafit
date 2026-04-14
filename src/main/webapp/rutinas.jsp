<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Rutina" %>
<%@ page import="dao.RutinaDAO" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());

    RutinaDAO rutinaDAO = new RutinaDAO();
    List<Rutina> rutinas = rutinaDAO.listarRutinas();

    String ok = request.getParameter("ok");
    String eliminada = request.getParameter("eliminada");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutinas | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">📋</span>
            <h2>Rutinas de entrenamiento</h2>
            <p class="subtitle">Consulta las rutinas disponibles y organiza tus sesiones de forma simple.</p>
        </div>

        <% if ("1".equals(ok)) { %>
            <div class="empty">Rutina guardada correctamente.</div>
        <% } %>

        <% if ("1".equals(eliminada)) { %>
            <div class="empty">Rutina eliminada correctamente.</div>
        <% } else if ("0".equals(eliminada)) { %>
            <div class="error">No se pudo eliminar la rutina.</div>
        <% } %>

        <% if (rutinas.isEmpty()) { %>
            <div class="empty">Todavia no hay rutinas registradas.</div>
        <% } else { %>
            <div class="rutinas-grid">
                <% for (Rutina rutina : rutinas) { %>
                    <div class="rutina-card">
                        <h3><%= rutina.getNombre() %></h3>
                        <p><strong>Objetivo:</strong> <%= rutina.getObjetivo() %></p>
                        <p><strong>Descripcion:</strong> <%= rutina.getDescripcion() != null && !rutina.getDescripcion().isEmpty() ? rutina.getDescripcion() : "Sin descripcion." %></p>
                        <div>
                            <span class="rutina-meta"><%= rutina.getNivel() %></span>
                            <span class="rutina-meta"><%= rutina.getDuracion() %> min</span>
                        </div>
                        <% if (esAdmin) { %>
                            <div class="menu">
                                <form action="eliminarRutina" method="post" onsubmit="return confirm('¿Seguro que quieres eliminar esta rutina?');">
                                    <input type="hidden" name="id" value="<%= rutina.getIdRutina() %>">
                                    <button type="submit" class="btn-link-danger">Eliminar</button>
                                </form>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>
        <% } %>

        <div class="menu">
            <a href="registrarRutina.jsp">Nueva rutina</a>
            <a href="dashboard.jsp">Volver al dashboard</a>
        </div>
    </div>

    <div class="sidebar">
        <div class="sidebar-brand"><span>Myra<em>Fit</em></span></div>
        <h3>Entrenamiento</h3>
        <a class="nav-item" href="dashboard.jsp"><span class="nav-icon">🏠</span> Resumen</a>
        <a class="nav-item" href="registrarEntrenamiento.jsp"><span class="nav-icon">➕</span> Registrar entreno</a>
        <a class="nav-item" href="historialEntrenamientos.jsp"><span class="nav-icon">📅</span> Historial</a>
        <a class="nav-item" href="registrarRutina.jsp"><span class="nav-icon">📝</span> Crear rutina</a>
        <a class="nav-item active" href="rutinas.jsp"><span class="nav-icon">📋</span> Mis rutinas</a>
        <h3>Hábitos</h3>
        <a class="nav-item" href="registrarHabito.jsp"><span class="nav-icon">✏️</span> Registrar hábitos</a>
        <a class="nav-item" href="historialHabitos.jsp"><span class="nav-icon">📊</span> Consultar hábitos</a>
        <h3>Ciclo menstrual</h3>
        <a class="nav-item" href="registrarCiclo.jsp"><span class="nav-icon">🌸</span> Registrar ciclo</a>
        <a class="nav-item" href="historialCiclo.jsp"><span class="nav-icon">🗓️</span> Historial del ciclo</a>
        <h3>Cuenta</h3>
        <a class="nav-item" href="perfil.jsp"><span class="nav-icon">👤</span> Mi perfil</a>
        <% if (esAdmin) { %><a class="nav-item" href="admin.jsp"><span class="nav-icon">⚙️</span> Administración</a><% } %>
    </div>
</div>
</body>
</html>
