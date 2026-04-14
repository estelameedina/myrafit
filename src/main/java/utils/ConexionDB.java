package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.net.URI;
import java.net.URISyntaxException;

public class ConexionDB {

    private static String DATABASE_URL;
    private static String DATABASE_USER;
    private static String DATABASE_PASSWORD;

    static {
        String mysqlUrl = System.getenv("MYSQL_URL");
        
        if (mysqlUrl != null && !mysqlUrl.isEmpty()) {
            // Parsear la URL de Railway
            // Formato: mysql://user:password@host:port/database
            try {
                URI uri = new URI(mysqlUrl.replace("mysql://", "http://"));
                DATABASE_USER = uri.getUserInfo().split(":")[0];
                DATABASE_PASSWORD = uri.getUserInfo().split(":")[1];
                DATABASE_URL = "jdbc:mysql://" + uri.getHost() + ":" + uri.getPort() + uri.getPath() + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            } catch (Exception e) {
                // Si falla, usar valores por defecto
                DATABASE_URL = "jdbc:mysql://localhost:3306/myrafit";
                DATABASE_USER = "root";
                DATABASE_PASSWORD = "";
            }
        } else {
            // Entorno local
            DATABASE_URL = "jdbc:mysql://localhost:3306/myrafit";
            DATABASE_USER = "root";
            DATABASE_PASSWORD = "";
        }
    }

    public static Connection getConnection() {

        Connection conn = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(DATABASE_URL, DATABASE_USER, DATABASE_PASSWORD);

            System.out.println("Conexion correcta a la base de datos");

        } catch (Exception e) {

            System.out.println("Error de conexion");
            e.printStackTrace();

        }

        return conn;
    }
}
