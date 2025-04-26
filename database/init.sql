-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS myapp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Crear el usuario si no existe
CREATE USER IF NOT EXISTS 'development1'@'%' IDENTIFIED BY 'password';

-- Otorgar privilegios totales
GRANT ALL PRIVILEGES ON *.* TO 'development1'@'%' WITH GRANT OPTION;

-- Aplicar cambios
FLUSH PRIVILEGES;
