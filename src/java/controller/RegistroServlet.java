package controller;

import model.Usuario;
import model.UsuarioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (nombre == null || nombre.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        if (usuarioDAO.emailExiste(email)) {
            request.setAttribute("error", "El email ya está registrado");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        Usuario usuario = new Usuario(nombre, email, UsuarioDAO.hashPassword(password), "usuario");
        
        if (usuarioDAO.registrar(usuario)) {
            request.setAttribute("success", "Usuario registrado exitosamente. Inicia sesión.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Error al registrar usuario");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
        }
    }
}