#!/bin/sh

if ! [ -f index.php ]; then
    echo "WORDPRESS IS NOT YET DOWNLOADED"
    echo "INSTALLING WORDPRESS"
    tar -xzv --strip-components=1 -f /tmp/wordpress.tar.gz -C /var/www/html/ > /dev/null
else
   echo "WORDPRESS IS ALREADY DOWNLOADED"
fi

check_mariadb() {
    nc -z db 3306
}

if ! [ -f wp-config.php ]; then
    echo "WORDPRESS IS NOT YET CONFIGURED"
    while ! check_mariadb ; do
	echo "MariaDB is not available yet. Waiting..."
	sleep 1
    done
    echo "CONFIGURING WORDPRESS"
    wp config create --dbname=my_db \
       --dbuser=root \
       --dbhost=db \
       --dbpass=1234 \
       --dbprefix="wp_" \
       --allow-root
else
   echo "WORDPRESS IS ALREADY CONFIGURED"
fi

if ! wp core is-installed --allow-root;
then
    echo "WORDPRESS IS NOT YET INSTALLED"
    wp core install \
    	--url="localhost:8080" \
    	--title="$inception" \
    	--admin_user="maurodri" \
    	--admin_password="1234" \
    	--admin_email="maurodri@42.fr" \
    	--skip-email \
    	--allow-root;
else
    echo "WORDPRESS IS ALREADY INSTALLED"
fi

exec php-fpm84 -F
