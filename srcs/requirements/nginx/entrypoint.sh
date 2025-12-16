#!/bin/sh

envsubst '${SSL_CERT_PATH}  \
	 ${SSL_CERT_KEY_PATH}  \
	 ${WORDPRESS_PORT} \
	 ${WORDPRESS_NETWORK_ALIAS} \
	 ${NGINX_CONTAINER_PORT}'  \
    < /etc/nginx/nginx.conf.template \
    > /etc/nginx/nginx.conf

nginx
