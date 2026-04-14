<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="dao.EntrenamientoDAO" %>
<%@ page import="dao.HabitoDAO" %>
<%@ page import="dao.CicloMenstrualDAO" %>
<%@ page import="model.Habito" %>
<%@ page import="java.util.List" %>

<%
    // ================= CONTROL DE SESIÓN =================
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) { response.sendRedirect("login.jsp"); return; }

    boolean esAdmin = "admin@myrafit.com".equalsIgnoreCase(usuario.getEmail());

    // ================= MENSAJES TOAST =================
    String toastMsg = (String) session.getAttribute("toastMsg");
    String toastType = (String) session.getAttribute("toastType");
    session.removeAttribute("toastMsg");
    session.removeAttribute("toastType");

    // ================= DAOS =================
    EntrenamientoDAO entDAO = new EntrenamientoDAO();
    HabitoDAO habDAO     = new HabitoDAO();
    CicloMenstrualDAO cicloDAO = new CicloMenstrualDAO();

    int totalEntrenamientos = 0;
    double mediaSueno  = 0;
    double mediaPasos  = 0;
    String ultimaFase  = "Sin datos";
    List<Habito> habitosUltimos7 = java.util.Collections.emptyList();
    List<String> fechasEntrenoMes = java.util.Collections.emptyList();

    try {
        totalEntrenamientos = entDAO.contarEntrenamientos(usuario.getIdUsuario());
        mediaSueno  = habDAO.mediaSueno(usuario.getIdUsuario());
        mediaPasos  = habDAO.mediaPasos(usuario.getIdUsuario());
        habitosUltimos7 = habDAO.listarUltimos7HabitosPorUsuario(usuario.getIdUsuario());
        fechasEntrenoMes = entDAO.listarFechasEntrenamientoMesActual(usuario.getIdUsuario());
        ultimaFase  = cicloDAO.ultimaFase(usuario.getIdUsuario());
        if (ultimaFase == null || ultimaFase.isEmpty()) ultimaFase = "Sin datos";
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error al cargar los datos del dashboard</p>");
    }

    // ================= COLOR Y EMOJI FASE =================
    String colorFase = "#f6f0f2";
    String emojiFase = "🌸";

    if      ("Menstrual".equalsIgnoreCase(ultimaFase))  { colorFase = "#f8c7cf"; emojiFase = "🔴"; }
    else if ("Folicular".equalsIgnoreCase(ultimaFase))  { colorFase = "#dff0c8"; emojiFase = "🌱"; }
    else if ("Ovulacion".equalsIgnoreCase(ultimaFase))  { colorFase = "#f9e0b8"; emojiFase = "⭐"; }
    else if ("Lutea".equalsIgnoreCase(ultimaFase))      { colorFase = "#eadcf8"; emojiFase = "🌙"; }

    // ================= MENSAJE Y EMOJI REC =================
    String mensaje;
    String iconoRec;

    switch (ultimaFase) {
        case "Menstrual":
            mensaje  = "Reduce la intensidad del entrenamiento y prioriza el descanso y la recuperación.";
            iconoRec = "💆";
            break;
        case "Folicular":
            mensaje  = "Fase ideal para entrenamientos de mayor intensidad y progresión de cargas.";
            iconoRec = "💪";
            break;
        case "Ovulacion":
            mensaje  = "Momento de máximo rendimiento físico. ¡Aprovecha tu energía al máximo!";
            iconoRec = "🚀";
            break;
        case "Lutea":
            mensaje  = "Puede descender la energía disponible. Opta por sesiones moderadas y conscientes.";
            iconoRec = "🌿";
            break;
        default:
            mensaje  = "Registra tu ciclo menstrual para obtener recomendaciones personalizadas.";
            iconoRec = "📋";
    }

    // Inicial del avatar
    String inicial = usuario.getNombre() != null && !usuario.getNombre().isEmpty()
            ? String.valueOf(usuario.getNombre().charAt(0)).toUpperCase()
            : "U";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | MyraFit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=33">
</head>

<body class="dashboard-body">
<div class="container">

    <!-- HEADER -->
    <div class="header">
        <div class="header-left">
            <div class="avatar"><%= inicial %></div>
            <div class="header-text">
                <h2>Hola, <%= usuario.getNombre() %> 👋</h2>
                <p>Aquí tienes el resumen de tu actividad y bienestar</p>
            </div>
        </div>
        <a class="logout" href="logout">Cerrar sesión</a>
    </div>

    <div class="dashboard-grid">

        <!-- MAIN -->
        <div class="main">

            <!-- STAT CARDS -->
            <div class="cards">

                <div class="stat-card">
                    <span class="stat-icon">🏋️</span>
                    <h3>Entrenamientos</h3>
                    <p><%= totalEntrenamientos %></p>
                </div>

                <div class="stat-card">
                    <span class="stat-icon">😴</span>
                    <h3>Sueño medio</h3>
                    <p><%= String.format("%.1f", mediaSueno) %><span class="stat-unit">h</span></p>
                </div>

                <div class="stat-card">
                    <span class="stat-icon">👟</span>
                    <h3>Pasos medios</h3>
                    <p><%= String.format("%.0f", mediaPasos) %></p>
                </div>

                <div class="stat-card" style="background-color: <%= colorFase %>;">
                    <span class="stat-icon"><%= emojiFase %></span>
                    <h3>Fase del ciclo</h3>
                    <p style="font-size:18px;"><%= ultimaFase %></p>
                </div>

            </div>

            <!-- RECOMENDACIÓN -->
            <div class="highlight-card">
                <div class="highlight-icon"><%= iconoRec %></div>
                <div>
                    <h3>Recomendación personalizada</h3>
                    <p><%= mensaje %></p>
                </div>
            </div>

            <!-- CHART -->
            <div class="chart-card">
                <h3>Evolución de hábitos (últimos 7 días)</h3>
                <p class="subtitle" style="margin-bottom: 12px;">
                    Eje izquierdo: sueño, agua y energía. Eje derecho: pasos.
                </p>
                <canvas id="graficaEvolucion"></canvas>
            </div>

            <div class="chart-card">
                <h3>Calendario de entrenamientos</h3>
                <p class="subtitle" style="margin-bottom: 12px;">Días marcados = registraste al menos un entrenamiento.</p>
                <div class="calendar-header">
                    <span id="calendarMonthLabel"></span>
                </div>
                <div class="calendar-grid" id="calendarGrid"></div>
            </div>

        </div>

        <!-- SIDEBAR -->
        <div class="sidebar">

            <div class="sidebar-brand">
                <span>Myra<em>Fit</em></span>
            </div>

            <h3>Entrenamiento</h3>
            <a class="nav-item active" href="dashboard.jsp">
                <span class="nav-icon">🏠</span> Resumen
            </a>
            <a class="nav-item" href="registrarEntrenamiento.jsp">
                <span class="nav-icon">➕</span> Registrar entreno
            </a>
            <a class="nav-item" href="historialEntrenamientos.jsp">
                <span class="nav-icon">📅</span> Historial
            </a>
            <a class="nav-item" href="registrarRutina.jsp">
                <span class="nav-icon">📝</span> Crear rutina
            </a>
            <a class="nav-item" href="rutinas.jsp">
                <span class="nav-icon">📋</span> Mis rutinas
            </a>

            <h3>Hábitos</h3>
            <a class="nav-item" href="registrarHabito.jsp">
                <span class="nav-icon">✏️</span> Registrar hábitos
            </a>
            <a class="nav-item" href="historialHabitos.jsp">
                <span class="nav-icon">📊</span> Consultar hábitos
            </a>

            <h3>Ciclo menstrual</h3>
            <a class="nav-item" href="registrarCiclo.jsp">
                <span class="nav-icon">🌸</span> Registrar ciclo
            </a>
            <a class="nav-item" href="historialCiclo.jsp">
                <span class="nav-icon">🗓️</span> Historial del ciclo
            </a>

            <h3>Cuenta</h3>
            <a class="nav-item" href="perfil.jsp">
                <span class="nav-icon">👤</span> Mi perfil
            </a>

            <% if (esAdmin) { %>
            <a class="nav-item" href="admin.jsp">
                <span class="nav-icon">⚙️</span> Administración
            </a>
            <% } %>

        </div>

    </div>
</div>

<!-- CHART.JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const etiquetas7Dias = [
        <% for (int i = 0; i < habitosUltimos7.size(); i++) {
            Habito h = habitosUltimos7.get(i); %>
            "<%= new java.text.SimpleDateFormat("dd/MM").format(h.getFecha()) %>"<%= i < habitosUltimos7.size() - 1 ? "," : "" %>
        <% } %>
    ];

    const sueno7Dias = [
        <% for (int i = 0; i < habitosUltimos7.size(); i++) {
            Habito h = habitosUltimos7.get(i); %>
            <%= String.format(java.util.Locale.US, "%.2f", h.getHorasSueno()) %><%= i < habitosUltimos7.size() - 1 ? "," : "" %>
        <% } %>
    ];

    const pasos7Dias = [
        <% for (int i = 0; i < habitosUltimos7.size(); i++) {
            Habito h = habitosUltimos7.get(i); %>
            <%= h.getPasos() %><%= i < habitosUltimos7.size() - 1 ? "," : "" %>
        <% } %>
    ];

    const agua7Dias = [
        <% for (int i = 0; i < habitosUltimos7.size(); i++) {
            Habito h = habitosUltimos7.get(i); %>
            <%= String.format(java.util.Locale.US, "%.2f", h.getAgua()) %><%= i < habitosUltimos7.size() - 1 ? "," : "" %>
        <% } %>
    ];

    const energia7Dias = [
        <% for (int i = 0; i < habitosUltimos7.size(); i++) {
            Habito h = habitosUltimos7.get(i); %>
            <%= h.getEnergia() %><%= i < habitosUltimos7.size() - 1 ? "," : "" %>
        <% } %>
    ];

    const ctxEvolucion = document.getElementById('graficaEvolucion').getContext('2d');

    function crearGradiente(color, alpha1, alpha2) {
        const gradiente = ctxEvolucion.createLinearGradient(0, 0, 0, 300);
        gradiente.addColorStop(0, color.replace(')', ', ' + alpha1 + ')').replace('rgb', 'rgba'));
        gradiente.addColorStop(1, color.replace(')', ', ' + alpha2 + ')').replace('rgb', 'rgba'));
        return gradiente;
    }

    new Chart(ctxEvolucion, {
        type: 'line',
        data: {
            labels: etiquetas7Dias,
            datasets: [
                {
                    label: 'Sueño (h)',
                    data: sueno7Dias,
                    borderColor: '#d4919e',
                    backgroundColor: crearGradiente('rgb(212,145,158)', 0.25, 0.02),
                    borderWidth: 2.5,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: '#d4919e',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverRadius: 7,
                    fill: true,
                    yAxisID: 'yHabitos'
                },
                {
                    label: 'Agua (L)',
                    data: agua7Dias,
                    borderColor: '#5aa9e6',
                    backgroundColor: crearGradiente('rgb(90,169,230)', 0.2, 0.02),
                    borderWidth: 2.5,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: '#5aa9e6',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverRadius: 7,
                    fill: true,
                    yAxisID: 'yHabitos'
                },
                {
                    label: 'Energía (/10)',
                    data: energia7Dias,
                    borderColor: '#9b7ede',
                    backgroundColor: crearGradiente('rgb(155,126,222)', 0.2, 0.02),
                    borderWidth: 2.5,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: '#9b7ede',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverRadius: 7,
                    fill: true,
                    yAxisID: 'yHabitos'
                },
                {
                    label: 'Pasos',
                    data: pasos7Dias,
                    borderColor: '#8fb07c',
                    backgroundColor: crearGradiente('rgb(143,176,124)', 0.15, 0.02),
                    borderWidth: 2.5,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: '#8fb07c',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverRadius: 7,
                    fill: true,
                    yAxisID: 'yPasos'
                }
            ]
        },
        options: {
            responsive: true,
            interaction: { mode: 'index', intersect: false },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        usePointStyle: true,
                        padding: 20,
                        font: { family: 'DM Sans', size: 12, weight: '500' }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(45,52,54,0.95)',
                    titleFont: { family: 'DM Sans', size: 13, weight: '600' },
                    bodyFont: { family: 'DM Sans', size: 12 },
                    padding: 12,
                    cornerRadius: 10,
                    displayColors: true,
                    callbacks: {
                        label: function(context) {
                            const label = context.dataset.label || '';
                            const value = context.raw;
                            if (label.includes('Sueño')) return ' ' + label + ': ' + Number(value).toFixed(1) + ' h';
                            if (label.includes('Agua')) return ' ' + label + ': ' + Number(value).toFixed(1) + ' L';
                            if (label.includes('Energía')) return ' ' + label + ': ' + Number(value).toFixed(0) + ' /10';
                            return ' ' + label + ': ' + Number(value).toLocaleString() + ' pasos';
                        }
                    }
                }
            },
            scales: {
                yHabitos: {
                    type: 'linear',
                    position: 'left',
                    beginAtZero: true,
                    suggestedMax: 10,
                    grid: { color: 'rgba(0,0,0,0.04)', drawBorder: false },
                    ticks: {
                        font: { family: 'DM Sans', size: 11 },
                        color: '#8d9298'
                    }
                },
                yPasos: {
                    type: 'linear',
                    position: 'right',
                    beginAtZero: true,
                    grid: { display: false },
                    ticks: {
                        font: { family: 'DM Sans', size: 11 },
                        color: '#8d9298'
                    }
                },
                x: {
                    grid: { display: false },
                    ticks: {
                        font: { family: 'DM Sans', size: 11 },
                        color: '#8d9298'
                    }
                }
            }
        }
    });

    const fechasEntrenoMes = new Set([
        <% for (int i = 0; i < fechasEntrenoMes.size(); i++) { %>
            "<%= fechasEntrenoMes.get(i) %>"<%= i < fechasEntrenoMes.size() - 1 ? "," : "" %>
        <% } %>
    ]);

    const hoy = new Date();
    const year = hoy.getFullYear();
    const month = hoy.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const totalDays = lastDay.getDate();
    // Ajuste para que la semana empiece en lunes (L=0 ... D=6).
    const mondayBasedStart = (firstDay.getDay() + 6) % 7;

    const calendarGrid = document.getElementById('calendarGrid');
    const monthLabel = document.getElementById('calendarMonthLabel');
    monthLabel.textContent = firstDay.toLocaleDateString('es-ES', { month: 'long', year: 'numeric' });

    const weekDays = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    weekDays.forEach(d => {
        const el = document.createElement('div');
        el.className = 'calendar-weekday';
        el.textContent = d;
        calendarGrid.appendChild(el);
    });

    for (let i = 0; i < mondayBasedStart; i++) {
        const empty = document.createElement('div');
        empty.className = 'calendar-day calendar-day-empty';
        calendarGrid.appendChild(empty);
    }

    for (let day = 1; day <= totalDays; day++) {
        const date = new Date(year, month, day);
        const yyyy = date.getFullYear();
        const mm = String(date.getMonth() + 1).padStart(2, '0');
        const dd = String(day).padStart(2, '0');
        const dateKey = `${yyyy}-${mm}-${dd}`;

        const cell = document.createElement('div');
        // Se marca el dia si existe al menos un entrenamiento registrado para esa fecha.
        const entrenado = fechasEntrenoMes.has(dateKey);
        cell.className = entrenado ? 'calendar-day trained' : 'calendar-day';
        cell.textContent = day;
        cell.title = entrenado ? 'Dia con entrenamiento' : 'Sin entrenamiento registrado';
        calendarGrid.appendChild(cell);
    }

    <% if (toastMsg != null && !toastMsg.isEmpty()) { %>
    document.addEventListener('DOMContentLoaded', function() {
        showToast('<%= toastMsg %>', '<%= toastType %>');
    });
    <% } %>

    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('ok')) {
        document.addEventListener('DOMContentLoaded', function() {
            showToast('Operacion realizada con exito', 'success');
            history.replaceState(null, '', window.location.pathname);
        });
    }

    function showToast(message, type) {
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + (type || 'success');
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
    }
</script>
</body>
</html>