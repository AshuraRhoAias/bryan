package model;

import java.sql.Timestamp;

/**
 * Clase modelo para representar un Usuario del sistema
 */
public class Usuario {
    private int idUsuario;
    private String nombre;
    private String email;
    private String passwordHash;
    private String rol;
    private Timestamp fechaRegistro;
    
    // Constructor vacío
    public Usuario() {
    }
    
    // Constructor completo
    public Usuario(int idUsuario, String nombre, String email, String passwordHash, String rol, Timestamp fechaRegistro) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.email = email;
        this.passwordHash = passwordHash;
        this.rol = rol;
        this.fechaRegistro = fechaRegistro;
    }
    
    // Constructor sin ID (para inserción)
    public Usuario(String nombre, String email, String passwordHash, String rol) {
        this.nombre = nombre;
        this.email = email;
        this.passwordHash = passwordHash;
        this.rol = rol;
    }
    
    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public String getRol() {
        return rol;
    }
    
    public void setRol(String rol) {
        this.rol = rol;
    }
    
    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }
    
    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
    
    // Método de utilidad
    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(this.rol);
    }
    
    @Override
    public String toString() {
        return "Usuario{" +
                "idUsuario=" + idUsuario +
                ", nombre='" + nombre + '\'' +
                ", email='" + email + '\'' +
                ", rol='" + rol + '\'' +
                ", fechaRegistro=" + fechaRegistro +
                '}';
    }
}
