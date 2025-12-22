FROM alpine:3.23.0
WORKDIR /var/www/html/
RUN apk add \
    php84 \
    php84-fpm \
    php84-mysqli \
    php84-json \
    php84-openssl \
    php84-curl \
    php84-zlib \
    php84-xml \
    php84-phar \
    php84-intl \
    php84-dom \
    php84-xmlreader \
    php84-xmlwriter \
    php84-tokenizer \
    php84-pecl-redis \
    php84-session \
    php84-mbstring \
    php84-gd \
    php84-exif \
    php84-iconv \
    php84-ctype \
    php84-opcache \
    php84-simplexml \
    php84-fileinfo \
    gettext-envsubst
ADD https://wordpress.org/latest.tar.gz /tmp/wordpress.tar.gz
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /bin/wp
COPY ./conf/www.conf.template /etc/php84/php-fpm.d/www.conf.template
COPY ./entrypoint.sh /run/entrypoint.sh
COPY ./healthcheck.sh /run/healthcheck.sh
RUN chmod +x /run/entrypoint.sh /bin/wp /run/healthcheck.sh
CMD ["/run/entrypoint.sh"]
