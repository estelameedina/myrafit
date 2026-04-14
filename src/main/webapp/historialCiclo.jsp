<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.CicloMenstrual" %>
<%@ page import="dao.CicloMenstrualDAO" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());

    CicloMenstrualDAO cicloDAO = new CicloMenstrualDAO();
    List<CicloMenstrual> ciclos = cicloDAO.listarCiclosPorUsuario(usuario.getIdUsuario());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial del ciclo | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">🗓️</span>
            <h2>Historial del ciclo menstrual</h2>
            <p class="subtitle">Consulta las fases y anotaciones que has registrado.</p>
        </div>

        <% if (ciclos.isEmpty()) { %>
            <div class="empty">Todavia no has registrado informacion del ciclo.</div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Fase</th>
                        <th>Notas</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CicloMenstrual c : ciclos) { %>
                        <tr>
                            <td><%= c.getFecha() %></td>
                            <td><%= c.getFase() %></td>
                            <td><%= c.getNotas() != null ? c.getNotas() : "" %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <div class="menu">
            <a href="registrarCiclo.jsp">Nuevo registro de ciclo</a>
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
        <a class="nav-item" href="historialHabitos.jsp"><span class="nav-icon">📊</span> Consultar hábitos</a>
        <h3>Ciclo menstrual</h3>
        <a class="nav-item" href="registrarCiclo.jsp"><span class="nav-icon">🌸</span> Registrar ciclo</a>
        <a class="nav-item active" href="historialCiclo.jsp"><span class="nav-icon">🗓️</span> Historial del ciclo</a>
        <h3>Cuenta</h3>
        <a class="nav-item" href="perfil.jsp"><span class="nav-icon">👤</span> Mi perfil</a>
        <% if (esAdmin) { %><a class="nav-item" href="admin.jsp"><span class="nav-icon">⚙️</span> Administración</a><% } %>
    </div>
</div>
</body>
</html>
