package controller;

import dao.UsuarioDAO;
import model.Usuario;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/eliminarUsuario")
public class EliminarUsuarioServlet extends HttpServlet {

    private static final String ADMIN_EMAIL = "admin@myrafit.com";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Seguridad: solo el administrador puede ejecutar eliminaciones de usuarios.
        if (usuario == null || !ADMIN_EMAIL.equalsIgnoreCase(usuario.getEmail())) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String idStr = request.getParameter("id");

        try {
            int idUsuario = Integer.parseInt(idStr);

            // Evita que el administrador elimine su propia cuenta por error.
            if (usuario.getIdUsuario() == idUsuario) {
                response.sendRedirect("admin.jsp?eliminado=0");
                return;
            }

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            boolean eliminado = usuarioDAO.eliminarUsuario(idUsuario);

            if (eliminado) {
                response.sendRedirect("admin.jsp?eliminado=1");
            } else {
                response.sendRedirect("admin.jsp?eliminado=0");
            }

        } catch (Exception e) {
            response.sendRedirect("admin.jsp?eliminado=0");
        }
    }
}
