FROM alpine:3.23.0
WORKDIR /var/www/html/
RUN apk add php84-fpm php84-mysqli php84 php84-phar php84-mbstring php84-pdo php84-pdo_mysql gettext-envsubst
ADD https://wordpress.org/latest.tar.gz /tmp/wordpress.tar.gz
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /bin/wp
COPY ./conf/www.conf.template /etc/php84/php-fpm.d/www.conf.template
COPY ./entrypoint.sh /run/entrypoint.sh
COPY ./healthcheck.sh /run/healthcheck.sh
RUN chmod +x /run/entrypoint.sh /bin/wp /run/healthcheck.sh
CMD ["/run/entrypoint.sh"]
