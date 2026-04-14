package controller;

import dao.RutinaDAO;
import model.Usuario;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/eliminarRutina")
public class EliminarRutinaServlet extends HttpServlet {

    private static final String ADMIN_EMAIL = "admin@myrafit.com";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Seguridad: esta operación queda restringida a perfiles de administración.
        if (usuario == null || !ADMIN_EMAIL.equalsIgnoreCase(usuario.getEmail())) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String idStr = request.getParameter("id");

        try {
            int idRutina = Integer.parseInt(idStr);

            RutinaDAO rutinaDAO = new RutinaDAO();
            boolean eliminada = rutinaDAO.eliminarRutina(idRutina);

            if (eliminada) {
                response.sendRedirect("admin.jsp?eliminado=1");
            } else {
                response.sendRedirect("admin.jsp?eliminado=0");
            }

        } catch (Exception e) {
            response.sendRedirect("admin.jsp?eliminado=0");
        }
    }
}
