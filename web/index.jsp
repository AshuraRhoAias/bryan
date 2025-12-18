<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plataforma IAG - Inteligencia Artificial Generativa</title>
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
<body class="bg-gradient-to-br from-primary to-secondary min-h-screen flex items-center justify-center overflow-hidden">
    <div class="container mx-auto px-4">
        <div class="text-center text-white animate-fade-in">
            <!-- Logo y Título -->
            <div class="mb-8">
                <h1 class="text-6xl md:text-7xl font-bold mb-4 drop-shadow-lg animate-slide-down">
                    🤖 Plataforma IAG
                </h1>
                <p class="text-xl md:text-2xl opacity-95 animate-slide-up">
                    Descubre el mundo de la Inteligencia Artificial Generativa
                </p>
            </div>

            <!-- Botones principales -->
            <div class="flex flex-col md:flex-row gap-4 justify-center mb-16 animate-fade-in-delay">
                <a href="${pageContext.request.contextPath}/home"
                   class="bg-white text-primary px-8 py-4 rounded-full font-semibold text-lg shadow-xl hover:shadow-2xl hover:-translate-y-1 transition-all duration-300">
                    Explorar Contenidos
                </a>

                <c:choose>
                    <c:when test="${sessionScope.usuario != null}">
                        <c:choose>
                            <c:when test="${sessionScope.usuario.admin}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard"
                                   class="bg-transparent text-white border-2 border-white px-8 py-4 rounded-full font-semibold text-lg hover:bg-white hover:text-primary transition-all duration-300">
                                    Panel de Administración
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/home"
                                   class="bg-transparent text-white border-2 border-white px-8 py-4 rounded-full font-semibold text-lg hover:bg-white hover:text-primary transition-all duration-300">
                                    Mis Contenidos
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp"
                           class="bg-transparent text-white border-2 border-white px-8 py-4 rounded-full font-semibold text-lg hover:bg-white hover:text-primary transition-all duration-300">
                            Iniciar Sesión
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Features Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 max-w-6xl mx-auto animate-fade-in-delay-2">
                <!-- Feature 1: Texto -->
                <div class="bg-white bg-opacity-10 backdrop-blur-lg p-6 rounded-2xl hover:-translate-y-2 transition-all duration-300 hover:bg-opacity-20">
                    <div class="text-5xl mb-3">📝</div>
                    <h3 class="font-semibold text-lg mb-2">Texto Generativo</h3>
                    <p class="text-sm opacity-90">ChatGPT, Claude, Gemini y más</p>
                </div>

                <!-- Feature 2: Imagen -->
                <div class="bg-white bg-opacity-10 backdrop-blur-lg p-6 rounded-2xl hover:-translate-y-2 transition-all duration-300 hover:bg-opacity-20">
                    <div class="text-5xl mb-3">🎨</div>
                    <h3 class="font-semibold text-lg mb-2">Imagen Generativa</h3>
                    <p class="text-sm opacity-90">DALL-E, Midjourney, Stable Diffusion</p>
                </div>

                <!-- Feature 3: Audio/Video -->
                <div class="bg-white bg-opacity-10 backdrop-blur-lg p-6 rounded-2xl hover:-translate-y-2 transition-all duration-300 hover:bg-opacity-20">
                    <div class="text-5xl mb-3">🎵</div>
                    <h3 class="font-semibold text-lg mb-2">Audio & Video IA</h3>
                    <p class="text-sm opacity-90">Suno, ElevenLabs, Runway</p>
                </div>

                <!-- Feature 4: Código -->
                <div class="bg-white bg-opacity-10 backdrop-blur-lg p-6 rounded-2xl hover:-translate-y-2 transition-all duration-300 hover:bg-opacity-20">
                    <div class="text-5xl mb-3">💻</div>
                    <h3 class="font-semibold text-lg mb-2">Código & Desarrollo</h3>
                    <p class="text-sm opacity-90">GitHub Copilot, Cursor, Replit</p>
                </div>
            </div>

            <!-- User Info (si está logueado) -->
            <c:if test="${sessionScope.usuario != null}">
                <div class="mt-12 text-white opacity-90">
                    <p>Bienvenido, <span class="font-semibold">${sessionScope.usuario.nombre}</span></p>
                    <a href="${pageContext.request.contextPath}/logout" class="text-sm underline hover:no-underline">
                        Cerrar sesión
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <style>
        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes slide-down {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes slide-up {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .animate-fade-in {
            animation: fade-in 1s ease-in;
        }
        .animate-slide-down {
            animation: slide-down 1s ease-out;
        }
        .animate-slide-up {
            animation: slide-up 1s ease-out 0.3s both;
        }
        .animate-fade-in-delay {
            animation: fade-in 1s ease-in 0.6s both;
        }
        .animate-fade-in-delay-2 {
            animation: fade-in 1s ease-in 0.9s both;
        }
    </style>
</body>
</html>
