package controller;

import dao.CicloMenstrualDAO;
import model.CicloMenstrual;
import model.Usuario;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/guardarCiclo")
public class CicloServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if(usuario == null){
                response.sendRedirect("login.jsp");
                return;
            }

            CicloMenstrual c = new CicloMenstrual();

            c.setIdUsuario(usuario.getIdUsuario());
            c.setFecha(Date.valueOf(request.getParameter("fecha")));
            c.setFase(request.getParameter("fase"));
            c.setNotas(request.getParameter("notas"));

            CicloMenstrualDAO dao = new CicloMenstrualDAO();
            dao.guardarCiclo(c);

            response.sendRedirect("registrarCiclo.jsp?ok=1");

        } catch (Exception e){
            e.printStackTrace();
            response.sendRedirect("registrarCiclo.jsp?error=1");
        }
    }
}