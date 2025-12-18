<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Verificar que el usuario esté logueado y sea admin
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !usuario.isAdmin()) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Obtener datos del request
    @SuppressWarnings("unchecked")
    List<Contenido> contenidos = (List<Contenido>) request.getAttribute("contenidos");
    Integer totalContenidos = (Integer) request.getAttribute("totalContenidos");
    Integer totalCategorias = (Integer) request.getAttribute("totalCategorias");
    Integer totalUsuarios = (Integer) request.getAttribute("totalUsuarios");
    
    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");
    session.removeAttribute("success");
    session.removeAttribute("error");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Admin - Plataforma IAG</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f3f4f6;
            color: #1f2937;
        }
        
        /* Navbar */
        .navbar {
            background: white;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .navbar .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-brand {
            font-size: 1.5rem;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }
        
        .nav-menu a {
            color: #1f2937;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .nav-menu a:hover {
            color: #667eea;
        }
        
        .btn-logout {
            background: #ef4444;
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.3s;
        }
        
        .btn-logout:hover {
            background: #dc2626;
        }
        
        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 20px;
        }
        
        /* Header */
        .admin-header {
            margin-bottom: 2rem;
        }
        
        .admin-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: #1f2937;
        }
        
        .admin-header p {
            color: #6b7280;
        }
        
        /* Alertas */
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            animation: slideDown 0.3s ease-out;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border-left: 4px solid #10b981;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #ef4444;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .stat-card h3 {
            font-size: 2.5rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }
        
        .stat-card p {
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        /* Actions */
        .admin-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: #6b7280;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #4b5563;
        }
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .table-header {
            padding: 1.5rem;
            background: #f9fafb;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .table-header h2 {
            font-size: 1.5rem;
            color: #1f2937;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        
        th {
            background: #f9fafb;
            font-weight: 600;
            color: #374151;
            font-size: 0.875rem;
            text-transform: uppercase;
        }
        
        tr:hover {
            background: #f9fafb;
        }
        
        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .badge-success {
            background: #d1fae5;
            color: #065f46;
        }
        
        .badge-warning {
            background: #fef3c7;
            color: #92400e;
        }
        
        .badge-info {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .btn-action {
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.875rem;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }
        
        .btn-edit {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .btn-edit:hover {
            background: #bfdbfe;
        }
        
        .btn-delete {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .btn-delete:hover {
            background: #fecaca;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
        }
        
        .empty-state-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 600px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="container">
            <div class="nav-brand">🤖 Plataforma IAG - Admin</div>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Ver Sitio</a></li>
                <li><span style="color: #6b7280;">👤 <%= usuario.getNombre() %></span></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
                        <button type="submit" class="btn-logout">Cerrar Sesión</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>
    
    <!-- Main Container -->
    <div class="container">
        <!-- Header -->
        <div class="admin-header">
            <h1>📊 Panel de Administración</h1>
            <p>Gestiona contenidos, categorías y usuarios</p>
        </div>
        
        <!-- Alertas -->
        <% if (success != null) { %>
            <div class="alert alert-success">
                ✓ <%= success %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-error">
                ✗ <%= error %>
            </div>
        <% } %>
        
        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3><%= totalContenidos != null ? totalContenidos : 0 %></h3>
                <p>Contenidos</p>
            </div>
            <div class="stat-card">
                <h3><%= totalCategorias != null ? totalCategorias : 0 %></h3>
                <p>Categorías</p>
            </div>
            <div class="stat-card">
                <h3><%= totalUsuarios != null ? totalUsuarios : 0 %></h3>
                <p>Usuarios</p>
            </div>
        </div>
        
        <!-- Actions -->
        <div class="admin-actions">
            <a href="${pageContext.request.contextPath}/admin/contenido/nuevo" class="btn btn-primary">
                ➕ Nuevo Contenido
            </a>
            <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-secondary">
                📁 Gestionar Categorías
            </a>
        </div>
        
        <!-- Tabla de Contenidos -->
        <div class="table-container">
            <div class="table-header">
                <h2>Contenidos Recientes</h2>
            </div>
            
            <% if (contenidos != null && !contenidos.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th>Vistas</th>
                            <th>Fecha</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Contenido contenido : contenidos) { %>
                            <tr>
                                <td><%= contenido.getIdContenido() %></td>
                                <td><strong><%= contenido.getTitulo() %></strong></td>
                                <td>
                                    <span class="badge badge-info"><%= contenido.getTipo() %></span>
                                </td>
                                <td>
                                    <% if ("publicado".equals(contenido.getEstado())) { %>
                                        <span class="badge badge-success">Publicado</span>
                                    <% } else { %>
                                        <span class="badge badge-warning">Borrador</span>
                                    <% } %>
                                </td>
                                <td>👁️ <%= contenido.getVistas() %></td>
                                <td><%= sdf.format(contenido.getFechaPublicacion()) %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/contenido/editar?id=<%= contenido.getIdContenido() %>" 
                                       class="btn-action btn-edit">
                                        ✏️ Editar
                                    </a>
                                    <form action="${pageContext.request.contextPath}/admin/contenido/eliminar" 
                                          method="post" style="display: inline;"
                                          onsubmit="return confirm('¿Estás seguro de eliminar este contenido?');">
                                        <input type="hidden" name="id" value="<%= contenido.getIdContenido() %>">
                                        <button type="submit" class="btn-action btn-delete">
                                            🗑️ Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">📝</div>
                    <h3>No hay contenidos</h3>
                    <p>Crea tu primer contenido para comenzar</p>
                    <a href="${pageContext.request.contextPath}/admin/contenido/nuevo" class="btn btn-primary" style="margin-top: 1rem;">
                        ➕ Crear Contenido
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>