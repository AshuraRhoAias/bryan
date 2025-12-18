<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explorar Contenidos - Plataforma IAG</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .navbar {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            color: #667eea;
            font-size: 1.5rem;
        }

        .nav-links {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .hero {
            text-align: center;
            color: white;
            padding: 3rem 0;
        }

        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.2rem;
            opacity: 0.9;
        }

        .filters {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .filters h3 {
            color: #333;
            margin-bottom: 1rem;
        }

        .filter-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .filter-tag {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s;
            border: 2px solid #e0e0e0;
            background: white;
            color: #666;
        }

        .filter-tag:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .filter-tag.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .content-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }

        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .content-type {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
            text-transform: uppercase;
        }

        .type-articulo { background: #e3f2fd; color: #1976d2; }
        .type-tip { background: #fff3e0; color: #f57c00; }
        .type-noticia { background: #fce4ec; color: #c2185b; }
        .type-tutorial { background: #e8f5e9; color: #388e3c; }
        .type-recurso { background: #f3e5f5; color: #7b1fa2; }

        .content-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 0.75rem;
            cursor: pointer;
            text-decoration: none;
            display: block;
            color: #333;
        }

        .content-title:hover {
            color: #667eea;
        }

        .content-excerpt {
            color: #666;
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .content-categories {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .category-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.85rem;
        }

        .content-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            color: #999;
            font-size: 0.9rem;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 12px;
        }

        .empty-state h3 {
            color: #666;
            margin-bottom: 0.5rem;
        }

        footer {
            text-align: center;
            padding: 2rem;
            color: white;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <h1>🤖 Plataforma IAG</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Inicio</a>
            <c:choose>
                <c:when test="${sessionScope.usuario != null}">
                    <c:if test="${sessionScope.usuario.admin}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Panel Admin</a>
                    </c:if>
                    <span style="color: #667eea;">Hola, ${sessionScope.usuario.nombre}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Cerrar Sesión</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Iniciar Sesión</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="container">
        <!-- Hero Section -->
        <div class="hero">
            <h2>Explora Contenidos de IA Generativa</h2>
            <p>Descubre artículos, tutoriales y recursos sobre inteligencia artificial</p>
        </div>

        <!-- Filtros -->
        <div class="filters">
            <h3>📁 Filtrar por categoría</h3>
            <div class="filter-tags">
                <a href="${pageContext.request.contextPath}/home"
                   class="filter-tag ${empty param.categoria ? 'active' : ''}">
                    Todas
                </a>
                <c:forEach var="cat" items="${categorias}">
                    <a href="${pageContext.request.contextPath}/home?categoria=${cat.idCategoria}"
                       class="filter-tag ${param.categoria == cat.idCategoria ? 'active' : ''}"
                       style="background-color: ${cat.color}20; color: ${cat.color}; border-color: ${cat.color};">
                        ${cat.icono} ${cat.nombre}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Grid de Contenidos -->
        <c:choose>
            <c:when test="${not empty contenidos}">
                <div class="content-grid">
                    <c:forEach var="cont" items="${contenidos}">
                        <div class="content-card">
                            <span class="content-type type-${cont.tipo}">${cont.tipo}</span>

                            <a href="${pageContext.request.contextPath}/contenido?id=${cont.idContenido}"
                               class="content-title">
                                ${cont.titulo}
                            </a>

                            <p class="content-excerpt">
                                <c:choose>
                                    <c:when test="${cont.cuerpo.length() > 150}">
                                        ${cont.cuerpo.substring(0, 150)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${cont.cuerpo}
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <div class="content-categories">
                                <c:forEach var="cat" items="${cont.categorias}">
                                    <span class="category-badge" style="background-color: ${cat.color}20; color: ${cat.color};">
                                        ${cat.icono} ${cat.nombre}
                                    </span>
                                </c:forEach>
                            </div>

                            <div class="content-meta">
                                <span>👁️ ${cont.vistas} vistas</span>
                                <span>
                                    <fmt:formatDate value="${cont.fechaPublicacion}" pattern="dd/MM/yyyy"/>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>📭 No hay contenidos disponibles</h3>
                    <p>No se encontraron contenidos en esta categoría.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer>
        <p>© 2024 Plataforma IAG - Inteligencia Artificial Generativa</p>
        <p>Todos los derechos reservados</p>
    </footer>
</body>
</html>
