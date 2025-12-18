package model;

/**
 * Clase modelo para representar una Categoría de contenido
 */
public class Categoria {
    private int idCategoria;
    private String nombre;
    private String descripcion;
    private String icono;
    private String color;
    
    // Constructor vacío
    public Categoria() {
    }
    
    // Constructor completo
    public Categoria(int idCategoria, String nombre, String descripcion, String icono, String color) {
        this.idCategoria = idCategoria;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.icono = icono;
        this.color = color;
    }
    
    // Constructor sin ID
    public Categoria(String nombre, String descripcion, String icono, String color) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.icono = icono;
        this.color = color;
    }
    
    // Getters y Setters
    public int getIdCategoria() {
        return idCategoria;
    }
    
    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getIcono() {
        return icono;
    }
    
    public void setIcono(String icono) {
        this.icono = icono;
    }
    
    public String getColor() {
        return color;
    }
    
    public void setColor(String color) {
        this.color = color;
    }
    
    @Override
    public String toString() {
        return "Categoria{" +
                "idCategoria=" + idCategoria +
                ", nombre='" + nombre + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", icono='" + icono + '\'' +
                ", color='" + color + '\'' +
                '}';
    }
}
