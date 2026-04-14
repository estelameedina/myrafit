package controller;

import dao.UsuarioDAO;
import model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/perfil")
public class PerfilServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

        if (usuarioSesion == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");

        if (nombre == null || nombre.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {

            request.setAttribute("error", "Completa todos los campos.");
            request.getRequestDispatcher("perfil.jsp").forward(request, response);
            return;
        }

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        Usuario usuarioActual = usuarioDAO.obtenerPorId(usuarioSesion.getIdUsuario());

        if (usuarioActual == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!usuarioActual.getEmail().equals(email.trim()) && usuarioDAO.existeEmail(email.trim())) {
            request.setAttribute("error", "Ese email ya esta en uso.");
            request.getRequestDispatcher("perfil.jsp").forward(request, response);
            return;
        }

        usuarioActual.setNombre(nombre.trim());
        usuarioActual.setEmail(email.trim());

        boolean actualizado = usuarioDAO.actualizarPerfil(usuarioActual);

        if (actualizado) {
            session.setAttribute("usuario", usuarioActual);
            request.setAttribute("mensaje", "Perfil actualizado correctamente.");
        } else {
            request.setAttribute("error", "No se pudo actualizar el perfil.");
        }

        request.getRequestDispatcher("perfil.jsp").forward(request, response);
    }
}
