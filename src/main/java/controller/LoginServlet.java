package controller;

import dao.UsuarioDAO;
import model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String ADMIN_EMAIL = "admin@myrafit.com";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Introduce tu email y tu contrasena.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.login(email.trim(), password);

        if (usuario != null) {

            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            boolean esAdmin = ADMIN_EMAIL.equalsIgnoreCase(usuario.getEmail());
            session.setAttribute("esAdmin", esAdmin);

            response.sendRedirect("dashboard.jsp");

        } else {

            request.setAttribute("error", "Email o contrasena incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        }
    }
}
