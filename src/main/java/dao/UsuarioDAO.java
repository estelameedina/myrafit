package dao;

import model.Usuario;
import org.mindrot.jbcrypt.BCrypt;
import utils.ConexionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public boolean guardarUsuario(Usuario usuario) {

        String sql = "INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)";

        try {
            Connection conn = ConexionDB.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, BCrypt.hashpw(usuario.getPassword(), BCrypt.gensalt()));

            stmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario login(String email, String password) {

        Usuario usuario = null;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM usuarios WHERE email = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String passwordGuardada = rs.getString("password");
                boolean passwordValida;

                if (passwordGuardada != null && passwordGuardada.startsWith("$2")) {
                    passwordValida = BCrypt.checkpw(password, passwordGuardada);
                } else {
                    // Compatibilidad temporal con cuentas antiguas en texto plano.
                    passwordValida = passwordGuardada != null && passwordGuardada.equals(password);
                }

                if (!passwordValida) {
                    return null;
                }

                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPassword(passwordGuardada);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }

    public boolean existeEmail(String email) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT id_usuario FROM usuarios WHERE email = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario obtenerPorId(int idUsuario) {

        Usuario usuario = null;

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }

    public boolean actualizarPerfil(Usuario usuario) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "UPDATE usuarios SET nombre = ?, email = ? WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getEmail());
            stmt.setInt(3, usuario.getIdUsuario());

            int filas = stmt.executeUpdate();

            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Usuario> listarUsuarios() {

        List<Usuario> lista = new ArrayList<>();

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "SELECT * FROM usuarios ORDER BY nombre ASC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPassword(rs.getString("password"));

                lista.add(usuario);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public boolean eliminarUsuario(int idUsuario) {

        try {

            Connection conn = ConexionDB.getConnection();

            String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);

            int filas = stmt.executeUpdate();

            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
