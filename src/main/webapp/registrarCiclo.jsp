<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) { response.sendRedirect("login.jsp"); return; }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());
    String error = request.getParameter("error");
    String ok = request.getParameter("ok");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar ciclo | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">

    <!-- FORMULARIO -->
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">🌸</span>
            <h2>Registrar ciclo menstrual</h2>
            <p class="subtitle">Anota la fase en la que te encuentras para relacionarla con tu bienestar y rendimiento.</p>
        </div>

        <% if ("1".equals(error)) { %>
            <div class="error">No se pudo guardar el ciclo. Revisa los datos e intentalo de nuevo.</div>
        <% } %>
        <% if ("1".equals(ok)) { %>
            <div class="empty">Registro de ciclo guardado correctamente.</div>
        <% } %>

        <form action="guardarCiclo" method="post">
            <div class="form-grid">

                <div class="form-group form-group-full">
                    <label for="fecha">📅 Fecha</label>
                    <input id="fecha" type="date" name="fecha" required>
                </div>

                <!-- FASE COMO TARJETAS -->
                <div class="form-group form-group-full">
                    <label>🔄 Fase del ciclo</label>
                    <div class="fase-grid">

                        <div class="fase-option">
                            <input type="radio" id="menstrual" name="fase" value="Menstrual" required>
                            <label class="fase-label" for="menstrual">
                                <span class="fase-emoji">🔴</span>
                                <span class="fase-name">Menstrual</span>
                                <span class="fase-desc">Días 1–5</span>
                            </label>
                        </div>

                        <div class="fase-option">
                            <input type="radio" id="folicular" name="fase" value="Folicular">
                            <label class="fase-label" for="folicular">
                                <span class="fase-emoji">🌱</span>
                                <span class="fase-name">Folicular</span>
                                <span class="fase-desc">Días 6–13</span>
                            </label>
                        </div>

                        <div class="fase-option">
                            <input type="radio" id="ovulacion" name="fase" value="Ovulacion">
                            <label class="fase-label" for="ovulacion">
                                <span class="fase-emoji">⭐</span>
                                <span class="fase-name">Ovulación</span>
                                <span class="fase-desc">Día 14</span>
                            </label>
                        </div>

                        <div class="fase-option">
                            <input type="radio" id="lutea" name="fase" value="Lutea">
                            <label class="fase-label" for="lutea">
                                <span class="fase-emoji">🌙</span>
                                <span class="fase-name">Lútea</span>
                                <span class="fase-desc">Días 15–28</span>
                            </label>
                        </div>

                    </div>
                </div>

                <div class="form-group form-group-full">
                    <label for="notas">📝 Notas (opcional)</label>
                    <textarea id="notas" name="notas" placeholder="¿Cómo te encuentras hoy? Síntomas, energía, estado de ánimo..."></textarea>
                </div>

            </div>

            <button type="submit" class="btn-submit">Guardar ciclo</button>
        </form>

        <a class="volver" href="dashboard.jsp">← Volver al dashboard</a>
    </div>

    <!-- SIDEBAR -->
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
        <a class="nav-item active" href="registrarCiclo.jsp"><span class="nav-icon">🌸</span> Registrar ciclo</a>
        <a class="nav-item" href="historialCiclo.jsp"><span class="nav-icon">🗓️</span> Historial del ciclo</a>
        <h3>Cuenta</h3>
        <a class="nav-item" href="perfil.jsp"><span class="nav-icon">👤</span> Mi perfil</a>
        <% if (esAdmin) { %><a class="nav-item" href="admin.jsp"><span class="nav-icon">⚙️</span> Administración</a><% } %>
    </div>

</div>
</body>
</html>