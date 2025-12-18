# 🚀 INSTRUCCIONES COMPLETAS - Plataforma IAG

## ✅ ¿Qué se ha completado?

He regenerado el proyecto desde cero con las siguientes mejoras:

### 📦 Archivos Creados/Actualizados:

1. **✨ index.jsp** - Nueva página principal con Tailwind CSS
2. **🎨 login.jsp** - Actualizado con Tailwind CSS y credenciales correctas
3. **🎨 registro.jsp** - Actualizado con Tailwind CSS
4. **🎨 home.jsp** - Actualizado para usar Tailwind CSS
5. **⚙️ web.xml** - COMPLETAMENTE configurado con TODOS los servlets mapeados
6. **📝 README.md** - Actualizado con Tailwind CSS y credenciales correctas
7. **🗄️ database/schema.sql** - Base de datos completa (ya existía)
8. **☕ DatabaseConnection.java** - Con reconexión automática (ya corregido)

### 🎯 Características Principales:

- ✅ **Tailwind CSS** integrado en todas las vistas JSP
- ✅ **Todos los servlets** correctamente mapeados en web.xml
- ✅ **Base de datos** con datos de prueba
- ✅ **Modelos y DAOs** con nombres de tablas en minúsculas (corregido)
- ✅ **Sistema de autenticación** completo
- ✅ **Panel de administración** funcional
- ✅ **Gestión de contenidos** completa

---

## 📋 PASO A PASO PARA EJECUTAR EL PROYECTO

### **PASO 1: Configurar la Base de Datos MySQL**

1. **Abrir MySQL Workbench o línea de comandos:**

```bash
mysql -u root -p
```

2. **Ejecutar el script de la base de datos:**

```sql
-- Opción A: Desde MySQL CLI
source /home/user/bryan/database/schema.sql;

-- Opción B: Desde terminal
mysql -u root -p < /home/user/bryan/database/schema.sql
```

3. **Verificar que la base de datos fue creada:**

```sql
USE plataforma_iag;
SHOW TABLES;
SELECT * FROM usuarios;
```

✅ **Deberías ver 3 usuarios de prueba:**
- `admin@plataformaiag.com` (Admin)
- `usuario@plataformaiag.com` (Usuario)
- `bryan@plataformaiag.com` (Developer/Admin)

---

### **PASO 2: Verificar Configuración de MySQL en Java**

El archivo `src/java/database/DatabaseConnection.java` debe tener:

```java
private static final String URL = "jdbc:mysql://localhost:3306/plataforma_iag?useSSL=false&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASSWORD = "";  // Tu contraseña de MySQL
```

⚠️ **Si tu contraseña de MySQL es diferente, actualízala aquí.**

---

### **PASO 3: Abrir el Proyecto en NetBeans**

1. **Abrir NetBeans IDE**
2. **File → Open Project**
3. **Seleccionar:** `/home/user/bryan`
4. **Clic en "Open Project"**

---

### **PASO 4: Configurar el Servidor (GlassFish)**

1. En NetBeans, ir a **Services** (Servicios)
2. Expandir **Servers** (Servidores)
3. Si NO tienes GlassFish Server:
   - Clic derecho en **Servers** → **Add Server**
   - Seleccionar **GlassFish Server**
   - Configurar el path de instalación
   - **Finish**

---

### **PASO 5: Clean and Build**

⚠️ **MUY IMPORTANTE:** Esto limpia cualquier archivo viejo y recompila todo.

1. **Clic derecho** en el proyecto **PlataformaIAG**
2. **Clean and Build** (`Shift + F11`)
3. Esperar a ver en la consola: **"BUILD SUCCESSFUL"**

**Errores comunes:**
- ❌ "No se encuentra mysql-connector" → Verificar que `lib/mysql-connector-j-9.3.0.jar` existe
- ❌ "Compilation failed" → Verificar JDK 21 instalado

---

### **PASO 6: Ejecutar el Proyecto**

⚠️ **IMPORTANTE: Usar RUN, NO Debug**

1. **Clic derecho** en el proyecto **PlataformaIAG**
2. **Run** (Presionar `F6`) ← **NO uses Debug (Ctrl+F5)**
3. GlassFish se iniciará automáticamente
4. El navegador se abrirá en: `http://localhost:8080/PlataformaIAG/`

**Si el puerto 8080 está ocupado:**
- Ir a Services → Servers → GlassFish Server
- Clic derecho → Properties
- Cambiar HTTP Port (por ejemplo, a 8888)

---

### **PASO 7: Probar la Aplicación**

#### **A. Página Principal (index.jsp)**

URL: `http://localhost:8080/PlataformaIAG/`

✅ Deberías ver:
- Título "🤖 Plataforma IAG"
- Botones con Tailwind CSS (diseño moderno)
- Features con iconos
- Gradiente de fondo

#### **B. Explorar Contenidos Públicos**

1. Clic en **"Explorar Contenidos"**
2. URL: `http://localhost:8080/PlataformaIAG/home`

✅ Deberías ver:
- 6 contenidos de ejemplo
- Filtros por categoría
- Cards con Tailwind CSS

#### **C. Login como Administrador**

1. Clic en **"Iniciar Sesión"**
2. URL: `http://localhost:8080/PlataformaIAG/login.jsp`
3. **Credenciales:**
   - Email: `admin@plataformaiag.com`
   - Contraseña: `admin123`
4. Clic en **"Iniciar Sesión"**

✅ Deberías ser redirigido a: `/admin/dashboard`

#### **D. Panel de Administración**

URL: `http://localhost:8080/PlataformaIAG/admin/dashboard`

✅ Deberías poder:
- Ver estadísticas de contenidos
- Crear nuevo contenido
- Editar contenidos existentes
- Gestionar categorías

#### **E. Ver Detalle de un Contenido**

1. Ir a **Explorar Contenidos**
2. Clic en cualquier artículo
3. URL: `http://localhost:8080/PlataformaIAG/contenido?id=1`

✅ Deberías ver:
- Título del contenido
- Cuerpo completo (con saltos de línea preservados)
- Categorías
- Vistas
- Fecha de publicación

---

## 🔑 Credenciales de Prueba

```
👨‍💼 ADMINISTRADOR:
Email: admin@plataformaiag.com
Contraseña: admin123
Acceso: Panel Admin completo

👤 USUARIO NORMAL:
Email: usuario@plataformaiag.com
Contraseña: user123
Acceso: Solo visualización

👨‍💻 DEVELOPER:
Email: bryan@plataformaiag.com
Contraseña: admin123
Acceso: Panel Admin completo
```

---

## 🗂️ Estructura de URLs

| URL | Descripción | Servlet | Acceso |
|-----|-------------|---------|--------|
| `/` o `/index.jsp` | Página principal | - | Público |
| `/login` | Iniciar sesión | LoginServlet | Público |
| `/registro` | Registrarse | RegistroServlet | Público |
| `/home` | Lista de contenidos | HomeServlet | Público |
| `/home?categoria=1` | Filtrar por categoría | HomeServlet | Público |
| `/contenido?id=1` | Detalle de contenido | ContenidoServlet | Público |
| `/admin/dashboard` | Panel admin | AdminDashboardServlet | Solo Admin |
| `/admin/contenido/nuevo` | Crear contenido | AdminContenidoServlet | Solo Admin |
| `/admin/contenido/editar?id=1` | Editar contenido | AdminContenidoServlet | Solo Admin |
| `/admin/categorias` | Gestionar categorías | AdminCategoriasServlet | Solo Admin |
| `/logout` | Cerrar sesión | LogoutServlet | Autenticado |

---

## ⚙️ Archivos Críticos del Proyecto

### **1. web.xml** (`web/WEB-INF/web.xml`)
✅ Todos los servlets están mapeados correctamente:
- LoginServlet → `/login`
- RegistroServlet → `/registro`
- LogoutServlet → `/logout`
- HomeServlet → `/home`
- ContenidoServlet → `/contenido`
- CategoriaServlet → `/categorias`
- AdminDashboardServlet → `/admin/dashboard`
- AdminContenidoServlet → `/admin/contenido/*`
- AdminCategoriasServlet → `/admin/categorias`

### **2. DatabaseConnection.java** (`src/java/database/DatabaseConnection.java`)
✅ Singleton con reconexión automática
✅ Retorna nueva conexión si la anterior se cerró

### **3. DAOs** (`src/java/model/`)
✅ **UsuarioDAO.java** - Usa tabla `usuarios` (minúsculas)
✅ **ContenidoDAO.java** - Usa tabla `contenidos` (minúsculas)
✅ **CategoriaDAO.java** - Usa tabla `categorias` (minúsculas)

### **4. JSPs con Tailwind CSS**
✅ **index.jsp** - CDN de Tailwind incluido
✅ **login.jsp** - CDN de Tailwind incluido
✅ **registro.jsp** - CDN de Tailwind incluido
✅ **home.jsp** - CDN de Tailwind incluido
✅ **contenido-detalle.jsp** - Sin error de `replaceAll()`

---

## 🐛 Solución de Problemas

### ❌ Error: "HTTP Status 404 - Not Found"

**Causa:** web.xml no está configurado o el servlet no existe.

**Solución:**
1. Verificar que `web/WEB-INF/web.xml` tenga todos los servlets mapeados
2. Hacer **Clean and Build**
3. Reiniciar el servidor

---

### ❌ Error: "Connection refused" o "No suitable driver"

**Causa:** MySQL no está corriendo o el driver no está en el classpath.

**Solución:**
1. Verificar que MySQL esté corriendo: `sudo service mysql status`
2. Verificar que `lib/mysql-connector-j-9.3.0.jar` existe
3. Hacer **Clean and Build**

---

### ❌ Error: "Null Pointer Exception - connection is null"

**Causa:** La base de datos `plataforma_iag` no existe.

**Solución:**
```bash
mysql -u root -p < /home/user/bryan/database/schema.sql
```

---

### ❌ Error: "Table 'plataforma_iag.Usuarios' doesn't exist"

**Causa:** DAO usa nombres de tablas en mayúsculas.

**Solución:**
✅ **YA ESTÁ CORREGIDO** - Todos los DAOs usan minúsculas (`usuarios`, `contenidos`, `categorias`)

---

### ❌ Error: "jakarta.el.MethodNotFoundException: replaceAll()"

**Causa:** JSP intenta usar `replaceAll()` en Expression Language.

**Solución:**
✅ **YA ESTÁ CORREGIDO** - `contenido-detalle.jsp` usa `<c:out>` con `white-space: pre-wrap`

---

### ❌ El navegador abre `WebApplication1` en lugar de `PlataformaIAG`

**Causa:** Deployment viejo en GlassFish.

**Solución:**
1. Detener GlassFish
2. Ir a `~/GlassFish_Server/glassfish/domains/domain1/applications/`
3. Eliminar carpeta `WebApplication1`
4. Hacer **Clean and Build**
5. **Run** de nuevo

---

## 📊 Estadísticas del Proyecto

```
📁 Archivos Java: 20+
📁 Archivos JSP: 10+
📁 Servlets: 9
📁 Modelos: 3
📁 DAOs: 3
📁 Tablas MySQL: 4
```

---

## 🎉 ¡Listo para Producción!

El proyecto está completamente funcional con:

✅ Tailwind CSS en todas las vistas
✅ Todos los servlets mapeados
✅ Base de datos configurada
✅ Sistema de autenticación
✅ Panel de administración
✅ CRUD completo de contenidos
✅ Gestión de categorías
✅ Filtros y búsqueda
✅ Contador de vistas

---

## 📞 Soporte

Si encuentras algún problema:

1. Revisa la sección **"Solución de Problemas"** arriba
2. Verifica los logs de GlassFish en la consola de NetBeans
3. Verifica que MySQL esté corriendo
4. Verifica credenciales en `DatabaseConnection.java`

---

**🌟 ¡Disfruta tu Plataforma IAG con Tailwind CSS!**

---

*Última actualización: 2025 - Rebuild completo con Tailwind CSS*
