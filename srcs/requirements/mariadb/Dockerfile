FROM alpine:latest
RUN apk add mariadb
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql
COPY ./init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN ./usr/bin/mariadb-install-db --user=mysql
EXPOSE 3306
CMD ["mariadbd", "--console"]

