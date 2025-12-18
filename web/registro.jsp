<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Plataforma IAG</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-indigo-500 to-purple-600">
    <div class="bg-white w-full max-w-md rounded-xl shadow-2xl p-8">
        <h2 class="text-center text-3xl font-extrabold mb-6 bg-gradient-to-r from-indigo-500 to-purple-600 bg-clip-text text-transparent">
            🤖 Registro
        </h2>

        <p class="text-center text-gray-600 mb-8">
            Únete a la comunidad de IA Generativa
        </p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="mb-4 p-3 rounded-lg bg-red-100 text-red-700 text-sm">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/registro" class="space-y-5">
            <!-- Nombre completo -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Nombre Completo</label>
                <input
                    type="text"
                    name="nombre"
                    required
                    placeholder="Juan Pérez"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                >
            </div>

            <!-- Email -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input
                    type="email"
                    name="email"
                    required
                    placeholder="tu@email.com"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                >
            </div>

            <!-- Contraseña -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                <input
                    type="password"
                    name="password"
                    required
                    minlength="6"
                    placeholder="Mínimo 6 caracteres"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                >
            </div>

            <!-- Confirmar contraseña -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Confirmar Contraseña</label>
                <input
                    type="password"
                    name="confirmPassword"
                    required
                    minlength="6"
                    placeholder="Repite tu contraseña"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                >
            </div>

            <!-- Botón de registro -->
            <button
                type="submit"
                class="w-full py-3 rounded-lg bg-indigo-600 text-white font-semibold hover:bg-indigo-700 transition duration-300">
                Crear Cuenta
            </button>
        </form>

        <!-- Enlaces -->
        <p class="text-center text-sm text-gray-600 mt-6">
            ¿Ya tienes cuenta?
            <a href="${pageContext.request.contextPath}/login.jsp" class="text-indigo-600 hover:underline font-medium">
                Inicia sesión
            </a>
        </p>

        <p class="text-center text-sm mt-3">
            <a href="${pageContext.request.contextPath}/" class="text-gray-500 hover:underline">
                ← Volver al inicio
            </a>
        </p>
    </div>
</body>
</html>
