#!/bin/sh

envsubst '${MARIADB_PORT}'  \
    < /etc/my.cnf.d/mariadb-server.cnf.template \
    > /etc/my.cnf.d/mariadb-server.cnf

/usr/bin/mariadb-install-db --user=mysql

exec /usr/bin/mariadbd --console
