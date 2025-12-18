# 🔧 CONFIGURACIÓN DEL PROYECTO EN NETBEANS

## 📁 Nombre del Proyecto
**PlataformaIAG** - Plataforma de Inteligencia Artificial Generativa

---

## ✅ REQUISITOS PREVIOS

### 1. Software Necesario
- **NetBeans IDE**: Versión 12.0 o superior (recomendado: Apache NetBeans 19+)
- **JDK**: Java Development Kit 21
- **Servidor de Aplicaciones**: GlassFish Server 8.0 o Apache Tomcat 10+
- **Base de Datos**: MySQL 8.0 o superior

### 2. Configuración de JDK en NetBeans
1. Abrir NetBeans
2. Ir a **Tools** → **Java Platforms**
3. Verificar que JDK 21 esté instalado
4. Si no está, hacer clic en **Add Platform** y seleccionar el directorio de instalación del JDK 21

### 3. Configuración del Servidor de Aplicaciones
1. Ir a **Tools** → **Servers**
2. Hacer clic en **Add Server**
3. Seleccionar **GlassFish Server** o **Apache Tomcat**
4. Seguir el asistente para configurar el servidor
5. Asegurarse de que el servidor esté iniciado correctamente

---

## 📂 ESTRUCTURA DEL PROYECTO

```
PlataformaIAG/
├── build/                  # Archivos compilados (generado automáticamente)
├── dist/                   # Archivo WAR de distribución (generado)
├── lib/                    # Librerías del proyecto
│   ├── CopyLibs/          # Tarea de copia de librerías
│   ├── mysql-connector-j-9.3.0/  # Driver MySQL
│   └── nblibraries.properties    # Configuración de librerías
├── nbproject/             # Configuración de NetBeans
│   ├── project.xml        # Definición del proyecto
│   ├── project.properties # Propiedades del proyecto
│   └── build-impl.xml     # Script de construcción Ant
├── src/
│   ├── java/              # Código fuente Java
│   │   ├── controller/    # Servlets (LoginServlet, HomeServlet, etc.)
│   │   ├── model/         # Clases modelo (Usuario, Contenido, Categoria)
│   │   ├── database/      # Conexión a base de datos
│   │   └── filter/        # Filtros (AuthFilter)
│   └── conf/              # Archivos de configuración
├── web/                   # Archivos web
│   ├── WEB-INF/          # Recursos protegidos
│   │   ├── web.xml       # Descriptor de despliegue
│   │   └── lib/          # Librerías del WAR
│   ├── admin/            # Páginas de administración
│   ├── index.html        # Página de inicio
│   ├── login.jsp         # Página de login
│   └── registro.jsp      # Página de registro
└── build.xml             # Script de construcción Ant
```

---

## 🚀 CÓMO ABRIR EL PROYECTO EN NETBEANS

### Opción 1: Abrir Proyecto Existente (RECOMENDADO)
1. Abrir NetBeans IDE
2. Ir a **File** → **Open Project** (o presionar `Ctrl + Shift + O`)
3. Navegar a la carpeta donde está el proyecto `PlataformaIAG`
4. Seleccionar la carpeta del proyecto (debe aparecer con el ícono de NetBeans)
5. Hacer clic en **Open Project**

### Opción 2: Importar desde Control de Versiones
1. Abrir NetBeans IDE
2. Ir a **Team** → **Git** → **Clone**
3. Ingresar la URL del repositorio
4. Seleccionar la carpeta de destino
5. El proyecto se abrirá automáticamente después de clonar

---

## ⚙️ CONFIGURACIÓN DE LA BASE DE DATOS

### 1. Crear la Base de Datos
Ejecutar el siguiente script SQL en MySQL:

```sql
CREATE DATABASE IF NOT EXISTS plataforma_iag CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE plataforma_iag;

-- Crear tablas según el esquema del proyecto
-- (Ver archivo SQL de inicialización si existe)
```

### 2. Configurar la Conexión
Editar el archivo `src/java/database/DatabaseConnection.java` con las credenciales correctas:

```java
private static final String URL = "jdbc:mysql://localhost:3306/plataforma_iag";
private static final String USER = "root";           // Tu usuario MySQL
private static final String PASSWORD = "tu_password"; // Tu contraseña MySQL
```

### 3. Verificar el Driver MySQL
El proyecto ya incluye el driver **MySQL Connector/J 9.3.0** en:
```
lib/mysql-connector-j-9.3.0/mysql-connector-j-9.3/mysql-connector-j-9.3.0.jar
```

---

## 🔨 COMPILAR Y EJECUTAR EL PROYECTO

### 1. Limpiar y Compilar
1. Hacer clic derecho en el proyecto en la pestaña **Projects**
2. Seleccionar **Clean and Build** (o presionar `Shift + F11`)
3. Esperar a que se complete la compilación

### 2. Ejecutar el Proyecto
1. Hacer clic derecho en el proyecto
2. Seleccionar **Run** (o presionar `F6`)
3. NetBeans desplegará automáticamente el proyecto en el servidor configurado
4. Se abrirá el navegador en la URL: `http://localhost:8080/PlataformaIAG/`

### 3. Depurar el Proyecto
1. Hacer clic derecho en el proyecto
2. Seleccionar **Debug** (o presionar `Ctrl + F5`)
3. Establecer puntos de interrupción en el código según sea necesario

---

## 🔧 SOLUCIÓN DE PROBLEMAS COMUNES

### Problema 1: "El servidor no está configurado"
**Solución:**
1. Ir a **Tools** → **Servers**
2. Agregar o configurar GlassFish/Tomcat
3. Asignar el servidor al proyecto:
   - Clic derecho en el proyecto → **Properties**
   - **Run** → Seleccionar el servidor

### Problema 2: "Error de compilación - MySQL Connector no encontrado"
**Solución:**
1. Verificar que el archivo JAR existe en `lib/mysql-connector-j-9.3.0/`
2. Clic derecho en el proyecto → **Properties**
3. **Libraries** → **Compile** → Verificar que MySQL Connector esté listado
4. Si no está, hacer clic en **Add JAR/Folder** y agregarlo

### Problema 3: "Error de conexión a la base de datos"
**Solución:**
1. Verificar que MySQL esté iniciado
2. Comprobar credenciales en `DatabaseConnection.java`
3. Verificar que la base de datos `plataforma_iag` exista
4. Probar conexión con MySQL Workbench o línea de comandos

### Problema 4: "Puerto 8080 ya en uso"
**Solución:**
1. Cambiar el puerto del servidor:
   - **Tools** → **Servers** → Seleccionar servidor
   - Cambiar el puerto HTTP (ej: 8081, 8082)
2. O detener la aplicación que esté usando el puerto 8080

### Problema 5: "Página 404 - No encontrada"
**Solución:**
1. Verificar que `index.html` esté en la carpeta `web/`
2. Comprobar `web.xml`:
   ```xml
   <welcome-file-list>
       <welcome-file>index.html</welcome-file>
   </welcome-file-list>
   ```
3. Limpiar y reconstruir el proyecto

---

## 📝 CONFIGURACIÓN DE JAVA

El proyecto está configurado para:
- **Source/Binary Format**: Java 21
- **Target**: Java 21
- **Encoding**: UTF-8

Para cambiar la versión de Java:
1. Clic derecho en el proyecto → **Properties**
2. **Sources** → Cambiar **Source/Binary Format**
3. **Build** → **Compile** → Ajustar opciones del compilador si es necesario

---

## 🌐 URLs DE LA APLICACIÓN

Después de ejecutar el proyecto, las siguientes URLs estarán disponibles:

| Página | URL | Descripción |
|--------|-----|-------------|
| Inicio | `/index.html` | Página de bienvenida |
| Login | `/login` | Inicio de sesión |
| Registro | `/registro` | Registro de usuarios |
| Home | `/home` | Explorar contenidos |
| Dashboard Admin | `/admin/dashboard` | Panel de administración |

**Credenciales de prueba** (si están configuradas):
- **Admin**: admin@example.com / admin123
- **Usuario**: user@example.com / user123

---

## 📚 TECNOLOGÍAS UTILIZADAS

- **Backend**: Java 21, Servlets, JSP
- **Frontend**: HTML5, CSS3, JavaScript
- **Base de Datos**: MySQL 8.0
- **Servidor**: GlassFish 8.0 / Tomcat 10+
- **Arquitectura**: MVC (Model-View-Controller)
- **Build Tool**: Apache Ant

---

## 📖 DOCUMENTACIÓN ADICIONAL

Para más información sobre el proyecto, consultar:
- `README.md` - Resumen general del proyecto
- `web/WEB-INF/web.xml` - Configuración del servlet
- Código fuente en `src/java/` - Javadoc disponible

---

## 💡 CONSEJOS PARA DESARROLLO

1. **Hot Deployment**: Activar "Deploy on Save" en las propiedades del proyecto para ver cambios inmediatamente
2. **Logs**: Ver logs del servidor en la pestaña **Output** de NetBeans
3. **Debugging**: Usar puntos de interrupción para depurar servlets y filtros
4. **Code Completion**: Usar `Ctrl + Space` para autocompletar código
5. **Refactoring**: Usar `Ctrl + R` para renombrar clases/métodos de forma segura

---

## ✅ VERIFICACIÓN DE CONFIGURACIÓN

Ejecutar esta lista de verificación:
- [ ] JDK 21 instalado y configurado en NetBeans
- [ ] Servidor de aplicaciones agregado y funcionando
- [ ] MySQL instalado y servicio iniciado
- [ ] Base de datos `plataforma_iag` creada
- [ ] Credenciales de BD actualizadas en `DatabaseConnection.java`
- [ ] Proyecto abre sin errores en NetBeans
- [ ] Compilación exitosa (Clean and Build)
- [ ] Proyecto se despliega correctamente en el servidor
- [ ] Página de inicio accesible en el navegador

---

**¡El proyecto está listo para desarrollar!** 🎉

Si encuentras algún problema no listado aquí, revisa los logs del servidor en NetBeans o consulta la documentación oficial.
