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
            System.out.println("========================================");
            System.out.println("✓ CONEXIÓN A BASE DE DATOS ESTABLECIDA");
            System.out.println("  Base de datos: plataforma_iag");
            System.out.println("  URL: " + URL);
            System.out.println("  Usuario: " + USER);
            System.out.println("========================================");
        } catch (ClassNotFoundException e) {
            System.err.println("========================================");
            System.err.println("✗ ERROR: Driver MySQL no encontrado");
            System.err.println("========================================");
            System.err.println("Solución:");
            System.err.println("1. Verificar que mysql-connector-j-9.3.0.jar esté en lib/");
            System.err.println("2. Limpiar y recompilar el proyecto (Clean and Build)");
            System.err.println("3. Verificar configuración de librerías en NetBeans");
            System.err.println("========================================");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("========================================");
            System.err.println("✗ ERROR: No se pudo conectar a la base de datos");
            System.err.println("========================================");
            System.err.println("URL intentada: " + URL);
            System.err.println("Usuario: " + USER);
            System.err.println("");
            System.err.println("Posibles causas:");
            System.err.println("1. MySQL no está ejecutándose");
            System.err.println("   Solución: Iniciar MySQL Server");
            System.err.println("");
            System.err.println("2. La base de datos 'plataforma_iag' no existe");
            System.err.println("   Solución: Ejecutar el script database/schema.sql");
            System.err.println("   Comando: mysql -u root -p < database/schema.sql");
            System.err.println("");
            System.err.println("3. Credenciales incorrectas");
            System.err.println("   Solución: Verificar USER y PASSWORD en DatabaseConnection.java");
            System.err.println("");
            System.err.println("4. Puerto incorrecto o MySQL en otra dirección");
            System.err.println("   Solución: Verificar que MySQL esté en localhost:3306");
            System.err.println("========================================");
            System.err.println("Detalles del error:");
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
