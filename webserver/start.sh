#!/bin/bash

# Mostrar errores si algo falla
set -e

# Iniciar PHP-FPM
echo "Iniciando PHP-FPM..."
php-fpm -D

# Esperar un momento para asegurar que PHP-FPM esté activo
sleep 2

# Iniciar Nginx en primer plano
echo "Iniciando Nginx..."
nginx -g "daemon off;"
