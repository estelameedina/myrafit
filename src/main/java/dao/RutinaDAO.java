package dao;

import model.Rutina;
import utils.ConexionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RutinaDAO {

    public boolean guardarRutina(Rutina rutina) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "INSERT INTO rutinas (nombre, objetivo, nivel, duracion, descripcion) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, rutina.getNombre());
            stmt.setString(2, rutina.getObjetivo());
            stmt.setString(3, rutina.getNivel());
            stmt.setInt(4, rutina.getDuracion());
            stmt.setString(5, rutina.getDescripcion());

            stmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Rutina> listarRutinas() {

        List<Rutina> lista = new ArrayList<>();

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM rutinas ORDER BY nombre ASC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Rutina rutina = new Rutina();
                rutina.setIdRutina(rs.getInt("id_rutina"));
                rutina.setNombre(rs.getString("nombre"));
                rutina.setObjetivo(rs.getString("objetivo"));
                rutina.setNivel(rs.getString("nivel"));
                rutina.setDuracion(rs.getInt("duracion"));
                rutina.setDescripcion(rs.getString("descripcion"));

                lista.add(rutina);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public boolean eliminarRutina(int idRutina) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "DELETE FROM rutinas WHERE id_rutina = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idRutina);

            int filas = stmt.executeUpdate();

            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
