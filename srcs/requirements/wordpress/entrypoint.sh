#!/bin/sh

envsubst '${WORDPRESS_PORT}'  \
    < /etc/php84/php-fpm.d/www.conf.template \
    > /etc/php84/php-fpm.d/www.conf

MARIADB_USER_PASS=$(cat /run/secrets/mariadb_pass)
echo "MARIADB_USER_PASS=${MARIADB_USER_PASS}"

if ! [ -f index.php ]; then
    echo "WORDPRESS IS NOT YET DOWNLOADED"
    echo "INSTALLING WORDPRESS"
    chown -R root:root /var/www/html
    chmod -R 777 /var/www/html
    tar -xzv --strip-components=1 -f /tmp/wordpress.tar.gz -C /var/www/html/ > /dev/null
else
   echo "WORDPRESS IS ALREADY DOWNLOADED"
fi

check_mariadb() {
    # TODO MAKE PROPER HEALTHCHECK
    nc -z "$MARIADB_NETWORK_ALIAS" "${MARIADB_PORT:=3306}"
}

if ! [ -f wp-config.php ]; then
    echo "WORDPRESS IS NOT YET CONFIGURED"
    while ! check_mariadb ; do
	echo "MariaDB is not available yet. Waiting..."
	sleep 1
    done
    echo "CONFIGURING WORDPRESS"
    wp config create --dbname="$WORDPRESS_DATABASE_NAME" \
       --dbuser="$MARIADB_USER" \
       --dbhost="$MARIADB_NETWORK_ALIAS" \
       --dbpass="$MARIADB_USER_PASS" \
       --dbprefix="wp_" \
       --allow-root
else
   echo "WORDPRESS IS ALREADY CONFIGURED"
fi

while ! check_mariadb ; do
	echo "MariaDB is not available yet. Waiting..."
	sleep 1
done

if ! wp core is-installed --allow-root;
then
    echo "WORDPRESS IS NOT YET INSTALLED"
    wp core install \
    	--url="https://${INCEPTION_SERVER_NAME}" \
    	--title="${WORDPRESS_TITLE:=Inception}" \
    	--admin_user="maurodri" \
    	--admin_password="1234" \
    	--admin_email="maurodri@42.fr" \
    	--skip-email \
    	--allow-root;
else
    echo "WORDPRESS IS ALREADY INSTALLED"
fi

exec php-fpm84 -F
