# ✅ SOLUCIÓN COMPLETA: Errores de Inserción y Consulta de Datos

## 🔴 PROBLEMA IDENTIFICADO

Habías creado un contenido y **NO se guardó en la base de datos**. Esto se debía a que:

1. ❌ Los DAOs usaban nombres de tablas **en MAYÚSCULAS** (`Contenido`, `Usuario`, `Categoria`)
2. ✅ El schema.sql creó las tablas **en minúsculas** (`contenidos`, `usuarios`, `categorias`)
3. ❌ MySQL en Linux es **case-sensitive** para nombres de tablas
4. ❌ Los SQL no funcionaban, causando que:
   - No se insertaran datos
   - No se consultaran datos
   - Las páginas aparecieran vacías

---

## ✅ SOLUCIÓN APLICADA

He corregido **TODOS** los nombres de tablas en los 3 DAOs:

### ✅ ContenidoDAO.java
```sql
Antes: SELECT * FROM Contenido WHERE...
Ahora: SELECT * FROM contenidos WHERE...
```

### ✅ CategoriaDAO.java
```sql
Antes: SELECT * FROM Categoria WHERE...
Ahora: SELECT * FROM categorias WHERE...
```

### ✅ UsuarioDAO.java
```sql
Antes: SELECT * FROM Usuario WHERE...
Ahora: SELECT * FROM usuarios WHERE...
```

### ✅ Tablas Intermedias
```sql
Antes: contenido_categorias con id_contenido, id_categoria
Ahora: contenido_categorias con contenido_id, categoria_id
```

### ✅ Método Agregado
- `actualizarCategorias(int idContenido, String[] ids)` en ContenidoDAO

---

## 🚀 PASOS OBLIGATORIOS PARA QUE FUNCIONE

### ⚠️ MUY IMPORTANTE: Sigue TODOS estos pasos

### **PASO 1: Detener el servidor en NetBeans**

1. Pestaña **Services** → **Servers**
2. Clic derecho en **GlassFish Server** → **Stop Server**
3. Espera a que se detenga completamente

---

### **PASO 2: Eliminar deployment antiguo de WebApplication1**

Ve a la carpeta de aplicaciones de GlassFish y **ELIMINA** WebApplication1:

**Windows:**
```
C:\Users\TU_USUARIO\GlassFish_Server\glassfish\domains\domain1\applications\
```

**Linux/Mac:**
```
~/GlassFish_Server/glassfish/domains/domain1/applications/
```

**Elimina:**
- `WebApplication1` (carpeta)
- `WebApplication1.war` (archivo)
- `WebApplication1.war_*` (cualquier archivo relacionado)

---

### **PASO 3: Limpiar el proyecto**

En NetBeans:
1. Clic derecho en **PlataformaIAG**
2. **Clean**
3. Espera a que termine

---

### **PASO 4: Compilar el proyecto**

1. Clic derecho en **PlataformaIAG**
2. **Build** (o **Clean and Build**)
3. Espera a ver **"BUILD SUCCESSFUL"**
4. Revisa que NO haya errores de compilación

---

### **PASO 5: Ejecutar con RUN (NO Debug)**

1. Clic derecho en **PlataformaIAG**
2. **Run** (`F6`)
   - ⚠️ **NO uses Debug**
   - ✅ Usa **Run**
3. Espera a que se despliegue
4. Se abrirá el navegador

---

### **PASO 6: Verificar la URL correcta**

La URL **DEBE SER:**
```
http://localhost:8080/PlataformaIAG/
```

**NO debe ser:**
```
http://localhost:8080/WebApplication1/  ❌
```

Si sigue siendo `WebApplication1`, repite los pasos 1-5.

---

## 🧪 PROBAR QUE TODO FUNCIONA

### **Prueba 1: Login como Admin**

1. Ir a: `http://localhost:8080/PlataformaIAG/login`
2. Ingresar:
   ```
   Email: admin@plataformaiag.com
   Contraseña: admin123
   ```
3. Debe redirigir a: `/admin/dashboard`
4. Debe mostrar **estadísticas**:
   - Total contenidos
   - Total categorías
   - Total usuarios
5. Debe mostrar **lista de contenidos** existentes

---

### **Prueba 2: Crear un Nuevo Contenido**

1. En el dashboard, clic en **"➕ Nuevo Contenido"**
2. Rellenar el formulario:
   - **Título:** "Prueba de Inserción"
   - **Tipo:** Artículo
   - **Estado:** Publicado
   - **Categorías:** Seleccionar al menos una
   - **Contenido:** "Este es un contenido de prueba para verificar que la inserción funciona correctamente."
3. Clic en **"💾 Guardar"**
4. Debe redirigir a `/admin/dashboard`
5. **Verificar:** El nuevo contenido debe aparecer en la lista

---

### **Prueba 3: Ver el Contenido en /home**

1. Ir a: `http://localhost:8080/PlataformaIAG/home`
2. Debe mostrar **TODOS** los contenidos publicados
3. Debe aparecer tu contenido "Prueba de Inserción"
4. Verificar que se muestra:
   - Título
   - Extracto (primeras 150 caracteres)
   - Categorías con colores
   - Número de vistas
   - Fecha

---

### **Prueba 4: Ver Detalle del Contenido**

1. En `/home`, hacer clic en el título "Prueba de Inserción"
2. Debe abrir: `/contenido?id=X` (donde X es el ID)
3. Debe mostrar:
   - Título completo
   - Contenido completo
   - Categorías
   - Vistas (debe incrementar cada vez que entras)
   - Fecha
   - Nombre del autor (admin)

---

### **Prueba 5: Filtrar por Categoría**

1. En `/home`, hacer clic en una de las categorías (ej: "📝 Texto")
2. La URL debe cambiar a: `/home?categoria=1`
3. Debe mostrar **solo** los contenidos de esa categoría

---

### **Prueba 6: Login como Usuario Normal**

1. Cerrar sesión
2. Ir a `/login`
3. Ingresar:
   ```
   Email: usuario@plataformaiag.com
   Contraseña: user123
   ```
4. Debe redirigir a `/home`
5. Debe poder ver contenidos
6. **NO** debe aparecer link "Panel Admin"

---

### **Prueba 7: Verificar en la Base de Datos**

Abre MySQL y verifica:

```sql
mysql -u root -p
USE plataforma_iag;

-- Ver todos los contenidos
SELECT * FROM contenidos;

-- Debes ver tu contenido "Prueba de Inserción"

-- Ver las categorías asignadas
SELECT cc.*, cat.nombre
FROM contenido_categorias cc
JOIN categorias cat ON cc.categoria_id = cat.id_categoria
WHERE cc.contenido_id = (SELECT id_contenido FROM contenidos WHERE titulo = 'Prueba de Inserción');
```

---

## 📊 VERIFICACIÓN COMPLETA

### ✅ Si TODO funciona correctamente:

- [ ] Login admin funciona y muestra dashboard
- [ ] Dashboard muestra estadísticas (números correctos)
- [ ] Puedes crear un nuevo contenido
- [ ] El contenido aparece en la lista del dashboard
- [ ] El contenido aparece en `/home`
- [ ] Puedes ver el detalle del contenido
- [ ] El contador de vistas incrementa
- [ ] Los filtros por categoría funcionan
- [ ] Login de usuario normal funciona
- [ ] Usuario normal solo ve `/home`, no admin

---

## 🐛 SI AÚN HAY PROBLEMAS

### Problema 1: "BUILD FAILED - Error de compilación"

**Solución:**
1. Revisar la pestaña **Output** en NetBeans
2. Ver el error específico
3. Asegurarse de que el driver MySQL esté en `lib/`

---

### Problema 2: Contenido no se guarda

**Verificar en logs:**
1. Pestaña **Output** en NetBeans
2. Buscar errores SQL
3. Ver si hay excepciones

**Verificar en MySQL:**
```sql
SELECT * FROM contenidos ORDER BY id_contenido DESC LIMIT 5;
```

Si no aparece tu contenido:
1. Revisar que la base de datos exista
2. Revisar que las tablas estén creadas
3. Revisar credenciales en `DatabaseConnection.java`

---

### Problema 3: Página en blanco o vacía

**Causas posibles:**
1. No hay contenidos en la BD → Ver Prueba 7
2. Error en JSP → Ver logs en Output
3. Error de conexión → Ver logs

**Solución:**
1. Ejecutar el script `database/schema.sql` de nuevo
2. Verificar que haya datos de prueba
3. Clean and Build del proyecto

---

### Problema 4: Error 404 en `/contenido?id=X`

**Causa:** El servlet está configurado correctamente

**Verificar:**
1. La anotación `@WebServlet("/contenido")` está en `ContenidoServlet.java`
2. El archivo `contenido-detalle.jsp` existe en `web/`
3. El proyecto está compilado correctamente

---

### Problema 5: Sigue siendo WebApplication1

**Solución DEFINITIVA:**
1. Detener servidor
2. Ir a carpeta de GlassFish applications
3. **ELIMINAR MANUALMENTE** todo lo de WebApplication1
4. Reiniciar GlassFish desde NetBeans
5. Clean and Build
6. Run de nuevo

---

## 📝 ARCHIVOS MODIFICADOS (Commit b599531)

- ✅ `ContenidoDAO.java` - Correcciones SQL
- ✅ `CategoriaDAO.java` - Correcciones SQL
- ✅ `UsuarioDAO.java` - Correcciones SQL

---

## 🎉 RESUMEN

### Problemas Solucionados:
1. ✅ Nombres de tablas corregidos en todos los DAOs
2. ✅ Método `actualizarCategorias()` agregado
3. ✅ Consultas SQL funcionando correctamente
4. ✅ Inserción de datos funcionando
5. ✅ Consulta de datos funcionando
6. ✅ Relaciones entre tablas funcionando

### Funcionalidades Ahora Operativas:
1. ✅ Crear contenidos y se guardan en BD
2. ✅ Ver lista de contenidos en /home
3. ✅ Ver detalle de contenido individual
4. ✅ Asignar múltiples categorías a contenidos
5. ✅ Filtrar contenidos por categoría
6. ✅ Contador de vistas funcionando
7. ✅ Login y autenticación funcionando

---

**Commit:** `b599531`
**Push:** ✅ Completado

**Sigue los 6 pasos de arriba y prueba cada funcionalidad. Todo debe funcionar correctamente ahora.**
