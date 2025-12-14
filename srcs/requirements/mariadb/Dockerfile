FROM alpine:3.23.0
RUN apk add mariadb gettext-envsubst
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld 
COPY ./init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./conf/mariadb-server.cnf.template /etc/my.cnf.d/mariadb-server.cnf.template
COPY ./entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh
CMD ["/run/entrypoint.sh"]

