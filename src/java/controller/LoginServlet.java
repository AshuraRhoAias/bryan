package controller;

import model.Usuario;
import model.UsuarioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validar campos
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Por favor completa todos los campos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Intentar login
        Usuario usuario = usuarioDAO.login(email, password);
        
        if (usuario != null) {
            // Login exitoso - crear sesión
            HttpSession session = request.getSession();
            
            // IMPORTANTE: Guardar el OBJETO Usuario completo, no Strings
            session.setAttribute("usuario", usuario);  // ← Este es el correcto
            
            // Estos son opcionales, solo para conveniencia
            session.setAttribute("nombreUsuario", usuario.getNombre());
            session.setAttribute("rolUsuario", usuario.getRol());
            
            session.setMaxInactiveInterval(30 * 60); // 30 minutos
            
            // Redirigir según el rol
            if (usuario.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // Login fallido
            request.setAttribute("error", "Email o contraseña incorrectos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}