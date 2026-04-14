package controller;

import dao.EntrenamientoDAO;
import model.Entrenamiento;
import model.Usuario;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/guardarEntrenamiento")
public class EntrenamientoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if(usuario == null){
                response.sendRedirect("login.jsp");
                return;
            }

            Entrenamiento e = new Entrenamiento();

            e.setIdUsuario(usuario.getIdUsuario());
            e.setFecha(Date.valueOf(request.getParameter("fecha")));
            e.setDuracion(Integer.parseInt(request.getParameter("duracion")));
            e.setTipo(request.getParameter("tipo"));
            e.setNotas(request.getParameter("notas"));
            String idRutinaStr = request.getParameter("idRutina");
            if (idRutinaStr != null && !idRutinaStr.trim().isEmpty()) {
                e.setIdRutina(Integer.parseInt(idRutinaStr));
            } else {
                e.setIdRutina(null);
            }

            EntrenamientoDAO dao = new EntrenamientoDAO();
            dao.guardarEntrenamiento(e);

            response.sendRedirect("registrarEntrenamiento.jsp?ok=1");

        } catch (Exception ex){
            ex.printStackTrace();
            response.sendRedirect("registrarEntrenamiento.jsp?error=1");
        }
    }
}