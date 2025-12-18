# 🗄️ CONFIGURACIÓN DE LA BASE DE DATOS - PLATAFORMA IAG

## 📋 Descripción

Este documento explica cómo configurar la base de datos MySQL para la Plataforma IAG.

---

## ⚠️ ERROR ACTUAL: Connection is null

Si estás viendo el error:
```
java.lang.NullPointerException: Cannot invoke "java.sql.Connection.prepareStatement(String)" because "conn" is null
```

**Significa que:** La aplicación no puede conectarse a MySQL. Sigue los pasos a continuación para resolver el problema.

---

## ✅ SOLUCIÓN PASO A PASO

### **Paso 1: Verificar que MySQL esté instalado e iniciado**

#### Windows
1. Abrir **Servicios** (tecla Windows + R → escribir `services.msc`)
2. Buscar **MySQL** o **MySQL80**
3. Verificar que el estado sea **"Iniciado"** o **"Running"**
4. Si no está iniciado, clic derecho → **Iniciar**

#### Linux/Mac
```bash
# Verificar si MySQL está ejecutándose
sudo systemctl status mysql

# Si no está iniciado, iniciarlo
sudo systemctl start mysql

# Para Mac con Homebrew
brew services start mysql
```

#### Alternativa: XAMPP/WAMP
Si usas **XAMPP** o **WAMP**:
1. Abrir el panel de control
2. Iniciar el servicio **MySQL**
3. Verificar que el puerto sea **3306**

---

### **Paso 2: Verificar acceso a MySQL**

Abre una terminal o cmd y ejecuta:

```bash
mysql -u root -p
```

- Si te pide contraseña, ingrésala
- Si tu MySQL **NO tiene contraseña**, solo presiona Enter
- Si puedes entrar a MySQL, significa que está funcionando

**Para salir de MySQL:**
```sql
exit;
```

---

### **Paso 3: Crear la base de datos**

Tienes **DOS OPCIONES** para crear la base de datos:

#### **Opción A: Usando la línea de comandos (RECOMENDADO)**

```bash
# Navegar a la carpeta del proyecto
cd /ruta/a/tu/proyecto/bryan

# Ejecutar el script SQL
mysql -u root -p < database/schema.sql
```

Si tu MySQL **no tiene contraseña**:
```bash
mysql -u root < database/schema.sql
```

#### **Opción B: Usando MySQL Workbench o phpMyAdmin**

**Con MySQL Workbench:**
1. Abrir MySQL Workbench
2. Conectar a tu servidor local (root@localhost)
3. **File → Open SQL Script**
4. Seleccionar `database/schema.sql`
5. Ejecutar el script (⚡ icono de rayo o Ctrl+Shift+Enter)

**Con phpMyAdmin (si usas XAMPP/WAMP):**
1. Abrir `http://localhost/phpmyadmin`
2. Ir a la pestaña **SQL**
3. Copiar y pegar el contenido de `database/schema.sql`
4. Clic en **Ejecutar** o **Go**

---

### **Paso 4: Verificar que la base de datos se creó correctamente**

```bash
mysql -u root -p
```

Luego dentro de MySQL:
```sql
-- Mostrar todas las bases de datos
SHOW DATABASES;

-- Debería aparecer 'plataforma_iag'

-- Usar la base de datos
USE plataforma_iag;

-- Ver las tablas creadas
SHOW TABLES;

-- Debería mostrar:
-- +---------------------------+
-- | Tables_in_plataforma_iag  |
-- +---------------------------+
-- | categorias                |
-- | contenido_categorias      |
-- | contenidos                |
-- | usuarios                  |
-- +---------------------------+

-- Verificar que hay datos
SELECT * FROM usuarios;
SELECT * FROM categorias;
SELECT * FROM contenidos;

-- Salir
exit;
```

---

### **Paso 5: Configurar credenciales en el código (si es necesario)**

Si tu MySQL **tiene contraseña**, actualiza el archivo:
```
src/java/database/DatabaseConnection.java
```

**Líneas 16-17:**
```java
private static final String USER = "root";        // Tu usuario de MySQL
private static final String PASSWORD = "";         // Tu contraseña de MySQL
```

**Ejemplo con contraseña:**
```java
private static final String USER = "root";
private static final String PASSWORD = "miContraseña123";
```

---

### **Paso 6: Limpiar y recompilar el proyecto en NetBeans**

1. Clic derecho en el proyecto **PlataformaIAG**
2. **Clean and Build** (o `Shift + F11`)
3. Esperar a que compile sin errores
4. **Run** (o `F6`)

---

## 🎯 VERIFICACIÓN FINAL

Si todo está correcto, deberías ver en los logs de GlassFish/Tomcat:

```
========================================
✓ CONEXIÓN A BASE DE DATOS ESTABLECIDA
  Base de datos: plataforma_iag
  URL: jdbc:mysql://localhost:3306/plataforma_iag?useSSL=false&serverTimezone=UTC
  Usuario: root
========================================
```

Y la aplicación debería funcionar correctamente en:
```
http://localhost:8080/PlataformaIAG/
```

---

## 🔑 CREDENCIALES DE PRUEBA

Una vez que la base de datos esté creada, puedes usar estas credenciales para entrar:

### **Administradores:**
| Email | Contraseña | Descripción |
|-------|------------|-------------|
| `admin@plataformaiag.com` | `admin123` | Administrador principal |
| `bryan@plataformaiag.com` | `admin123` | Admin developer |

### **Usuario Normal:**
| Email | Contraseña | Descripción |
|-------|------------|-------------|
| `usuario@plataformaiag.com` | `user123` | Usuario de prueba |

---

## 📊 ESTRUCTURA DE LA BASE DE DATOS

### **Tablas:**

1. **usuarios**
   - `id_usuario` (INT, PK, AUTO_INCREMENT)
   - `nombre` (VARCHAR)
   - `email` (VARCHAR, UNIQUE)
   - `password_hash` (VARCHAR) - Contraseñas hasheadas con SHA-256
   - `rol` (ENUM: 'admin', 'usuario')
   - `fecha_registro` (TIMESTAMP)

2. **categorias**
   - `id_categoria` (INT, PK, AUTO_INCREMENT)
   - `nombre` (VARCHAR, UNIQUE)
   - `descripcion` (TEXT)
   - `icono` (VARCHAR) - Emoji
   - `color` (VARCHAR) - Código hexadecimal

3. **contenidos**
   - `id_contenido` (INT, PK, AUTO_INCREMENT)
   - `titulo` (VARCHAR)
   - `cuerpo` (TEXT)
   - `tipo` (ENUM: 'articulo', 'tip', 'noticia', 'tutorial', 'recurso')
   - `estado` (ENUM: 'publicado', 'borrador')
   - `vistas` (INT)
   - `fecha_publicacion` (TIMESTAMP)
   - `id_admin` (INT, FK → usuarios)

4. **contenido_categorias** (Tabla intermedia)
   - `contenido_id` (INT, FK → contenidos)
   - `categoria_id` (INT, FK → categorias)

---

## 🧪 DATOS DE PRUEBA INCLUIDOS

El script `schema.sql` incluye:

- ✅ **3 usuarios** (2 admins, 1 usuario normal)
- ✅ **6 categorías** (Texto, Imagen, Audio/Video, Código, Chatbots, Análisis de Datos)
- ✅ **6 contenidos** de ejemplo (5 publicados, 1 borrador)
- ✅ Relaciones entre contenidos y categorías

---

## 🐛 SOLUCIÓN DE PROBLEMAS COMUNES

### **Problema 1: "Access denied for user 'root'@'localhost'"**
**Causa:** Contraseña incorrecta
**Solución:**
1. Verificar la contraseña de MySQL
2. Actualizar `DatabaseConnection.java` con la contraseña correcta
3. Limpiar y recompilar (Clean and Build)

---

### **Problema 2: "Unknown database 'plataforma_iag'"**
**Causa:** La base de datos no existe
**Solución:**
```bash
mysql -u root -p < database/schema.sql
```

---

### **Problema 3: "Communications link failure"**
**Causa:** MySQL no está ejecutándose
**Solución:**
- **Windows:** Iniciar servicio MySQL en Servicios
- **Linux/Mac:** `sudo systemctl start mysql`
- **XAMPP/WAMP:** Iniciar MySQL desde el panel

---

### **Problema 4: "Table 'plataforma_iag.usuarios' doesn't exist"**
**Causa:** El script no se ejecutó completamente
**Solución:**
1. Borrar la base de datos:
```sql
DROP DATABASE plataforma_iag;
```
2. Volver a ejecutar el script completo:
```bash
mysql -u root -p < database/schema.sql
```

---

### **Problema 5: Puerto 3306 ocupado**
**Causa:** Otro proceso está usando el puerto
**Solución:**
1. Verificar qué proceso usa el puerto:
```bash
# Windows
netstat -ano | findstr :3306

# Linux/Mac
sudo lsof -i :3306
```
2. Detener el proceso o cambiar el puerto de MySQL

---

## 🔧 COMANDOS ÚTILES

### **Verificar estado de MySQL:**
```bash
# Linux
sudo systemctl status mysql

# Ver logs de MySQL
sudo tail -f /var/log/mysql/error.log
```

### **Reiniciar MySQL:**
```bash
# Linux
sudo systemctl restart mysql

# Mac
brew services restart mysql

# Windows (como administrador)
net stop MySQL80
net start MySQL80
```

### **Crear backup de la base de datos:**
```bash
mysqldump -u root -p plataforma_iag > backup_plataforma_iag.sql
```

### **Restaurar desde backup:**
```bash
mysql -u root -p plataforma_iag < backup_plataforma_iag.sql
```

---

## 📚 RECURSOS ADICIONALES

- **Documentación MySQL:** https://dev.mysql.com/doc/
- **MySQL Workbench:** https://www.mysql.com/products/workbench/
- **phpMyAdmin:** https://www.phpmyadmin.net/
- **XAMPP:** https://www.apachefriends.org/

---

## ✅ CHECKLIST DE CONFIGURACIÓN

Antes de ejecutar la aplicación, asegúrate de:

- [ ] MySQL está instalado
- [ ] MySQL está ejecutándose (puerto 3306)
- [ ] Puedes acceder con `mysql -u root -p`
- [ ] Base de datos `plataforma_iag` creada
- [ ] Script `schema.sql` ejecutado completamente
- [ ] Tablas creadas (usuarios, categorias, contenidos, contenido_categorias)
- [ ] Datos de prueba insertados
- [ ] Credenciales en `DatabaseConnection.java` correctas
- [ ] Proyecto compilado sin errores (Clean and Build)
- [ ] Aplicación desplegada en servidor (GlassFish/Tomcat)

---

## 💡 SIGUIENTE PASO

Una vez que la base de datos esté configurada:

1. **Clean and Build** el proyecto en NetBeans (`Shift + F11`)
2. **Run** el proyecto (`F6`)
3. Acceder a `http://localhost:8080/PlataformaIAG/`
4. Iniciar sesión con las credenciales de prueba
5. ¡Explorar la plataforma!

---

**¿Sigues teniendo problemas?** Revisa los logs del servidor en la pestaña **Output** de NetBeans para más detalles del error.
