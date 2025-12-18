package controller.admin;

import model.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/categorias")
public class AdminCategoriasServlet extends HttpServlet {

    private CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/admin/categorias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String icono = request.getParameter("icono");
            String color = request.getParameter("color");

            Categoria categoria = new Categoria(nombre, descripcion, icono, color);
            categoriaDAO.insertar(categoria);
        }
        else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoriaDAO.eliminar(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/categorias");
    }
}
