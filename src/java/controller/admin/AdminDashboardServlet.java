package controller.admin;

import model.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    private ContenidoDAO contenidoDAO = new ContenidoDAO();
    private CategoriaDAO categoriaDAO = new CategoriaDAO();
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Obtener datos
        List<Contenido> contenidos = contenidoDAO.obtenerTodos();
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        List<Usuario> usuarios = usuarioDAO.obtenerTodos();
        
        // Pasar a la vista
        request.setAttribute("totalContenidos", contenidos.size());
        request.setAttribute("totalCategorias", categorias.size());
        request.setAttribute("totalUsuarios", usuarios.size());
        request.setAttribute("contenidos", contenidos);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}