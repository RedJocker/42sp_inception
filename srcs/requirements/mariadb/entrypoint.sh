#!/bin/sh

envsubst '${MARIADB_PORT}'  \
    < /etc/my.cnf.d/mariadb-server.cnf.template \
    > /etc/my.cnf.d/mariadb-server.cnf

export MARIADB_USER_PASS=$(cat /run/secrets/mariadb_pass)
export MARIADB_ROOT_PASS=$(cat /run/secrets/mariadb_root_pass)

envsubst '${WORDPRESS_DATABASE_NAME} \
	 ${MARIADB_USER_PASS} \
	 ${MARIADB_USER} \
	 ${MARIADB_ROOT_PASS}' \
    < /docker-entrypoint-initdb.d/init.sql.template \
    > /docker-entrypoint-initdb.d/init.sql

echo "WORDPRESS_DATABASE_NAME $WORDPRESS_DATABASE_NAME"
echo "MARIADB_USER_PASS $MARIADB_USER_PASS"
echo "MARIADB_USER $MARIADB_USER"
echo "MARIADB_PORT $MARIADB_PORT"
cat /docker-entrypoint-initdb.d/init.sql

/usr/bin/mariadb-install-db \
    --defaults-file=/etc/my.cnf.d/mariadb-server.cnf


exec /usr/bin/mariadbd --console
