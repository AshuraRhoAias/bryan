<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${contenido.titulo} - Plataforma IAG</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#667eea',
                        secondary: '#764ba2'
                    }
                }
            }
        }
    </script>
</head>

<body class="min-h-screen bg-gradient-to-br from-primary to-secondary font-sans">

<!-- NAVBAR -->
<nav class="bg-white shadow-md px-6 py-4 flex justify-between items-center">
    <h1 class="text-2xl font-bold text-primary">🤖 Plataforma IAG</h1>

    <div class="flex gap-3 items-center">
        <a href="${pageContext.request.contextPath}/"
           class="px-4 py-2 rounded-lg border border-primary text-primary hover:bg-primary hover:text-white transition">
            Inicio
        </a>

        <a href="${pageContext.request.contextPath}/home"
           class="px-4 py-2 rounded-lg border border-primary text-primary hover:bg-primary hover:text-white transition">
            Contenidos
        </a>

        <c:choose>
            <c:when test="${sessionScope.usuario != null}">
                <c:if test="${sessionScope.usuario.admin}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="px-4 py-2 rounded-lg border border-primary text-primary hover:bg-primary hover:text-white transition">
                        Panel Admin
                    </a>
                </c:if>

                <a href="${pageContext.request.contextPath}/logout"
                   class="px-4 py-2 rounded-lg bg-primary text-white hover:bg-secondary transition">
                    Cerrar Sesión
                </a>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login"
                   class="px-4 py-2 rounded-lg bg-primary text-white hover:bg-secondary transition">
                    Iniciar Sesión
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- CONTENIDO -->
<main class="max-w-4xl mx-auto px-6 py-10">

    <a href="${pageContext.request.contextPath}/home"
       class="inline-block mb-6 text-white opacity-90 hover:opacity-100 transition">
        ← Volver a contenidos
    </a>

    <article class="bg-white rounded-2xl shadow-xl p-10">

        <!-- HEADER -->
        <header class="border-b pb-6 mb-6">

            <!-- Tipo -->
            <span class="inline-block mb-4 px-4 py-1 rounded-full text-sm font-semibold uppercase
                <c:choose>
                    <c:when test="${contenido.tipo == 'articulo'}">bg-blue-100 text-blue-700</c:when>
                    <c:when test="${contenido.tipo == 'tip'}">bg-orange-100 text-orange-700</c:when>
                    <c:when test="${contenido.tipo == 'noticia'}">bg-pink-100 text-pink-700</c:when>
                    <c:when test="${contenido.tipo == 'tutorial'}">bg-green-100 text-green-700</c:when>
                    <c:otherwise>bg-purple-100 text-purple-700</c:otherwise>
                </c:choose>
            ">
                ${contenido.tipo}
            </span>

            <!-- Título -->
            <h1 class="text-4xl font-bold text-gray-800 mb-4">
                ${contenido.titulo}
            </h1>

            <!-- Meta -->
            <div class="flex flex-wrap gap-6 text-gray-500 text-sm">
                <div class="flex items-center gap-1">
                    👁️ ${contenido.vistas} vistas
                </div>

                <div class="flex items-center gap-1">
                    📅
                    <fmt:formatDate value="${contenido.fechaPublicacion}" pattern="dd/MM/yyyy HH:mm"/>
                </div>

                <c:if test="${not empty contenido.nombreAdmin}">
                    <div class="flex items-center gap-1">
                        ✍️ ${contenido.nombreAdmin}
                    </div>
                </c:if>
            </div>

            <!-- Categorías -->
            <div class="flex flex-wrap gap-2 mt-4">
                <c:forEach var="cat" items="${contenido.categorias}">
                    <span class="px-3 py-1 rounded-full text-sm font-medium"
                          style="background-color: ${cat.color}20; color: ${cat.color};">
                        ${cat.icono} ${cat.nombre}
                    </span>
                </c:forEach>
            </div>
        </header>

        <!-- CUERPO -->
        <section class="prose max-w-none text-gray-700 leading-relaxed whitespace-pre-wrap">
            <c:out value="${contenido.cuerpo}"/>
        </section>

        <!-- FOOTER -->
        <footer class="border-t mt-10 pt-4 text-sm text-gray-400">
            Última actualización:
            <fmt:formatDate value="${contenido.fechaPublicacion}" pattern="dd MMMM yyyy"/>
        </footer>

    </article>
</main>

<!-- FOOTER GLOBAL -->
<footer class="text-center py-6 text-white opacity-80">
    © 2024 Plataforma IAG - Inteligencia Artificial Generativa
</footer>

</body>
</html>
