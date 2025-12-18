<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty contenido}">Editar</c:when><c:otherwise>Nuevo</c:otherwise></c:choose> Contenido - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 2rem;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        h1 { color: #333; margin-bottom: 2rem; }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #555;
        }
        input[type="text"], textarea, select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        textarea {
            min-height: 300px;
            resize: vertical;
        }
        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 0.5rem;
        }
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            margin-right: 1rem;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .btn-secondary {
            background: #ccc;
            color: #333;
        }
        .btn-secondary:hover {
            background: #bbb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>
            <c:choose>
                <c:when test="${not empty contenido}">✏️ Editar Contenido</c:when>
                <c:otherwise>➕ Nuevo Contenido</c:otherwise>
            </c:choose>
        </h1>

        <form action="${pageContext.request.contextPath}/admin/contenido/nuevo" method="post">
            <c:if test="${not empty contenido}">
                <input type="hidden" name="id" value="${contenido.idContenido}">
            </c:if>

            <div class="form-group">
                <label for="titulo">Título *</label>
                <input type="text" id="titulo" name="titulo"
                       value="${contenido.titulo}" required>
            </div>

            <div class="form-group">
                <label for="tipo">Tipo *</label>
                <select id="tipo" name="tipo" required>
                    <option value="articulo" ${contenido.tipo == 'articulo' ? 'selected' : ''}>Artículo</option>
                    <option value="tip" ${contenido.tipo == 'tip' ? 'selected' : ''}>Tip</option>
                    <option value="noticia" ${contenido.tipo == 'noticia' ? 'selected' : ''}>Noticia</option>
                    <option value="tutorial" ${contenido.tipo == 'tutorial' ? 'selected' : ''}>Tutorial</option>
                    <option value="recurso" ${contenido.tipo == 'recurso' ? 'selected' : ''}>Recurso</option>
                </select>
            </div>

            <div class="form-group">
                <label for="estado">Estado *</label>
                <select id="estado" name="estado" required>
                    <option value="publicado" ${contenido.estado == 'publicado' ? 'selected' : ''}>Publicado</option>
                    <option value="borrador" ${contenido.estado == 'borrador' ? 'selected' : ''}>Borrador</option>
                </select>
            </div>

            <div class="form-group">
                <label>Categorías</label>
                <div class="checkbox-group">
                    <c:forEach var="cat" items="${categorias}">
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_${cat.idCategoria}"
                                   name="categorias" value="${cat.idCategoria}">
                            <label for="cat_${cat.idCategoria}" style="margin: 0; font-weight: normal;">
                                ${cat.icono} ${cat.nombre}
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="form-group">
                <label for="cuerpo">Contenido *</label>
                <textarea id="cuerpo" name="cuerpo" required>${contenido.cuerpo}</textarea>
            </div>

            <div>
                <button type="submit" class="btn btn-primary">
                    💾 Guardar
                </button>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</body>
</html>
