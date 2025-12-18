package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Gestión de conexión MySQL (SIN Singleton de Connection)
 */
public class DatabaseConnection {
private static DatabaseConnection instance;
    private Connection connection;
    
    // Configuración de la base de datos
    private static final String URL = "jdbc:mysql://localhost:3306/plataforma_iag?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    /**
     * Constructor privado para implementar Singleton
     */
    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✓ Conexión a base de datos establecida");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver MySQL no encontrado");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error al conectar con la base de datos");
            e.printStackTrace();
        }
    }
    
    /**
     * Obtiene la instancia única de DatabaseConnection (Singleton)
     * @return Instancia de DatabaseConnection
     */
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }
    
    /**
     * Obtiene la conexión activa a la base de datos
     * @return Connection objeto de conexión
     */
    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                instance = new DatabaseConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
    
    /**
     * Cierra la conexión a la base de datos
     */
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("✓ Conexión cerrada");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
