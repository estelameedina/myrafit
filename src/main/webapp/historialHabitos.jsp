<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Habito" %>
<%@ page import="dao.HabitoDAO" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());

    HabitoDAO habitoDAO = new HabitoDAO();
    List<Habito> habitos = habitoDAO.listarHabitosPorUsuario(usuario.getIdUsuario());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de habitos | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">📊</span>
            <h2>Historial de habitos</h2>
            <p class="subtitle">Consulta los datos diarios de bienestar que has registrado.</p>
        </div>

        <% if (habitos.isEmpty()) { %>
            <div class="empty">Todavia no has registrado habitos.</div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Sueno</th>
                        <th>Pasos</th>
                        <th>Agua</th>
                        <th>Energia</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Habito h : habitos) { %>
                        <tr>
                            <td><%= h.getFecha() %></td>
                            <td><%= h.getHorasSueno() %> h</td>
                            <td><%= h.getPasos() %></td>
                            <td><%= h.getAgua() %> L</td>
                            <td><%= h.getEnergia() %>/10</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <div class="menu">
            <a href="registrarHabito.jsp">Nuevo habito</a>
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
        <a class="nav-item" href="rutinas.jsp"><span class="nav-icon">📋</span> Mis rutinas</a>
        <h3>Hábitos</h3>
        <a class="nav-item" href="registrarHabito.jsp"><span class="nav-icon">✏️</span> Registrar hábitos</a>
        <a class="nav-item active" href="historialHabitos.jsp"><span class="nav-icon">📊</span> Consultar hábitos</a>
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
