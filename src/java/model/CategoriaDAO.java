package model;

import database.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para operaciones CRUD de Categoria
 */
public class CategoriaDAO {
    
    /**
     * Obtiene todas las categorías
     */
    public List<Categoria> obtenerTodas() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM Categoria ORDER BY nombre";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                categorias.add(extractCategoriaFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorias;
    }
    
    /**
     * Obtiene una categoría por ID
     */
    public Categoria obtenerPorId(int id) {
        String sql = "SELECT * FROM Categoria WHERE id_categoria = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractCategoriaFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Obtiene las categorías de un contenido específico
     */
    public List<Categoria> obtenerPorContenido(int idContenido) {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT c.* FROM Categoria c " +
                    "INNER JOIN Contenido_Categoria cc ON c.id_categoria = cc.id_categoria " +
                    "WHERE cc.id_contenido = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idContenido);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categorias.add(extractCategoriaFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorias;
    }
    
    /**
     * Inserta una nueva categoría
     */
    public boolean insertar(Categoria categoria) {
        String sql = "INSERT INTO Categoria (nombre, descripcion, icono, color) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            ps.setString(3, categoria.getIcono());
            ps.setString(4, categoria.getColor());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Actualiza una categoría
     */
    public boolean actualizar(Categoria categoria) {
        String sql = "UPDATE Categoria SET nombre = ?, descripcion = ?, icono = ?, color = ? WHERE id_categoria = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            ps.setString(3, categoria.getIcono());
            ps.setString(4, categoria.getColor());
            ps.setInt(5, categoria.getIdCategoria());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Elimina una categoría
     */
    public boolean eliminar(int id) {
        String sql = "DELETE FROM Categoria WHERE id_categoria = ?";
        
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
     * Extrae un objeto Categoria de un ResultSet
     */
    private Categoria extractCategoriaFromResultSet(ResultSet rs) throws SQLException {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(rs.getInt("id_categoria"));
        categoria.setNombre(rs.getString("nombre"));
        categoria.setDescripcion(rs.getString("descripcion"));
        categoria.setIcono(rs.getString("icono"));
        categoria.setColor(rs.getString("color"));
        return categoria;
    }
}
