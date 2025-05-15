FROM alpine:latest
RUN apk add php84-fpm
RUN mkdir /var/www
RUN mkdir /var/www/html
RUN echo '<?php phpinfo(); ?>' > /var/www/html/index.php
EXPOSE 9000
COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf
CMD ["php-fpm84", "-F"]
