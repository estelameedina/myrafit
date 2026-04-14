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

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (nombre == null || nombre.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Completa todos los campos.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        if (usuarioDAO.existeEmail(email.trim())) {
            request.setAttribute("error", "Ya existe una cuenta con ese email.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre.trim());
        usuario.setEmail(email.trim());
        usuario.setPassword(password);

        boolean guardado = usuarioDAO.guardarUsuario(usuario);

        if (!guardado) {
            request.setAttribute("error", "No se pudo crear la cuenta.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        Usuario usuarioLogueado = usuarioDAO.login(email.trim(), password);
        HttpSession session = request.getSession();
        session.setAttribute("usuario", usuarioLogueado);

        response.sendRedirect("dashboard.jsp");
    }
}
