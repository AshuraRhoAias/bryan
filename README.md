# 🤖 Plataforma IAG - Inteligencia Artificial Generativa

![Java](https://img.shields.io/badge/Java-21-orange)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-11-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Plataforma web de gestión de contenidos sobre Inteligencia Artificial Generativa, desarrollada con Java EE, JSP y MySQL.

---

## 📋 Descripción del Proyecto

La **Plataforma IAG** es una aplicación web completa que permite:

- ✅ Gestión de contenidos educativos sobre IA Generativa
- ✅ Sistema de autenticación y autorización de usuarios
- ✅ Panel de administración para gestión de contenidos
- ✅ Categorización de contenidos (Texto, Imagen, Audio/Video, Código)
- ✅ Visualización pública de contenidos publicados
- ✅ Sistema de vistas y estadísticas
- ✅ Arquitectura MVC con Servlets y JSP

---

## 🌐 Funcionalidades Principales

### Para Usuarios Públicos
- 🏠 **Página de Inicio**: Bienvenida e introducción a la plataforma
- 📚 **Explorar Contenidos**: Navegación y búsqueda de artículos, tutoriales, tips y noticias
- 🔍 **Filtrado por Categorías**: Filtros dinámicos por tipo de contenido
- 📖 **Vista Detallada**: Lectura completa de contenidos con contador de vistas
- 👤 **Registro y Login**: Sistema de autenticación de usuarios

### Para Administradores
- 📊 **Dashboard Admin**: Panel de control con estadísticas
- ➕ **Crear Contenidos**: Formulario completo para nuevos artículos
- ✏️ **Editar Contenidos**: Modificación de contenidos existentes
- 🗑️ **Eliminar Contenidos**: Gestión de contenidos obsoletos
- 📁 **Gestionar Categorías**: Administración de categorías y etiquetas
- 🔐 **Control de Acceso**: Sistema de roles (Admin/Usuario)

---

## 🛠️ Tecnologías Utilizadas

| Componente | Tecnología |
|------------|------------|
| **Backend** | Java 21, Jakarta Servlets, JSP |
| **Frontend** | HTML5, CSS3, JavaScript |
| **Base de Datos** | MySQL 8.0 |
| **Servidor** | GlassFish 8.0 / Apache Tomcat 10+ |
| **Build Tool** | Apache Ant |
| **IDE** | Apache NetBeans 19+ |
| **Arquitectura** | MVC (Model-View-Controller) |
| **Driver BD** | MySQL Connector/J 9.3.0 |

---

## 📂 Estructura del Proyecto

```
PlataformaIAG/
├── src/java/
│   ├── controller/           # Servlets controladores
│   │   ├── LoginServlet.java
│   │   ├── RegistroServlet.java
│   │   ├── HomeServlet.java
│   │   ├── ContenidoServlet.java
│   │   ├── CategoriaServlet.java
│   │   ├── LogoutServlet.java
│   │   └── admin/
│   │       └── AdminDashboardServlet.java
│   ├── model/                # Modelos y DAOs
│   │   ├── Usuario.java
│   │   ├── UsuarioDAO.java
│   │   ├── Contenido.java
│   │   ├── ContenidoDAO.java
│   │   ├── Categoria.java
│   │   └── CategoriaDAO.java
│   ├── database/             # Conexión a BD
│   │   └── DatabaseConnection.java
│   └── filter/               # Filtros
│       └── AuthFilter.java
├── web/
│   ├── WEB-INF/
│   │   ├── web.xml          # Descriptor de despliegue
│   │   └── lib/             # Librerías del WAR
│   ├── admin/               # Páginas admin
│   │   └── dashboard.jsp
│   ├── index.html           # Página principal
│   ├── login.jsp            # Login
│   └── registro.jsp         # Registro
├── lib/                     # Librerías del proyecto
│   └── mysql-connector-j-9.3.0/
├── nbproject/               # Configuración NetBeans
├── build.xml                # Script Ant
└── CONFIGURACION_NETBEANS.md  # Guía de configuración
```

---

## 🚀 Instalación y Configuración

### Prerrequisitos
- ☕ **JDK 21** instalado
- 🌐 **NetBeans IDE** (versión 12+)
- 🖥️ **MySQL Server 8.0+**
- 🚀 **GlassFish 8.0** o **Apache Tomcat 10+**

### Paso 1: Clonar el Repositorio
```bash
git clone <url-del-repositorio>
cd PlataformaIAG
```

### Paso 2: Configurar Base de Datos
1. Crear la base de datos:
```sql
CREATE DATABASE plataforma_iag CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. Importar el esquema (si existe un archivo SQL):
```bash
mysql -u root -p plataforma_iag < database/schema.sql
```

3. Actualizar credenciales en `src/java/database/DatabaseConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/plataforma_iag";
private static final String USER = "tu_usuario";
private static final String PASSWORD = "tu_contraseña";
```

### Paso 3: Abrir en NetBeans
1. Abrir **NetBeans IDE**
2. **File** → **Open Project**
3. Seleccionar la carpeta `PlataformaIAG`
4. Hacer clic en **Open Project**

### Paso 4: Configurar Servidor
1. **Tools** → **Servers** → **Add Server**
2. Seleccionar **GlassFish Server** o **Tomcat**
3. Configurar puerto (default: 8080)

### Paso 5: Compilar y Ejecutar
1. Clic derecho en el proyecto → **Clean and Build** (`Shift + F11`)
2. Clic derecho en el proyecto → **Run** (`F6`)
3. La aplicación se abrirá en: `http://localhost:8080/PlataformaIAG/`

---

## 📖 Guía de Uso

### Para Usuarios Públicos

1. **Acceder a la plataforma**: Ir a `http://localhost:8080/PlataformaIAG/`
2. **Registrarse**: Clic en "Registrarse" y completar formulario
3. **Iniciar sesión**: Usar email y contraseña registrados
4. **Explorar contenidos**: Navegar por artículos, filtrar por categoría
5. **Leer contenido completo**: Clic en cualquier artículo para ver detalle

### Para Administradores

1. **Iniciar sesión como admin**: Usar credenciales de administrador
2. **Acceder al dashboard**: Automáticamente redirigido a `/admin/dashboard`
3. **Crear contenido**: Clic en "Nuevo Contenido" → Completar formulario
4. **Editar contenido**: Clic en "Editar" en cualquier contenido
5. **Gestionar categorías**: Administrar etiquetas y clasificaciones

### Credenciales de Prueba
```
Admin:
  Email: admin@example.com
  Contraseña: admin123

Usuario:
  Email: user@example.com
  Contraseña: user123
```

---

## 🔐 Seguridad

- 🔒 **Contraseñas hasheadas** con SHA-256
- 🛡️ **Filtro de autenticación** en rutas `/admin/*`
- 🚫 **Control de acceso basado en roles**
- 🔑 **Sesiones de usuario** con HttpSession
- ✅ **Validación de formularios** en cliente y servidor
- 🔐 **Protección contra inyección SQL** con PreparedStatements

---

## 📄 Páginas de la Aplicación

| Ruta | Descripción | Acceso |
|------|-------------|--------|
| `/index.html` | Página de bienvenida | Público |
| `/login` | Inicio de sesión | Público |
| `/registro` | Registro de usuarios | Público |
| `/home` | Explorar contenidos | Público |
| `/contenido?id=X` | Detalle de contenido | Público |
| `/admin/dashboard` | Panel de administración | Solo Admin |
| `/admin/contenido/nuevo` | Crear contenido | Solo Admin |
| `/admin/contenido/editar?id=X` | Editar contenido | Solo Admin |
| `/admin/categorias` | Gestionar categorías | Solo Admin |

---

## 🗃️ Modelo de Datos

### Tablas Principales

**usuarios**
- id (INT, PK, AUTO_INCREMENT)
- nombre (VARCHAR)
- email (VARCHAR, UNIQUE)
- password (VARCHAR, hasheada)
- rol (ENUM: 'admin', 'usuario')
- fecha_registro (DATETIME)

**contenidos**
- id (INT, PK, AUTO_INCREMENT)
- titulo (VARCHAR)
- contenido (TEXT)
- tipo (ENUM: 'artículo', 'tip', 'noticia', 'tutorial', 'recurso')
- estado (ENUM: 'publicado', 'borrador')
- vistas (INT)
- fecha_publicacion (DATETIME)
- autor_id (INT, FK → usuarios)

**categorias**
- id (INT, PK, AUTO_INCREMENT)
- nombre (VARCHAR)
- descripcion (TEXT)
- icono (VARCHAR)
- color (VARCHAR)

**contenido_categorias** (Tabla intermedia)
- contenido_id (INT, FK → contenidos)
- categoria_id (INT, FK → categorias)

---

## 🧪 Testing

```bash
# Ejecutar tests unitarios
ant test

# Ejecutar tests de integración
ant integration-test
```

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

---

## 📝 Documentación Adicional

- 📘 [Guía de Configuración de NetBeans](CONFIGURACION_NETBEANS.md)
- 📗 [Arquitectura del Sistema](docs/ARQUITECTURA.md) *(si existe)*
- 📕 [API Reference](docs/API.md) *(si existe)*

---

## 🐛 Solución de Problemas

Ver [CONFIGURACION_NETBEANS.md](CONFIGURACION_NETBEANS.md) sección "Solución de Problemas Comunes"

---

## 📜 Licencia

Este proyecto está bajo la Licencia MIT. Ver archivo `LICENSE` para más detalles.

---

## 👥 Autores

- **Nombre del Autor** - *Desarrollo inicial* - [GitHub](https://github.com/usuario)

---

## 🙏 Agradecimientos

- Comunidad de NetBeans
- Documentación de Jakarta EE
- Equipo de MySQL

---

## 📞 Contacto

- 📧 Email: contacto@plataformaiag.com
- 🌐 Website: https://plataformaiag.com
- 💬 Issues: [GitHub Issues](https://github.com/usuario/PlataformaIAG/issues)

---

**⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub!**

---

*Última actualización: 2024*
