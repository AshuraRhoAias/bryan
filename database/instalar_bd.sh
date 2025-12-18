#!/bin/bash
# =====================================================
# SCRIPT DE INSTALACIÓN DE BASE DE DATOS
# Plataforma IAG - MySQL
# =====================================================

echo ""
echo "========================================"
echo " INSTALADOR DE BASE DE DATOS"
echo " Plataforma IAG"
echo "========================================"
echo ""

# Verificar que el archivo schema.sql existe
if [ ! -f "schema.sql" ]; then
    echo "[ERROR] No se encontró el archivo schema.sql"
    echo "Por favor, ejecuta este script desde la carpeta database/"
    echo ""
    exit 1
fi

echo "[INFO] Archivo schema.sql encontrado"
echo ""

# Preguntar configuración
echo "Por favor, responde las siguientes preguntas:"
echo ""

read -p "Usuario de MySQL [root]: " MYSQL_USER
MYSQL_USER=${MYSQL_USER:-root}

read -sp "Contraseña de MySQL (dejar vacío si no tiene): " MYSQL_PASSWORD
echo ""

echo ""
echo "========================================"
echo " CONFIGURACIÓN"
echo "========================================"
echo "Usuario: $MYSQL_USER"
echo "Contraseña: [oculta]"
echo "Base de datos: plataforma_iag"
echo "========================================"
echo ""

read -p "¿Confirmas esta configuración? (s/n): " CONFIRMAR
if [ "$CONFIRMAR" != "s" ] && [ "$CONFIRMAR" != "S" ]; then
    echo "Instalación cancelada"
    exit 0
fi

echo ""
echo "[INFO] Ejecutando script SQL..."
echo ""

# Ejecutar el script
if [ -z "$MYSQL_PASSWORD" ]; then
    mysql -u "$MYSQL_USER" < schema.sql
else
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" < schema.sql
fi

# Verificar resultado
if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo " INSTALACIÓN EXITOSA"
    echo "========================================"
    echo ""
    echo "✓ Base de datos 'plataforma_iag' creada correctamente"
    echo ""
    echo "CREDENCIALES DE PRUEBA:"
    echo "-----------------------"
    echo "Admin:     admin@plataformaiag.com / admin123"
    echo "Usuario:   usuario@plataformaiag.com / user123"
    echo "Developer: bryan@plataformaiag.com / admin123"
    echo ""
    echo "SIGUIENTE PASO:"
    echo "1. Ir a NetBeans"
    echo "2. Clean and Build el proyecto (Shift + F11)"
    echo "3. Run el proyecto (F6)"
    echo "4. Acceder a http://localhost:8080/PlataformaIAG/"
    echo ""
    echo "========================================"
else
    echo ""
    echo "========================================"
    echo " ERROR EN LA INSTALACIÓN"
    echo "========================================"
    echo ""
    echo "Posibles causas:"
    echo "1. MySQL no está ejecutándose"
    echo "2. Usuario o contraseña incorrectos"
    echo "3. No tienes permisos suficientes"
    echo ""
    echo "Soluciones:"
    echo "1. Iniciar MySQL: sudo systemctl start mysql"
    echo "2. Verificar usuario y contraseña"
    echo "3. Ejecutar con sudo si es necesario"
    echo ""
    echo "Para más ayuda, consulta: README_DATABASE.md"
    echo "========================================"
    exit 1
fi

echo ""
