package controller;

import model.Contenido;
import model.ContenidoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/contenido")
public class ContenidoServlet extends HttpServlet {
    
    private ContenidoDAO contenidoDAO = new ContenidoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        int idContenido = Integer.parseInt(idParam);
        Contenido contenido = contenidoDAO.obtenerPorId(idContenido);
        
        if (contenido == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        contenidoDAO.incrementarVistas(idContenido);
        
        request.setAttribute("contenido", contenido);
        request.getRequestDispatcher("/contenido-detalle.jsp").forward(request, response);
    }
}