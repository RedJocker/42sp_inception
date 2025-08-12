#!/bin/sh

/usr/bin/mariadb-install-db --user=mysql

exec /usr/bin/mariadbd --console
