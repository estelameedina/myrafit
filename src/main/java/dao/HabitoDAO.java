package dao;

import model.Habito;
import utils.ConexionDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class HabitoDAO {

    public void guardarHabito(Habito h) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "INSERT INTO habitos (id_usuario, fecha, horas_sueno, pasos, agua, energia) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, h.getIdUsuario());
            stmt.setDate(2, h.getFecha());
            stmt.setDouble(3, h.getHorasSueno());
            stmt.setInt(4, h.getPasos());
            stmt.setDouble(5, h.getAgua());
            stmt.setInt(6, h.getEnergia());

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double mediaSueno(int idUsuario) {

        double media = 0;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT AVG(horas_sueno) FROM habitos WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                media = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return media;
    }

    public double mediaPasos(int idUsuario) {

        double media = 0;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT AVG(pasos) FROM habitos WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                media = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return media;
    }

    public double mediaAgua(int idUsuario) {

        double media = 0;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT AVG(agua) FROM habitos WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                media = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return media;
    }

    public double mediaEnergia(int idUsuario) {

        double media = 0;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT AVG(energia) FROM habitos WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                media = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return media;
    }

    public List<Habito> listarHabitosPorUsuario(int idUsuario) {

        List<Habito> lista = new ArrayList<>();

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM habitos WHERE id_usuario = ? ORDER BY fecha DESC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Habito h = new Habito();
                h.setIdHabito(rs.getInt("id_habito"));
                h.setIdUsuario(rs.getInt("id_usuario"));
                h.setFecha(rs.getDate("fecha"));
                h.setHorasSueno(rs.getDouble("horas_sueno"));
                h.setPasos(rs.getInt("pasos"));
                h.setAgua(rs.getDouble("agua"));
                h.setEnergia(rs.getInt("energia"));

                lista.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Habito> listarUltimos7HabitosPorUsuario(int idUsuario) {

        List<Habito> lista = new ArrayList<>();

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM habitos WHERE id_usuario = ? ORDER BY fecha DESC LIMIT 7";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Habito h = new Habito();
                h.setIdHabito(rs.getInt("id_habito"));
                h.setIdUsuario(rs.getInt("id_usuario"));
                h.setFecha(rs.getDate("fecha"));
                h.setHorasSueno(rs.getDouble("horas_sueno"));
                h.setPasos(rs.getInt("pasos"));
                h.setAgua(rs.getDouble("agua"));
                h.setEnergia(rs.getInt("energia"));
                lista.add(h);
            }

            // La consulta viene DESC para limitar a los 7 mas recientes; invertimos para graficar cronologicamente.
            Collections.reverse(lista);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}
