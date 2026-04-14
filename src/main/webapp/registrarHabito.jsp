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
    <title>Registrar hábitos | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=30">
</head>
<body class="form-body">
<div class="form-layout">

    <!-- FORMULARIO -->
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">🌿</span>
            <h2>Registrar hábitos</h2>
            <p class="subtitle">Anota tu sueño, tus pasos, el agua consumida y tu nivel de energía diario.</p>
        </div>

        <% if ("1".equals(error)) { %>
            <div class="error">No se pudo guardar el habito. Revisa los datos e intentalo de nuevo.</div>
        <% } %>
        <% if ("1".equals(ok)) { %>
            <div class="empty">Habito guardado correctamente.</div>
        <% } %>

        <form action="guardarHabito" method="post">
            <div class="form-grid">

                <div class="form-group form-group-full">
                    <label for="fecha">📅 Fecha</label>
                    <input id="fecha" type="date" name="fecha" required>
                </div>

                <div class="form-group">
                    <label for="sueno">😴 Horas de sueño</label>
                    <input id="sueno" type="number" step="0.5" name="sueno" min="0" max="24" placeholder="7.5" required>
                </div>

                <div class="form-group">
                    <label for="pasos">👟 Pasos</label>
                    <input id="pasos" type="number" name="pasos" min="0" placeholder="8000" required>
                </div>

                <div class="form-group">
                    <label for="agua">💧 Agua (litros)</label>
                    <input id="agua" type="number" step="0.1" name="agua" min="0" placeholder="1.5" required>
                </div>

                <!-- ENERGÍA SLIDER -->
                <div class="form-group">
                    <label for="energia">⚡ Nivel de energía</label>
                    <input id="energia" type="range" name="energia"
                           min="1" max="10" value="5"
                           class="energia-slider"
                           oninput="actualizarEnergia(this.value)">
                    <div class="energia-display">
                        <span class="energia-valor" id="energiaValor">5</span>
                        <span class="energia-emoji" id="energiaEmoji">😐</span>
                    </div>
                </div>

            </div>

            <button type="submit" class="btn-submit">Guardar hábitos</button>
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
        <a class="nav-item active" href="registrarHabito.jsp"><span class="nav-icon">✏️</span> Registrar hábitos</a>
        <a class="nav-item" href="historialHabitos.jsp"><span class="nav-icon">📊</span> Consultar hábitos</a>
        <h3>Ciclo menstrual</h3>
        <a class="nav-item" href="registrarCiclo.jsp"><span class="nav-icon">🌸</span> Registrar ciclo</a>
        <a class="nav-item" href="historialCiclo.jsp"><span class="nav-icon">🗓️</span> Historial del ciclo</a>
        <h3>Cuenta</h3>
        <a class="nav-item" href="perfil.jsp"><span class="nav-icon">👤</span> Mi perfil</a>
        <% if (esAdmin) { %><a class="nav-item" href="admin.jsp"><span class="nav-icon">⚙️</span> Administración</a><% } %>
    </div>

</div>

<script>
    const emojis = ['','😩','😔','😕','😐','🙂','😊','😄','💪','🔥','⚡'];
    function actualizarEnergia(val) {
        document.getElementById('energiaValor').textContent = val;
        document.getElementById('energiaEmoji').textContent = emojis[parseInt(val)];
    }
</script>
</body>
</html>