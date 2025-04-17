FROM centos:7
LABEL maintainer="ocastellanosc@miumg.edu.gt"

# 1) Apuntar repos a vault y activar Remi PHP 8.2
RUN sed -i 's|mirrorlist|#mirrorlist|g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum install -y epel-release yum-utils && \
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php82

# 2) Instalar Nginx, PHP 8.2‑FPM, extensiones, Nodejs 22, Composer y Laravel CLI
RUN yum -y update && \
    yum -y install \
      nginx \
      php \
      php-fpm \
      php-cli \
      php-mysqlnd \
      php-mbstring \
      php-xml \
      php-gd \
      php-zip \
      php-curl \
      curl \
    # Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    # Laravel installer (CLI) — requiere Composer 2+
    && composer global require laravel/installer \
    && yum clean all

# Crea un symlink para que 'laravel' quede en /usr/local/bin
RUN ln -s /root/.config/composer/vendor/bin/laravel /usr/local/bin/laravel

# 3) Crear directorio de PHP‑FPM y logs
RUN mkdir -p /var/run/php-fpm /var/www/html && \
    chown -R nginx:nginx /var/run/php-fpm /var/www/html

# 4) Copiar configuraciones
COPY config/nginx.conf   /etc/nginx/nginx.conf
COPY config/default.conf /etc/nginx/conf.d/default.conf
COPY config/www.conf     /etc/php-fpm.d/www.conf

# 5) Copiar start.sh y convertir a LF + dar permisos
COPY start.sh /start.sh
RUN sed -i 's/\r$//' /start.sh && chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
