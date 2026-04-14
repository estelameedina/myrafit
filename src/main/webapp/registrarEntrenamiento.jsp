<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Rutina" %>
<%@ page import="dao.RutinaDAO" %>
<%@ page import="java.util.List" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) { response.sendRedirect("login.jsp"); return; }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());
    String inicial = usuario.getNombre() != null && !usuario.getNombre().isEmpty()
            ? String.valueOf(usuario.getNombre().charAt(0)).toUpperCase() : "U";
    RutinaDAO rutinaDAO = new RutinaDAO();
    List<Rutina> rutinas = rutinaDAO.listarRutinas();
    String error = request.getParameter("error");
    String ok = request.getParameter("ok");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar entrenamiento | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">

    <!-- FORMULARIO -->
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">🏋️</span>
            <h2>Registrar entrenamiento</h2>
            <p class="subtitle">Guarda la información de tu sesión para llevar un seguimiento de tu actividad física.</p>
        </div>

        <% if ("1".equals(error)) { %>
            <div class="error">No se pudo guardar el entrenamiento. Revisa los datos e intentalo de nuevo.</div>
        <% } %>
        <% if ("1".equals(ok)) { %>
            <div class="empty">Entrenamiento guardado correctamente.</div>
        <% } %>

        <form action="guardarEntrenamiento" method="post">
            <div class="form-grid">

                <div class="form-group">
                    <label for="fecha">📅 Fecha</label>
                    <input id="fecha" type="date" name="fecha" required>
                </div>

                <div class="form-group">
                    <label for="duracion">⏱️ Duración (minutos)</label>
                    <input id="duracion" type="number" name="duracion" min="1" placeholder="45" required>
                </div>

                <div class="form-group form-group-full">
                    <label for="tipo">💪 Tipo de entrenamiento</label>
                    <input id="tipo" type="text" name="tipo" placeholder="Cardio, fuerza, yoga, HIIT..." required>
                </div>

                <div class="form-group form-group-full">
                    <label for="idRutina">📝 Rutina asociada</label>
                    <select id="idRutina" name="idRutina">
                        <option value="">Sin rutina</option>
                        <% for (Rutina rutina : rutinas) { %>
                            <option value="<%= rutina.getIdRutina() %>"><%= rutina.getNombre() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group form-group-full">
                    <label for="notas">📝 Notas (opcional)</label>
                    <textarea id="notas" name="notas" placeholder="¿Cómo te sentiste? ¿Algún logro destacado?"></textarea>
                </div>

            </div>

            <button type="submit" class="btn-submit">Guardar entrenamiento</button>
        </form>

        <a class="volver" href="dashboard.jsp">← Volver al dashboard</a>
    </div>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-brand"><span>Myra<em>Fit</em></span></div>
        <h3>Entrenamiento</h3>
        <a class="nav-item" href="dashboard.jsp"><span class="nav-icon">🏠</span> Resumen</a>
        <a class="nav-item active" href="registrarEntrenamiento.jsp"><span class="nav-icon">➕</span> Registrar entreno</a>
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
        <a class="nav-item" href="perfil.jsp"><span class="nav-icon">👤</span> Mi perfil</a>
        <% if (esAdmin) { %><a class="nav-item" href="admin.jsp"><span class="nav-icon">⚙️</span> Administración</a><% } %>
    </div>

</div>
</body>
</html>