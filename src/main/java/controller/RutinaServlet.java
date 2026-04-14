package controller;

import dao.RutinaDAO;
import model.Rutina;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/guardarRutina")
public class RutinaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Object usuario = session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String objetivo = request.getParameter("objetivo");
        String nivel = request.getParameter("nivel");
        String duracionStr = request.getParameter("duracion");
        String descripcion = request.getParameter("descripcion");

        if (nombre == null || nombre.trim().isEmpty() ||
                objetivo == null || objetivo.trim().isEmpty() ||
                nivel == null || nivel.trim().isEmpty() ||
                duracionStr == null || duracionStr.trim().isEmpty()) {

            request.setAttribute("error", "Completa todos los campos obligatorios.");
            request.getRequestDispatcher("registrarRutina.jsp").forward(request, response);
            return;
        }

        try {
            int duracion = Integer.parseInt(duracionStr);

            Rutina rutina = new Rutina();
            rutina.setNombre(nombre.trim());
            rutina.setObjetivo(objetivo.trim());
            rutina.setNivel(nivel.trim());
            rutina.setDuracion(duracion);
            rutina.setDescripcion(descripcion != null ? descripcion.trim() : "");

            RutinaDAO rutinaDAO = new RutinaDAO();
            boolean guardada = rutinaDAO.guardarRutina(rutina);

            if (guardada) {
                response.sendRedirect("rutinas.jsp?ok=1");
            } else {
                request.setAttribute("error", "No se pudo guardar la rutina.");
                request.getRequestDispatcher("registrarRutina.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "La duracion debe ser un numero valido.");
            request.getRequestDispatcher("registrarRutina.jsp").forward(request, response);
        }
    }
}
