# 🔧 SOLUCIÓN: Connection Refused - Port 9009

## 🔴 ERROR

```
Attaching to localhost:9009
Connection refused.
```

**Causa:** Estás intentando ejecutar el proyecto en modo **Debug** y el depurador no puede conectarse.

---

## ✅ SOLUCIÓN RÁPIDA (Recomendada)

### Opción 1: Ejecutar en Modo RUN (No Debug)

**❌ NO uses:**
- Clic derecho → **Debug**
- Tecla `Ctrl + F5`
- Botón de Debug (🐞)

**✅ USA:**
- Clic derecho en **PlataformaIAG** → **Run**
- Tecla `F6`
- Botón de Run (▶️)

---

## 🔧 SOLUCIÓN COMPLETA (Si necesitas Debug)

Si REALMENTE necesitas usar el modo Debug, sigue estos pasos:

### PASO 1: Detener el servidor

En NetBeans:
1. Ve a la pestaña **Services** (o **Servers**)
2. Expande **Servers**
3. Clic derecho en **GlassFish Server** (o tu servidor)
4. **Stop Server**
5. Espera a que se detenga completamente

### PASO 2: Limpiar el proyecto

1. Clic derecho en **PlataformaIAG**
2. **Clean**
3. Espera a que termine

### PASO 3: Reiniciar el servidor

1. Ve a **Services** → **Servers**
2. Clic derecho en tu servidor
3. **Start**
4. Espera a que inicie completamente

### PASO 4: Ejecutar en modo Run primero

1. Clic derecho en **PlataformaIAG**
2. **Run** (F6)
3. Verifica que funcione correctamente

### PASO 5: Ahora intenta Debug

1. Clic derecho en **PlataformaIAG**
2. **Debug** (Ctrl + F5)

---

## 🐛 SOLUCIONES ALTERNATIVAS

### Solución A: Verificar puerto 9009

El puerto 9009 puede estar ocupado:

**Windows:**
```cmd
netstat -ano | findstr :9009
```

**Linux/Mac:**
```bash
sudo lsof -i :9009
```

Si está ocupado, mata el proceso o cambia el puerto de debug.

### Solución B: Cambiar puerto de debug de GlassFish

1. Ve a **Services** → **Servers**
2. Clic derecho en **GlassFish Server** → **Properties**
3. En la pestaña **Platform**, busca **Debug Port**
4. Cambia de `9009` a otro puerto (ej: `9010`, `9011`)
5. Clic en **OK**
6. Reinicia el servidor

### Solución C: Configurar servidor correctamente

1. **Tools** → **Servers**
2. Selecciona tu servidor (GlassFish/Tomcat)
3. Verifica la configuración:
   - **Domain:** domain1 (para GlassFish)
   - **HTTP Port:** 8080
   - **Admin Port:** 4848 (GlassFish)
4. Aplica cambios

### Solución D: Reinstalar servidor en NetBeans

Si nada funciona:

1. **Tools** → **Servers**
2. Selecciona tu servidor → **Remove**
3. **Add Server**
4. Configura nuevamente el servidor
5. Asigna el servidor al proyecto

---

## ⚠️ IMPORTANTE: No necesitas Debug para probar la aplicación

La mayoría de las veces, el modo **Run** normal es suficiente:

- ✅ **Run (F6):** Ejecuta la aplicación normalmente
- 🐞 **Debug (Ctrl+F5):** Solo si necesitas:
  - Puntos de interrupción (breakpoints)
  - Ver variables paso a paso
  - Inspeccionar el flujo del código

---

## 🎯 PASOS RECOMENDADOS PARA TI

**Ahora mismo, haz esto:**

1. **Detén todo:**
   - Services → Servers → Clic derecho en servidor → **Stop Server**

2. **Limpia el proyecto:**
   - Clic derecho en **PlataformaIAG** → **Clean**

3. **Ejecuta en modo Run:**
   - Clic derecho en **PlataformaIAG** → **Run** (F6)

4. **Espera a que abra el navegador**

5. **Prueba la aplicación:**
   - Deberías ver la página de inicio
   - Inicia sesión con: `admin@plataformaiag.com / admin123`

---

## ✅ VERIFICACIÓN DE ÉXITO

Si todo funciona correctamente, verás en los logs:

```
========================================
✓ CONEXIÓN A BASE DE DATOS ESTABLECIDA
  Base de datos: plataforma_iag
  URL: jdbc:mysql://localhost:3306/plataforma_iag
  Usuario: root
========================================

Starting GlassFish Server...
GlassFish Server started in NNNN ms.
Deploying on GlassFish Server...
PlataformaIAG was successfully deployed in X milliseconds.
```

Y en el navegador:
- URL: `http://localhost:8080/PlataformaIAG/`
- Página de inicio carga correctamente

---

## 📚 RESUMEN

**Problema:** El depurador no puede conectarse al puerto 9009

**Solución más simple:**
1. No uses Debug, usa **Run** (F6)
2. Detén el servidor, limpia el proyecto, y ejecuta con Run

**Si necesitas Debug:**
1. Detener servidor
2. Limpiar proyecto
3. Reiniciar servidor
4. Probar con Run primero
5. Luego intentar Debug

---

## 💡 CONSEJO

Para desarrollo normal, **NO necesitas Debug**. Usa Debug solo cuando:
- Tienes un bug difícil de encontrar
- Necesitas ver el valor de variables en tiempo real
- Quieres seguir el flujo de ejecución paso a paso

Para solo ver la aplicación funcionando, **Run** es suficiente.

---

¿Ya creaste la base de datos con el script `instalar_bd.bat` o `schema.sql`?
