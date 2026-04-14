<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Rutina" %>
<%@ page import="dao.UsuarioDAO" %>
<%@ page import="dao.RutinaDAO" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

    if (usuarioSesion == null || !"admin@myrafit.com".equalsIgnoreCase(usuarioSesion.getEmail())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    UsuarioDAO usuarioDAO = new UsuarioDAO();
    RutinaDAO rutinaDAO = new RutinaDAO();

    List<Usuario> usuarios = usuarioDAO.listarUsuarios();
    List<Rutina> rutinas = rutinaDAO.listarRutinas();

    String eliminado = request.getParameter("eliminado");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de administracion | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body>
<div class="table-card">
    <h2>Panel de administracion</h2>
    <p class="subtitle">Desde aqui puedes gestionar los usuarios registrados y las rutinas de entrenamiento.</p>

    <% if ("1".equals(eliminado)) { %>
        <div class="empty">Elemento eliminado correctamente.</div>
    <% } else if ("0".equals(eliminado)) { %>
        <div class="error">No se pudo completar la eliminacion.</div>
    <% } %>

    <h3>Usuarios registrados</h3>

    <% if (usuarios.isEmpty()) { %>
        <div class="empty">No hay usuarios registrados.</div>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody>
                <% for (Usuario usuario : usuarios) { %>
                    <tr>
                        <td><%= usuario.getIdUsuario() %></td>
                        <td><%= usuario.getNombre() %></td>
                        <td><%= usuario.getEmail() %></td>
                        <td>
                            <% if (!"admin@myrafit.com".equalsIgnoreCase(usuario.getEmail())) { %>
                                <form action="eliminarUsuario" method="post" onsubmit="return confirm('¿Seguro que quieres eliminar este usuario?');" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= usuario.getIdUsuario() %>">
                                    <button type="submit" class="btn-link-danger">Eliminar</button>
                                </form>
                            <% } else { %>
                                Administrador
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <h3 style="margin-top: 32px;">Rutinas registradas</h3>

    <% if (rutinas.isEmpty()) { %>
        <div class="empty">No hay rutinas registradas.</div>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Objetivo</th>
                    <th>Nivel</th>
                    <th>Duracion</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody>
                <% for (Rutina rutina : rutinas) { %>
                    <tr>
                        <td><%= rutina.getIdRutina() %></td>
                        <td><%= rutina.getNombre() %></td>
                        <td><%= rutina.getObjetivo() %></td>
                        <td><%= rutina.getNivel() %></td>
                        <td><%= rutina.getDuracion() %> min</td>
                        <td>
                            <form action="eliminarRutina" method="post" onsubmit="return confirm('¿Seguro que quieres eliminar esta rutina?');" style="display:inline;">
                                <input type="hidden" name="id" value="<%= rutina.getIdRutina() %>">
                                <button type="submit" class="btn-link-danger">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <div class="menu">
        <a href="registrarRutina.jsp">Nueva rutina</a>
        <a href="rutinas.jsp">Ver rutinas</a>
        <a href="dashboard.jsp">Volver al dashboard</a>
    </div>
</div>
</body>
</html>
