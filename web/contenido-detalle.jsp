<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${contenido.titulo} - Plataforma IAG</title>
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
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-secondary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
        }

        .back-link {
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .back-link:hover {
            opacity: 1;
        }

        .article {
            background: white;
            border-radius: 12px;
            padding: 3rem;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }

        .article-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 2rem;
            margin-bottom: 2rem;
        }

        .content-type {
            display: inline-block;
            padding: 0.4rem 1rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1rem;
            text-transform: uppercase;
        }

        .type-articulo { background: #e3f2fd; color: #1976d2; }
        .type-tip { background: #fff3e0; color: #f57c00; }
        .type-noticia { background: #fce4ec; color: #c2185b; }
        .type-tutorial { background: #e8f5e9; color: #388e3c; }
        .type-recurso { background: #f3e5f5; color: #7b1fa2; }

        .article-title {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
            line-height: 1.2;
        }

        .article-meta {
            display: flex;
            gap: 2rem;
            color: #666;
            font-size: 0.95rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .article-categories {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            margin: 1.5rem 0;
        }

        .category-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }

        .article-content {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #444;
        }

        .article-content p {
            margin-bottom: 1.5rem;
        }

        .article-footer {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 2px solid #f0f0f0;
            color: #999;
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
            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Contenidos</a>
            <c:choose>
                <c:when test="${sessionScope.usuario != null}">
                    <c:if test="${sessionScope.usuario.admin}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Panel Admin</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Cerrar Sesión</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Iniciar Sesión</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="container">
        <a href="${pageContext.request.contextPath}/home" class="back-link">
            ← Volver a contenidos
        </a>

        <article class="article">
            <div class="article-header">
                <span class="content-type type-${contenido.tipo}">${contenido.tipo}</span>

                <h1 class="article-title">${contenido.titulo}</h1>

                <div class="article-meta">
                    <div class="meta-item">
                        <span>👁️</span>
                        <span>${contenido.vistas} vistas</span>
                    </div>
                    <div class="meta-item">
                        <span>📅</span>
                        <span>
                            <fmt:formatDate value="${contenido.fechaPublicacion}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>
                    <c:if test="${not empty contenido.nombreAdmin}">
                        <div class="meta-item">
                            <span>✍️</span>
                            <span>${contenido.nombreAdmin}</span>
                        </div>
                    </c:if>
                </div>

                <div class="article-categories">
                    <c:forEach var="cat" items="${contenido.categorias}">
                        <span class="category-badge" style="background-color: ${cat.color}20; color: ${cat.color};">
                            ${cat.icono} ${cat.nombre}
                        </span>
                    </c:forEach>
                </div>
            </div>

            <div class="article-content">
                ${contenido.cuerpo.replaceAll("\n", "<br>")}
            </div>

            <div class="article-footer">
                <p>Última actualización: <fmt:formatDate value="${contenido.fechaPublicacion}" pattern="dd MMMM yyyy"/></p>
            </div>
        </article>
    </div>

    <footer>
        <p>© 2024 Plataforma IAG - Inteligencia Artificial Generativa</p>
    </footer>
</body>
</html>
