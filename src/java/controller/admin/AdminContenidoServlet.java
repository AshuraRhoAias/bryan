package controller.admin;

import model.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/contenido/*")
public class AdminContenidoServlet extends HttpServlet {

    private ContenidoDAO contenidoDAO = new ContenidoDAO();
    private CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Listar contenidos (ya lo maneja AdminDashboardServlet)
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        if (pathInfo.equals("/nuevo")) {
            // Mostrar formulario de nuevo contenido
            List<Categoria> categorias = categoriaDAO.obtenerTodas();
            request.setAttribute("categorias", categorias);
            request.getRequestDispatcher("/admin/contenido-form.jsp").forward(request, response);
        }
        else if (pathInfo.startsWith("/editar/")) {
            // Editar contenido existente
            try {
                int id = Integer.parseInt(pathInfo.substring("/editar/".length()));
                Contenido contenido = contenidoDAO.obtenerPorId(id);
                List<Categoria> categorias = categoriaDAO.obtenerTodas();

                if (contenido != null) {
                    request.setAttribute("contenido", contenido);
                    request.setAttribute("categorias", categorias);
                    request.getRequestDispatcher("/admin/contenido-form.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            }
        }
        else if (pathInfo.startsWith("/eliminar/")) {
            // Eliminar contenido
            try {
                int id = Integer.parseInt(pathInfo.substring("/eliminar/".length()));
                contenidoDAO.eliminar(id);
            } catch (NumberFormatException e) {
                // Ignorar error
            }
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
        else {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        String titulo = request.getParameter("titulo");
        String cuerpo = request.getParameter("cuerpo");
        String tipo = request.getParameter("tipo");
        String estado = request.getParameter("estado");
        String[] categoriasIds = request.getParameterValues("categorias");
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            // Actualizar contenido existente
            int id = Integer.parseInt(idStr);
            Contenido contenido = new Contenido();
            contenido.setIdContenido(id);
            contenido.setTitulo(titulo);
            contenido.setCuerpo(cuerpo);
            contenido.setTipo(tipo);
            contenido.setEstado(estado);

            contenidoDAO.actualizar(contenido);

            // Actualizar categorías
            if (categoriasIds != null) {
                contenidoDAO.actualizarCategorias(id, categoriasIds);
            }
        } else {
            // Crear nuevo contenido
            Contenido contenido = new Contenido(titulo, cuerpo, tipo, usuario.getIdUsuario(), estado);
            int nuevoId = contenidoDAO.insertar(contenido);

            // Asignar categorías
            if (categoriasIds != null && nuevoId > 0) {
                contenidoDAO.actualizarCategorias(nuevoId, categoriasIds);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
