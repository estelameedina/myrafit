package controller;

import dao.HabitoDAO;
import model.Habito;
import model.Usuario;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/guardarHabito")
public class HabitoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if(usuario == null){
                response.sendRedirect("login.jsp");
                return;
            }

            Habito h = new Habito();

            h.setIdUsuario(usuario.getIdUsuario());
            h.setFecha(Date.valueOf(request.getParameter("fecha")));
            h.setHorasSueno(Double.parseDouble(request.getParameter("sueno")));
            h.setPasos(Integer.parseInt(request.getParameter("pasos")));
            h.setAgua(Double.parseDouble(request.getParameter("agua")));
            h.setEnergia(Integer.parseInt(request.getParameter("energia")));

            HabitoDAO dao = new HabitoDAO();
            dao.guardarHabito(h);

            response.sendRedirect("registrarHabito.jsp?ok=1");

        } catch (Exception e){
            e.printStackTrace();
            response.sendRedirect("registrarHabito.jsp?error=1");
        }
    }
}