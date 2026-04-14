package dao;

import model.Entrenamiento;
import utils.ConexionDB;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EntrenamientoDAO {

    public void guardarEntrenamiento(Entrenamiento e) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "INSERT INTO entrenamientos (id_usuario, fecha, duracion, tipo, notas, id_rutina) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, e.getIdUsuario());
            stmt.setDate(2, e.getFecha());
            stmt.setInt(3, e.getDuracion());
            stmt.setString(4, e.getTipo());
            stmt.setString(5, e.getNotas());
            if (e.getIdRutina() != null) {
                stmt.setInt(6, e.getIdRutina());
            } else {
                stmt.setNull(6, Types.INTEGER);
            }

            stmt.executeUpdate();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public int contarEntrenamientos(int idUsuario) {

        int total = 0;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT COUNT(*) FROM entrenamientos WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public List<Entrenamiento> listarEntrenamientosPorUsuario(int idUsuario) {

        List<Entrenamiento> lista = new ArrayList<>();

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT e.*, r.nombre AS nombre_rutina " +
                    "FROM entrenamientos e " +
                    "LEFT JOIN rutinas r ON e.id_rutina = r.id_rutina " +
                    "WHERE e.id_usuario = ? " +
                    "ORDER BY e.fecha DESC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Entrenamiento e = new Entrenamiento();
                e.setIdEntrenamiento(rs.getInt("id_entrenamiento"));
                e.setIdUsuario(rs.getInt("id_usuario"));
                e.setFecha(rs.getDate("fecha"));
                e.setDuracion(rs.getInt("duracion"));
                e.setTipo(rs.getString("tipo"));
                e.setNotas(rs.getString("notas"));
                int idRutina = rs.getInt("id_rutina");
                e.setIdRutina(rs.wasNull() ? null : idRutina);
                e.setNombreRutina(rs.getString("nombre_rutina"));

                lista.add(e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<String> listarFechasEntrenamientoMesActual(int idUsuario) {

        List<String> fechas = new ArrayList<>();
        LocalDate hoy = LocalDate.now();
        LocalDate primerDia = hoy.withDayOfMonth(1);
        LocalDate primerDiaMesSiguiente = primerDia.plusMonths(1);

        try {
            Connection conn = ConexionDB.getConnection();

            // Rango [inicioMes, inicioMesSiguiente) para obtener solo fechas del mes actual.
            String sql = "SELECT DISTINCT fecha FROM entrenamientos " +
                    "WHERE id_usuario = ? AND fecha >= ? AND fecha < ? " +
                    "ORDER BY fecha ASC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            stmt.setDate(2, Date.valueOf(primerDia));
            stmt.setDate(3, Date.valueOf(primerDiaMesSiguiente));

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                fechas.add(rs.getDate("fecha").toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return fechas;
    }
}
