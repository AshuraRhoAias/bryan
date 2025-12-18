package controller;

import model.CategoriaDAO;
import model.Categoria;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/categorias")
public class CategoriaServlet extends HttpServlet {

    private CategoriaDAO categoriaDAO;

    @Override
    public void init() {
        categoriaDAO = new CategoriaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/categorias.jsp").forward(request, response);
    }
}
