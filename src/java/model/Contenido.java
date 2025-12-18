package model;

import java.sql.Timestamp;
import java.util.List;

/**
 * Clase modelo para representar un Contenido (artículo, tip, noticia, etc.)
 */
public class Contenido {
    private int idContenido;
    private String titulo;
    private String cuerpo;
    private String tipo;
    private Timestamp fechaPublicacion;
    private int idAdmin;
    private String nombreAdmin;
    private int vistas;
    private String estado;
    private List<Categoria> categorias;
    
    // Constructor vacío
    public Contenido() {
    }
    
    // Constructor completo
    public Contenido(int idContenido, String titulo, String cuerpo, String tipo, 
                     Timestamp fechaPublicacion, int idAdmin, int vistas, String estado) {
        this.idContenido = idContenido;
        this.titulo = titulo;
        this.cuerpo = cuerpo;
        this.tipo = tipo;
        this.fechaPublicacion = fechaPublicacion;
        this.idAdmin = idAdmin;
        this.vistas = vistas;
        this.estado = estado;
    }
    
    // Constructor para inserción
    public Contenido(String titulo, String cuerpo, String tipo, int idAdmin, String estado) {
        this.titulo = titulo;
        this.cuerpo = cuerpo;
        this.tipo = tipo;
        this.idAdmin = idAdmin;
        this.estado = estado;
        this.vistas = 0;
    }
    
    // Getters y Setters
    public int getIdContenido() {
        return idContenido;
    }
    
    public void setIdContenido(int idContenido) {
        this.idContenido = idContenido;
    }
    
    public String getTitulo() {
        return titulo;
    }
    
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
    
    public String getCuerpo() {
        return cuerpo;
    }
    
    public void setCuerpo(String cuerpo) {
        this.cuerpo = cuerpo;
    }
    
    public String getTipo() {
        return tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public Timestamp getFechaPublicacion() {
        return fechaPublicacion;
    }
    
    public void setFechaPublicacion(Timestamp fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }
    
    public int getIdAdmin() {
        return idAdmin;
    }
    
    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }
    
    public String getNombreAdmin() {
        return nombreAdmin;
    }
    
    public void setNombreAdmin(String nombreAdmin) {
        this.nombreAdmin = nombreAdmin;
    }
    
    public int getVistas() {
        return vistas;
    }
    
    public void setVistas(int vistas) {
        this.vistas = vistas;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public List<Categoria> getCategorias() {
        return categorias;
    }
    
    public void setCategorias(List<Categoria> categorias) {
        this.categorias = categorias;
    }
    
    // Métodos de utilidad
    public void incrementarVistas() {
        this.vistas++;
    }
    
    public boolean isPublicado() {
        return "publicado".equalsIgnoreCase(this.estado);
    }
    
    public String getResumen(int maxCaracteres) {
        if (cuerpo == null) return "";
        if (cuerpo.length() <= maxCaracteres) return cuerpo;
        return cuerpo.substring(0, maxCaracteres) + "...";
    }
    
    @Override
    public String toString() {
        return "Contenido{" +
                "idContenido=" + idContenido +
                ", titulo='" + titulo + '\'' +
                ", tipo='" + tipo + '\'' +
                ", estado='" + estado + '\'' +
                ", vistas=" + vistas +
                ", fechaPublicacion=" + fechaPublicacion +
                '}';
    }
}
