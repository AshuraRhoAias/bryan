<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro - Plataforma IAG</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body style="background: linear-gradient(135deg, #667eea, #764ba2); min-height: 100vh; display: flex; align-items: center; justify-content: center;">
    <div class="form-container" style="max-width: 400px; width: 90%;">
        <h2 style="text-align: center; margin-bottom: 2rem; background: linear-gradient(135deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Crear Cuenta</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <form method="post" action="${pageContext.request.contextPath}/registro">
            <div class="form-group">
                <label>Nombre Completo</label>
                <input type="text" name="nombre" required>
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label>Confirmar Contraseña</label>
                <input type="password" name="confirmPassword" required>
            </div>
            
            <button type="submit" class="btn btn-primary btn-block">Registrarse</button>
        </form>
        
        <p style="text-align: center; margin-top: 1.5rem;">
            ¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/login" style="color: #667eea;">Inicia sesión</a>
        </p>
    </div>
</body>
</html>
