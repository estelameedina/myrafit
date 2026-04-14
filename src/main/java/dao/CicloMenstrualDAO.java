package dao;

import model.CicloMenstrual;
import utils.ConexionDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CicloMenstrualDAO {

    public void guardarCiclo(CicloMenstrual c) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "INSERT INTO ciclo_menstrual (id_usuario, fecha, fase, notas) VALUES (?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, c.getIdUsuario());
            stmt.setDate(2, c.getFecha());
            stmt.setString(3, c.getFase());
            stmt.setString(4, c.getNotas());

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String ultimaFase(int idUsuario) {

        String fase = "Sin datos";

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT fase FROM ciclo_menstrual WHERE id_usuario = ? ORDER BY fecha DESC LIMIT 1";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                fase = rs.getString("fase");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return fase;
    }

    public List<CicloMenstrual> listarCiclosPorUsuario(int idUsuario) {

        List<CicloMenstrual> lista = new ArrayList<>();

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM ciclo_menstrual WHERE id_usuario = ? ORDER BY fecha DESC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CicloMenstrual c = new CicloMenstrual();
                c.setIdCiclo(rs.getInt("id_ciclo"));
                c.setIdUsuario(rs.getInt("id_usuario"));
                c.setFecha(rs.getDate("fecha"));
                c.setFase(rs.getString("fase"));
                c.setNotas(rs.getString("notas"));

                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}
