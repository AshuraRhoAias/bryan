@echo off
REM =====================================================
REM SCRIPT DE INSTALACIÓN DE BASE DE DATOS
REM Plataforma IAG - MySQL
REM =====================================================

echo.
echo ========================================
echo  INSTALADOR DE BASE DE DATOS
echo  Plataforma IAG
echo ========================================
echo.

REM Verificar que el archivo schema.sql existe
if not exist schema.sql (
    echo [ERROR] No se encontro el archivo schema.sql
    echo Por favor, ejecuta este script desde la carpeta database/
    echo.
    pause
    exit /b 1
)

echo [INFO] Archivo schema.sql encontrado
echo.

REM Preguntar configuración
echo Por favor, responde las siguientes preguntas:
echo.

set /p MYSQL_USER="Usuario de MySQL [root]: "
if "%MYSQL_USER%"=="" set MYSQL_USER=root

set /p MYSQL_PASSWORD="Contrasena de MySQL (dejar vacio si no tiene): "

echo.
echo ========================================
echo  CONFIGURACION
echo ========================================
echo Usuario: %MYSQL_USER%
echo Contrasena: %MYSQL_PASSWORD%
echo Base de datos: plataforma_iag
echo ========================================
echo.

set /p CONFIRMAR="Confirmas esta configuracion? (S/N): "
if /i not "%CONFIRMAR%"=="S" (
    echo Instalacion cancelada
    pause
    exit /b 0
)

echo.
echo [INFO] Ejecutando script SQL...
echo.

REM Ejecutar el script
if "%MYSQL_PASSWORD%"=="" (
    mysql -u %MYSQL_USER% < schema.sql
) else (
    mysql -u %MYSQL_USER% -p%MYSQL_PASSWORD% < schema.sql
)

REM Verificar resultado
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo  INSTALACION EXITOSA
    echo ========================================
    echo.
    echo Base de datos 'plataforma_iag' creada correctamente
    echo.
    echo CREDENCIALES DE PRUEBA:
    echo -----------------------
    echo Admin:   admin@plataformaiag.com / admin123
    echo Usuario: usuario@plataformaiag.com / user123
    echo Developer: bryan@plataformaiag.com / admin123
    echo.
    echo SIGUIENTE PASO:
    echo 1. Ir a NetBeans
    echo 2. Clean and Build el proyecto (Shift + F11)
    echo 3. Run el proyecto (F6)
    echo 4. Acceder a http://localhost:8080/PlataformaIAG/
    echo.
    echo ========================================
) else (
    echo.
    echo ========================================
    echo  ERROR EN LA INSTALACION
    echo ========================================
    echo.
    echo Posibles causas:
    echo 1. MySQL no esta ejecutandose
    echo 2. Usuario o contrasena incorrectos
    echo 3. No tienes permisos suficientes
    echo.
    echo Soluciones:
    echo 1. Verificar que MySQL este iniciado en Servicios
    echo 2. Verificar usuario y contrasena
    echo 3. Ejecutar como Administrador
    echo.
    echo Para mas ayuda, consulta: README_DATABASE.md
    echo ========================================
)

echo.
pause
