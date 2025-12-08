FROM alpine:3.23.0
WORKDIR /var/www/html/
RUN apk add php84-fpm php84-mysqli php84 php84-phar php84-mbstring php84-pdo php84-pdo_mysql
ADD https://wordpress.org/latest.tar.gz /tmp/wordpress.tar.gz
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /bin/wp
EXPOSE 9000
COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf
COPY ./entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh
RUN chmod +x /bin/wp
CMD ["/run/entrypoint.sh"]
