FROM alpine:latest
RUN apk add php84-fpm php84-mysqli
RUN mkdir -p /var/www/html
COPY ./temp/index.php /var/www/html/index.php
EXPOSE 9000
COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf
CMD ["php-fpm84", "-F"]
