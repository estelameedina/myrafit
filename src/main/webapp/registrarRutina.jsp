<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) { response.sendRedirect("login.jsp"); return; }
    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear rutina | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=22">
</head>
<body class="form-body">
<div class="form-layout">

    <!-- FORMULARIO -->
    <div class="form-card">
        <div class="form-card-header">
            <span class="form-icon">📋</span>
            <h2>Crear rutina</h2>
            <p class="subtitle">Diseña una rutina de entrenamiento para consultarla cuando la necesites.</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="guardarRutina" method="post">
            <div class="form-grid">

                <div class="form-group form-group-full">
                    <label for="nombre">✏️ Nombre de la rutina</label>
                    <input id="nombre" type="text" name="nombre" placeholder="Ej: Fuerza full body lunes" required>
                </div>

                <div class="form-group">
                    <label for="objetivo">🎯 Objetivo</label>
                    <input id="objetivo" type="text" name="objetivo" placeholder="Fuerza, resistencia, movilidad..." required>
                </div>

                <div class="form-group">
                    <label for="duracion">⏱️ Duración estimada (min)</label>
                    <input id="duracion" type="number" name="duracion" min="1" placeholder="45" required>
                </div>

                <!-- NIVEL COMO PILLS -->
                <div class="form-group form-group-full">
                    <label>📶 Nivel</label>
                    <div class="nivel-grid">

                        <div class="nivel-option">
                            <input type="radio" id="principiante" name="nivel" value="Principiante" required>
                            <label class="nivel-label" for="principiante">
                                <span class="nivel-emoji">🌱</span>
                                <span>Principiante</span>
                            </label>
                        </div>

                        <div class="nivel-option">
                            <input type="radio" id="intermedio" name="nivel" value="Intermedio">
                            <label class="nivel-label" for="intermedio">
                                <span class="nivel-emoji">💪</span>
                                <span>Intermedio</span>
                            </label>
                        </div>

                        <div class="nivel-option">
                            <input type="radio" id="avanzado" name="nivel" value="Avanzado">
                            <label class="nivel-label" for="avanzado">
                                <span class="nivel-emoji">🔥</span>
                                <span>Avanzado</span>
                            </label>
                        </div>

                    </div>
                </div>

                <div class="form-group form-group-full">
                    <label for="descripcion">📝 Descripción (opcional)</label>
                    <textarea id="descripcion" name="descripcion" placeholder="Describe brevemente la rutina, ejercicios o enfoque general."></textarea>
                </div>

            </div>

            <button type="submit" class="btn-submit">Guardar rutina</button>
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
        <a class="nav-item active" href="registrarRutina.jsp"><span class="nav-icon">📝</span> Crear rutina</a>
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