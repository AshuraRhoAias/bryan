package controller;

import model.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    
    private ContenidoDAO contenidoDAO = new ContenidoDAO();
    private CategoriaDAO categoriaDAO = new CategoriaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoriaParam = request.getParameter("categoria");
        List<Contenido> contenidos;
        
        if (categoriaParam != null && !categoriaParam.isEmpty()) {
            int idCategoria = Integer.parseInt(categoriaParam);
            contenidos = contenidoDAO.obtenerPorCategoria(idCategoria);
            request.setAttribute("categoriaSeleccionada", idCategoria);
        } else {
            contenidos = contenidoDAO.obtenerPublicados();
        }
        
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        
        request.setAttribute("contenidos", contenidos);
        request.setAttribute("categorias", categorias);
        
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}