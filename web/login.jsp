<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Plataforma IAG</title>

    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-indigo-500 to-purple-600">

    <div class="bg-white w-full max-w-md rounded-xl shadow-2xl p-8">

        <h2 class="text-center text-3xl font-extrabold mb-8 bg-gradient-to-r from-indigo-500 to-purple-600 bg-clip-text text-transparent">
            🤖 Plataforma IAG
        </h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="mb-4 p-3 rounded bg-red-100 text-red-700 text-sm">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
            <div class="mb-4 p-3 rounded bg-green-100 text-green-700 text-sm">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-5">

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input
                    type="email"
                    name="email"
                    required
                    placeholder="tu@email.com"
                    class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
                >
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                <input
                    type="password"
                    name="password"
                    required
                    placeholder="••••••••"
                    class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
                >
            </div>

            <button
                type="submit"
                class="w-full py-2 rounded-lg bg-indigo-600 text-white font-semibold hover:bg-indigo-700 transition">
                Iniciar Sesión
            </button>
        </form>

        <p class="text-center text-sm text-gray-600 mt-6">
            ¿No tienes cuenta?
            <a href="${pageContext.request.contextPath}/registro" class="text-indigo-600 hover:underline">
                Regístrate
            </a>
        </p>

        <p class="text-center text-sm mt-3">
            <a href="${pageContext.request.contextPath}/" class="text-gray-500 hover:underline">
                ← Volver al inicio
            </a>
        </p>

        <div class="mt-6 p-4 bg-gray-100 rounded-lg text-sm text-gray-700">
            <strong>🔑 Credenciales de prueba:</strong><br>
            Admin: admin@plataformaiag.com / admin123<br>
            Usuario: usuario@plataformaiag.com / user123
        </div>

    </div>

</body>
</html>
