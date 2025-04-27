# LEMP + Laravel Development Environment

Este repositorio contiene la configuración y los pasos necesarios para levantar un entorno de desarrollo **LEMP** (Linux CentOS 7, Nginx, MariaDB, PHP 8.2) con **Laravel 12** y **phpMyAdmin**, utilizando Docker Compose sobre WSL 2.

---

## Requisitos previos

- Windows 11 con WSL 2
- Distro de Linux instalada en WSL (Ubuntu recomendado)
- Acceso de administrador en Windows para modificar `hosts`

---

## Instalación de Docker y Docker Compose en WSL

1. **Instalar WSL 2** (si no está instalado aún):
   ```bash
   wsl --install
   ```
2. Abrir tu terminal WSL y actualizar paquetes:
   ```bash
   sudo apt-get update
   ```
3. Instalar Docker y Docker Compose:
   ```bash
   sudo apt-get install -y docker.io docker-compose
   ```
4. Añadir tu usuario al grupo `docker` para usar Docker sin `sudo`:
   ```bash
   sudo usermod -aG docker $USER
   newgrp docker
   ```
5. Verificar la instalación:
   ```bash
   docker --version          # Debe mostrar la versión instalada
   docker-compose --version  # Debe mostrar la versión instalada
   ```

---

## Levantar el entorno con Docker Compose

Dentro de la carpeta raíz del proyecto (donde está `docker-compose.yml`):

```bash
# Detener contenedores si están corriendo
docker-compose down

# Reconstruir la imagen del webserver sin cache
docker-compose build --no-cache webserver

# Levantar servicios en segundo plano
docker-compose up -d

# Listar contenedores y puertos expuestos
docker-compose ps
```

---

## Configuración de alias en WSL para Laravel y Artisan

Para simplificar comandos de Laravel Installer y Artisan en el contenedor `webserver`, agrega alias en tu `~/.bashrc`.

1. Abrir `~/.bashrc`:
   ```bash
   nano ~/.bashrc
   ```
2. Añadir los alias al final:
   ```bash
   # Laravel Installer (crea proyectos en /var/www/html)
   alias laravel="docker-compose exec -w /var/www/html webserver laravel"

   # Comandos Artisan y Composer (Ejecutar los comandos dentro de los proyectos):
   alias art='docker-compose exec -w "/var/www/html/$(basename "$PWD")" webserver php artisan'
   alias cpr='docker-compose exec -w "/var/www/html/$(basename "$PWD")" webserver composer'
   ```
3. Guardar y recargar:
   ```bash
   source ~/.bashrc
   ```

---

## Comandos de ejemplo

### Crear un nuevo proyecto Laravel
```bash
laravel new example          # Crea carpeta www/example con Laravel 12
```

### Usar Artisan dentro de "example"
```bash
art --help                # Muestra ayuda de Artisan
art migrate               # Ejecuta migraciones pendientes
artisan make:controller HomeController  # Crea un controlador
```

---

## Acceso a servicios

- **Aplicación Laravel**:  [http://localhost/](http://localhost/)  (apunta al proyecto en `www/example`)
- **phpMyAdmin**:          [http://localhost:8081](http://localhost:8081)
- **Base de datos MariaDB**:  puerto `3306`

---

## Hosts personalizados (opcional)

Para usar un dominio local como `example.test`:

1. En Windows, editar como Administrador:
   ```
   C:\Windows\System32\drivers\etc\hosts
   ```
2. Añadir la línea:
   ```
   127.0.0.1   example.test
   ```
<!-- 3. Crear un virtual host en `webserver/config/example.conf` con `server_name example.test`. -->

---

¡Listo! Ahora tienes un entorno **LEMP + Laravel 12** con Docker Compose y alias configurados para trabajar con Artisan y Laravel Installer.

