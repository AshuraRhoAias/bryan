# ⚡ INICIO RÁPIDO - Plataforma IAG

## 🚨 SOLUCIÓN AL ERROR HTTP 500

Si estás viendo este error:
```
HTTP Status 500 - Internal Server Error
NullPointerException: Cannot invoke "java.sql.Connection.prepareStatement(String)" because "conn" is null
```

**Causa:** La base de datos MySQL no está configurada.

**Solución rápida en 3 pasos:**

---

## ✅ PASO 1: Verificar MySQL

### Windows
1. Tecla **Windows + R**
2. Escribir `services.msc` y Enter
3. Buscar **MySQL** o **MySQL80**
4. Verificar que esté **"Iniciado"**
5. Si no está iniciado → Clic derecho → **Iniciar**

### Linux/Mac
```bash
# Verificar estado
sudo systemctl status mysql

# Iniciar si no está ejecutándose
sudo systemctl start mysql
```

### XAMPP/WAMP
1. Abrir panel de control XAMPP/WAMP
2. Iniciar el módulo **MySQL**
3. Verificar que el indicador esté verde

---

## ✅ PASO 2: Crear la Base de Datos

### Opción A: Script Automático (RECOMENDADO)

#### Windows
1. Abrir **Explorador de archivos**
2. Navegar a la carpeta del proyecto: `bryan/database/`
3. Doble clic en **`instalar_bd.bat`**
4. Seguir las instrucciones en pantalla

#### Linux/Mac
```bash
cd /ruta/a/tu/proyecto/bryan/database
./instalar_bd.sh
```

### Opción B: Manual

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

---

## ✅ PASO 3: Recompilar y Ejecutar

### En NetBeans:

1. **Clean and Build** el proyecto
   - Clic derecho en **PlataformaIAG** → **Clean and Build**
   - O presionar `Shift + F11`

2. **Run** el proyecto
   - Clic derecho en **PlataformaIAG** → **Run**
   - O presionar `F6`

3. **Acceder a la aplicación**
   - Se abrirá automáticamente en tu navegador
   - URL: `http://localhost:8080/PlataformaIAG/`

---

## 🔑 CREDENCIALES DE PRUEBA

Una vez que la aplicación esté funcionando:

### Administradores:
| Email | Contraseña |
|-------|------------|
| `admin@plataformaiag.com` | `admin123` |
| `bryan@plataformaiag.com` | `admin123` |

### Usuario Normal:
| Email | Contraseña |
|-------|------------|
| `usuario@plataformaiag.com` | `user123` |

---

## ✅ VERIFICACIÓN DE ÉXITO

### Señales de que todo funciona correctamente:

1. **En los logs de NetBeans** (pestaña Output) deberías ver:
```
========================================
✓ CONEXIÓN A BASE DE DATOS ESTABLECIDA
  Base de datos: plataforma_iag
  URL: jdbc:mysql://localhost:3306/plataforma_iag
  Usuario: root
========================================
```

2. **La página de inicio** se carga sin errores

3. **Puedes iniciar sesión** con las credenciales de prueba

4. **Los contenidos se muestran** en la página principal

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### Problema: "Access denied for user 'root'@'localhost'"

**Causa:** Tu MySQL tiene contraseña y no está configurada en el código.

**Solución:**
1. Abrir `src/java/database/DatabaseConnection.java`
2. Línea 17: Cambiar `PASSWORD = ""` por tu contraseña:
   ```java
   private static final String PASSWORD = "tuContraseña";
   ```
3. Guardar y hacer **Clean and Build**

---

### Problema: "Unknown database 'plataforma_iag'"

**Causa:** La base de datos no se creó.

**Solución:** Repetir el **Paso 2** (crear la base de datos)

---

### Problema: "Communications link failure"

**Causa:** MySQL no está ejecutándose.

**Solución:** Repetir el **Paso 1** (verificar/iniciar MySQL)

---

### Problema: El script SQL no se ejecuta

**Solución alternativa con MySQL Workbench:**
1. Abrir **MySQL Workbench**
2. Conectar a **localhost**
3. **File → Open SQL Script**
4. Seleccionar `database/schema.sql`
5. Ejecutar (icono ⚡ o `Ctrl+Shift+Enter`)

---

## 📚 DOCUMENTACIÓN COMPLETA

Para más información detallada, consulta:

- **[CONFIGURACION_NETBEANS.md](CONFIGURACION_NETBEANS.md)** - Configuración del proyecto
- **[database/README_DATABASE.md](database/README_DATABASE.md)** - Configuración de MySQL
- **[README.md](README.md)** - Información general del proyecto

---

## 🎯 FUNCIONALIDADES PRINCIPALES

Una vez que la aplicación esté funcionando:

### Para todos los usuarios:
- ✅ Ver contenidos publicados (artículos, tips, noticias, tutoriales)
- ✅ Filtrar por categoría
- ✅ Leer contenidos completos
- ✅ Registrarse como nuevo usuario

### Solo para administradores:
- ✅ Crear nuevos contenidos
- ✅ Editar contenidos existentes
- ✅ Eliminar contenidos
- ✅ Ver estadísticas en el dashboard
- ✅ Gestionar categorías

---

## 🗺️ NAVEGACIÓN DE LA APLICACIÓN

```
Página Principal (index.html)
    ↓
Iniciar Sesión (login)
    ↓
┌─────────────────────────────────────┐
│                                     │
▼                                     ▼
Home - Explorar Contenidos      Dashboard Admin
(Todos los usuarios)             (Solo admins)
    ↓                                 ↓
Ver Detalle de Contenido         Crear/Editar Contenido
```

---

## 💡 CONSEJOS

1. **Primera vez**: Usar las credenciales de **admin@plataformaiag.com / admin123**
2. **Explorar primero**: Ir a "Home" para ver los contenidos de ejemplo
3. **Panel Admin**: Si eres admin, accede a `/admin/dashboard` para gestionar contenidos
4. **Logs útiles**: Siempre revisa la pestaña **Output** en NetBeans para mensajes de error

---

## 🆘 AYUDA

Si después de seguir estos pasos sigues teniendo problemas:

1. **Revisar logs** en NetBeans (pestaña Output)
2. **Consultar** [database/README_DATABASE.md](database/README_DATABASE.md) para diagnóstico detallado
3. **Verificar** que todas las dependencias estén instaladas:
   - JDK 21
   - MySQL 8.0+
   - GlassFish 8.0 o Tomcat 10+
   - NetBeans 12+

---

## ✅ CHECKLIST RÁPIDO

Antes de ejecutar la aplicación:

- [ ] MySQL instalado e iniciado
- [ ] Base de datos `plataforma_iag` creada
- [ ] Script `schema.sql` ejecutado
- [ ] Credenciales correctas en `DatabaseConnection.java` (si tienes contraseña)
- [ ] Proyecto compilado sin errores (Clean and Build)
- [ ] Servidor configurado en NetBeans

---

## 🎉 ¡LISTO!

Si todo está configurado correctamente, ahora puedes:
- ✅ Navegar por la plataforma
- ✅ Crear contenidos sobre IA Generativa
- ✅ Gestionar categorías
- ✅ Ver estadísticas
- ✅ ¡Y más!

---

**Última actualización:** 2024
**Versión:** 1.0
**Proyecto:** Plataforma IAG - Inteligencia Artificial Generativa
