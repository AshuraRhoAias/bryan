<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Categorías - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 2rem;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 { color: #333; margin-bottom: 2rem; }
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 1rem;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #ccc;
            color: #333;
        }
        .card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: #f8f9fa;
            font-weight: bold;
            color: #555;
        }
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📁 Gestionar Categorías</h1>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
            ← Volver al Dashboard
        </a>

        <div class="card">
            <h2>Todas las Categorías</h2>

            <c:choose>
                <c:when test="${not empty categorias}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ícono</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Color</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${categorias}">
                                <tr>
                                    <td>${cat.idCategoria}</td>
                                    <td style="font-size: 1.5rem;">${cat.icono}</td>
                                    <td><strong>${cat.nombre}</strong></td>
                                    <td>${cat.descripcion}</td>
                                    <td>
                                        <span class="badge" style="background-color: ${cat.color}20; color: ${cat.color};">
                                            ${cat.color}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/categorias"
                                              method="post" style="display: inline;">
                                            <input type="hidden" name="accion" value="eliminar">
                                            <input type="hidden" name="id" value="${cat.idCategoria}">
                                            <button type="submit" class="btn-danger"
                                                    onclick="return confirm('¿Eliminar esta categoría?')">
                                                🗑️ Eliminar
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: #999; padding: 2rem;">
                        No hay categorías creadas.
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
