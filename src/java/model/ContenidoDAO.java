package model;

import database.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para operaciones CRUD de Contenido
 */
public class ContenidoDAO {
    
    private CategoriaDAO categoriaDAO = new CategoriaDAO();
    
    /**
     * Obtiene todos los contenidos publicados
     */
    public List<Contenido> obtenerPublicados() {
        List<Contenido> contenidos = new ArrayList<>();
        String sql = "SELECT c.*, u.nombre as nombre_admin FROM Contenido c " +
                    "INNER JOIN Usuario u ON c.id_admin = u.id_usuario " +
                    "WHERE c.estado = 'publicado' " +
                    "ORDER BY c.fecha_publicacion DESC";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Contenido contenido = extractContenidoFromResultSet(rs);
                contenido.setCategorias(categoriaDAO.obtenerPorContenido(contenido.getIdContenido()));
                contenidos.add(contenido);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contenidos;
    }
    
    /**
     * Obtiene todos los contenidos (para admin)
     */
    public List<Contenido> obtenerTodos() {
        List<Contenido> contenidos = new ArrayList<>();
        String sql = "SELECT c.*, u.nombre as nombre_admin FROM Contenido c " +
                    "INNER JOIN Usuario u ON c.id_admin = u.id_usuario " +
                    "ORDER BY c.fecha_publicacion DESC";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Contenido contenido = extractContenidoFromResultSet(rs);
                contenido.setCategorias(categoriaDAO.obtenerPorContenido(contenido.getIdContenido()));
                contenidos.add(contenido);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contenidos;
    }
    
    /**
     * Obtiene un contenido por ID
     */
    public Contenido obtenerPorId(int id) {
        String sql = "SELECT c.*, u.nombre as nombre_admin FROM Contenido c " +
                    "INNER JOIN Usuario u ON c.id_admin = u.id_usuario " +
                    "WHERE c.id_contenido = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Contenido contenido = extractContenidoFromResultSet(rs);
                    contenido.setCategorias(categoriaDAO.obtenerPorContenido(id));
                    return contenido;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Obtiene contenidos por categoría
     */
    public List<Contenido> obtenerPorCategoria(int idCategoria) {
        List<Contenido> contenidos = new ArrayList<>();
        String sql = "SELECT DISTINCT c.*, u.nombre as nombre_admin FROM Contenido c " +
                    "INNER JOIN Usuario u ON c.id_admin = u.id_usuario " +
                    "INNER JOIN Contenido_Categoria cc ON c.id_contenido = cc.id_contenido " +
                    "WHERE cc.id_categoria = ? AND c.estado = 'publicado' " +
                    "ORDER BY c.fecha_publicacion DESC";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idCategoria);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Contenido contenido = extractContenidoFromResultSet(rs);
                    contenido.setCategorias(categoriaDAO.obtenerPorContenido(contenido.getIdContenido()));
                    contenidos.add(contenido);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contenidos;
    }
    
    /**
     * Obtiene contenidos por tipo
     */
    public List<Contenido> obtenerPorTipo(String tipo) {
        List<Contenido> contenidos = new ArrayList<>();
        String sql = "SELECT c.*, u.nombre as nombre_admin FROM Contenido c " +
                    "INNER JOIN Usuario u ON c.id_admin = u.id_usuario " +
                    "WHERE c.tipo = ? AND c.estado = 'publicado' " +
                    "ORDER BY c.fecha_publicacion DESC";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tipo);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Contenido contenido = extractContenidoFromResultSet(rs);
                    contenido.setCategorias(categoriaDAO.obtenerPorContenido(contenido.getIdContenido()));
                    contenidos.add(contenido);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contenidos;
    }
    
    /**
     * Inserta un nuevo contenido
     */
    public int insertar(Contenido contenido) {
        String sql = "INSERT INTO Contenido (titulo, cuerpo, tipo, id_admin, estado, vistas) VALUES (?, ?, ?, ?, ?, 0)";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, contenido.getTitulo());
            ps.setString(2, contenido.getCuerpo());
            ps.setString(3, contenido.getTipo());
            ps.setInt(4, contenido.getIdAdmin());
            ps.setString(5, contenido.getEstado());
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    /**
     * Actualiza un contenido
     */
    public boolean actualizar(Contenido contenido) {
        String sql = "UPDATE Contenido SET titulo = ?, cuerpo = ?, tipo = ?, estado = ? WHERE id_contenido = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, contenido.getTitulo());
            ps.setString(2, contenido.getCuerpo());
            ps.setString(3, contenido.getTipo());
            ps.setString(4, contenido.getEstado());
            ps.setInt(5, contenido.getIdContenido());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Incrementa el contador de vistas
     */
    public boolean incrementarVistas(int idContenido) {
        String sql = "UPDATE Contenido SET vistas = vistas + 1 WHERE id_contenido = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idContenido);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Elimina un contenido
     */
    public boolean eliminar(int id) {
        String sql = "DELETE FROM Contenido WHERE id_contenido = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Asigna categorías a un contenido
     */
    public boolean asignarCategorias(int idContenido, int[] idsCategorias) {
        // Primero elimina las categorías existentes
        eliminarCategorias(idContenido);
        
        // Luego inserta las nuevas
        String sql = "INSERT INTO Contenido_Categoria (id_contenido, id_categoria) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            for (int idCategoria : idsCategorias) {
                ps.setInt(1, idContenido);
                ps.setInt(2, idCategoria);
                ps.addBatch();
            }
            
            ps.executeBatch();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Elimina las categorías asociadas a un contenido
     */
    private boolean eliminarCategorias(int idContenido) {
        String sql = "DELETE FROM Contenido_Categoria WHERE id_contenido = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idContenido);
            ps.executeUpdate();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Obtiene estadísticas de contenidos
     */
    public int contarTodos() {
        String sql = "SELECT COUNT(*) FROM Contenido";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Extrae un objeto Contenido de un ResultSet
     */
    private Contenido extractContenidoFromResultSet(ResultSet rs) throws SQLException {
        Contenido contenido = new Contenido();
        contenido.setIdContenido(rs.getInt("id_contenido"));
        contenido.setTitulo(rs.getString("titulo"));
        contenido.setCuerpo(rs.getString("cuerpo"));
        contenido.setTipo(rs.getString("tipo"));
        contenido.setFechaPublicacion(rs.getTimestamp("fecha_publicacion"));
        contenido.setIdAdmin(rs.getInt("id_admin"));
        contenido.setNombreAdmin(rs.getString("nombre_admin"));
        contenido.setVistas(rs.getInt("vistas"));
        contenido.setEstado(rs.getString("estado"));
        return contenido;
    }
}
