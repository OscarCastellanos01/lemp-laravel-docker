FROM mariadb:10.11

# Sobreescribimos el archivo de configuración
COPY my.cnf /etc/mysql/conf.d/custom.cnf

# Cambiamos el arranque para forzar puerto 3309
CMD ["mysqld", "--port=3309"]