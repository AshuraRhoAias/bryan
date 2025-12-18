# ⚠️ CÓMO EJECUTAR EL PROYECTO CORRECTAMENTE

## 🔴 ERROR COMÚN

Si ves estos errores:
```
"There are not servlet mapping specified in web.xml for DatabaseConnection servlet"
"Class database.DatabaseConnection does not have a main method"
```

**Causa:** Estás intentando ejecutar `DatabaseConnection.java` directamente.

**❌ NO HAGAS ESTO:**
- Clic derecho en `DatabaseConnection.java` → Run File
- Esto NO funcionará porque DatabaseConnection es solo una clase de utilidad

---

## ✅ SOLUCIÓN: EJECUTA EL PROYECTO COMPLETO EN 2 PASOS

---

## 📋 PASO 1: CREAR LA BASE DE DATOS

### Opción A: Script Automático (MÁS FÁCIL)

#### Si usas Windows:
1. Abrir **Explorador de archivos**
2. Navegar a: `TU_PROYECTO/database/`
3. **Doble clic** en `instalar_bd.bat`
4. Seguir las instrucciones

#### Si usas Linux/Mac:
```bash
cd /ruta/a/tu/proyecto/database
./instalar_bd.sh
```

### Opción B: Manual (Línea de comandos)

#### Paso 1.1: Abrir terminal/cmd
```bash
# Navegar a la carpeta del proyecto
cd C:\ruta\a\tu\proyecto

# O en Linux/Mac
cd /ruta/a/tu/proyecto
```

#### Paso 1.2: Ejecutar el script SQL
```bash
# Si tu MySQL TIENE contraseña:
mysql -u root -p < database/schema.sql

# Si tu MySQL NO tiene contraseña:
mysql -u root < database/schema.sql
```

#### Paso 1.3: Verificar que se creó
```bash
mysql -u root -p
```

Dentro de MySQL:
```sql
SHOW DATABASES;
-- Deberías ver 'plataforma_iag'

USE plataforma_iag;
SHOW TABLES;
-- Deberías ver: usuarios, categorias, contenidos, contenido_categorias

SELECT * FROM usuarios;
-- Deberías ver 3 usuarios

exit;
```

### Opción C: Usando MySQL Workbench (GUI)
1. Abrir **MySQL Workbench**
2. Conectar a **localhost**
3. **File → Open SQL Script**
4. Seleccionar: `TU_PROYECTO/database/schema.sql`
5. Ejecutar (⚡ icono del rayo o `Ctrl+Shift+Enter`)

### Opción D: Usando phpMyAdmin (si usas XAMPP/WAMP)
1. Abrir navegador: `http://localhost/phpmyadmin`
2. Ir a pestaña **SQL**
3. Abrir el archivo `database/schema.sql` en un editor de texto
4. Copiar TODO el contenido
5. Pegar en phpMyAdmin
6. Clic en **Ejecutar** o **Go**

---

## 📋 PASO 2: EJECUTAR EL PROYECTO COMPLETO

### En NetBeans:

#### ❌ NO HAGAS ESTO:
```
Clic derecho en DatabaseConnection.java → Run File
Clic derecho en LoginServlet.java → Run File
```

#### ✅ HAZ ESTO:

1. **Clic derecho en el PROYECTO** (PlataformaIAG) - El icono principal en la raíz

   ![Proyecto](Clic derecho en el nodo raíz, no en un archivo individual)

2. **Clean and Build** (o presiona `Shift + F11`)
   - Espera a que compile
   - Debería decir "BUILD SUCCESSFUL"

3. **Run** (o presiona `F6`)
   - NetBeans desplegará la aplicación en GlassFish/Tomcat
   - Se abrirá automáticamente tu navegador

4. **Resultado esperado:**
   - Navegador abre: `http://localhost:8080/PlataformaIAG/`
   - Ves la página de inicio de la plataforma

---

## 🎯 VERIFICACIÓN DE ÉXITO

### En los logs de NetBeans (pestaña Output):

```
========================================
✓ CONEXIÓN A BASE DE DATOS ESTABLECIDA
  Base de datos: plataforma_iag
  URL: jdbc:mysql://localhost:3306/plataforma_iag
  Usuario: root
========================================

...

Deploying on GlassFish Server...
...
PlataformaIAG was successfully deployed in X milliseconds.
```

### En el navegador:

- ✅ Página de inicio carga correctamente
- ✅ Botones "Explorar Contenidos" e "Iniciar Sesión" funcionan
- ✅ Puedes hacer clic en "Iniciar Sesión"

---

## 🔑 CREDENCIALES DE PRUEBA

Una vez que el proyecto esté ejecutándose:

### Iniciar sesión como Administrador:
```
Email: admin@plataformaiag.com
Contraseña: admin123
```

### Iniciar sesión como Usuario:
```
Email: usuario@plataformaiag.com
Contraseña: user123
```

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### Problema 1: "BUILD FAILED - Cannot find symbol DatabaseConnection"
**Causa:** La base de datos no está creada o las credenciales son incorrectas

**Solución:**
1. Crear la base de datos (Paso 1)
2. Si tu MySQL tiene contraseña, actualizar `DatabaseConnection.java`:
   ```java
   private static final String PASSWORD = "tuContraseña";
   ```

---

### Problema 2: "Server not found" o "GlassFish server is not configured"
**Causa:** No tienes servidor configurado en NetBeans

**Solución:**
1. **Tools → Servers**
2. **Add Server**
3. Seleccionar **GlassFish** o **Tomcat**
4. Configurar y aceptar
5. Clic derecho en proyecto → **Properties → Run**
6. Seleccionar el servidor que agregaste

---

### Problema 3: "Port 8080 already in use"
**Causa:** Otro proceso está usando el puerto 8080

**Solución:**
1. Detener el proceso que usa el puerto
2. O cambiar el puerto del servidor en NetBeans

---

### Problema 4: Error HTTP 500 al abrir la página
**Causa:** La base de datos no está creada

**Solución:**
- Repetir el **Paso 1** (crear base de datos)
- Verificar con: `mysql -u root -p`
  ```sql
  USE plataforma_iag;
  SELECT * FROM usuarios;
  ```

---

## 📁 ESTRUCTURA DEL PROYECTO (Qué ejecutar)

```
PlataformaIAG/  ← ✅ EJECUTA ESTO (Clic derecho → Run)
├── database/
│   ├── schema.sql              ← Ejecuta primero en MySQL
│   ├── instalar_bd.bat         ← O ejecuta esto en Windows
│   └── instalar_bd.sh          ← O esto en Linux/Mac
├── src/java/
│   ├── controller/             ← NO ejecutar archivos individuales
│   ├── model/                  ← NO ejecutar archivos individuales
│   └── database/
│       └── DatabaseConnection.java  ← ❌ NO ejecutar este archivo solo
└── web/
    ├── index.html
    └── ...
```

---

## 🎯 RESUMEN: QUÉ HACER

1. ✅ **Crear base de datos**: Ejecutar `database/schema.sql` en MySQL
2. ✅ **Ejecutar proyecto completo**: Clic derecho en **PlataformaIAG** → Run
3. ✅ **Abrir navegador**: `http://localhost:8080/PlataformaIAG/`
4. ✅ **Iniciar sesión**: `admin@plataformaiag.com / admin123`

---

## ❌ LO QUE NO DEBES HACER

- ❌ Ejecutar `DatabaseConnection.java` solo
- ❌ Ejecutar servlets individuales
- ❌ Ejecutar archivos JSP directamente
- ❌ Olvidarte de crear la base de datos primero

---

## 📞 AYUDA ADICIONAL

Si después de seguir estos pasos aún tienes problemas, revisa:

- **INICIO_RAPIDO.md** - Guía rápida de 3 pasos
- **database/README_DATABASE.md** - Documentación completa de MySQL
- **CONFIGURACION_NETBEANS.md** - Configuración de NetBeans

O verifica los logs en la pestaña **Output** de NetBeans para ver el error específico.

---

**Recuerda:** Siempre ejecuta el **proyecto completo**, no archivos individuales.
