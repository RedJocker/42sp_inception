FROM alpine:3.23.0
WORKDIR /var/www/html/
RUN apk add php84-fpm php84-mysqli php84 php84-phar php84-mbstring php84-pdo php84-pdo_mysql envsubst
ADD https://wordpress.org/latest.tar.gz /tmp/wordpress.tar.gz
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /bin/wp
COPY ./conf/www.conf.template /etc/php84/php-fpm.d/www.conf.template
COPY ./entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh
RUN chmod +x /bin/wp
CMD ["/run/entrypoint.sh"]
