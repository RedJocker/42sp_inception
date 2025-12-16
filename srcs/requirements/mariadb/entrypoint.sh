#!/bin/sh

envsubst '${MARIADB_PORT}'  \
    < /etc/my.cnf.d/mariadb-server.cnf.template \
    > /etc/my.cnf.d/mariadb-server.cnf

MARIADB_USER_PASS=$(cat /run/secrets/mariadb_pass)

envsubst '${WORDPRESS_DATABASE_NAME} ${MARIADB_USER_PASS} ${MARIADB_USER}'  \
    < /docker-entrypoint-initdb.d/init.sql.template \
    > /docker-entrypoint-initdb.d/init.sql

/usr/bin/mariadb-install-db --user=mysql

exec /usr/bin/mariadbd --console
