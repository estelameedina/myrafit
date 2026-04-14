package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionDB {

    private static final String URL = "jdbc:mysql://localhost:3306/myrafit";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() {

        Connection conn = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("Conexion correcta a la base de datos");

        } catch (Exception e) {

            System.out.println("Error de conexion");
            e.printStackTrace();

        }

        return conn;
    }
}