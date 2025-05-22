FROM alpine:latest
RUN apk add mariadb
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld 
COPY ./init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh
EXPOSE 3306
CMD ["/run/entrypoint.sh"]

