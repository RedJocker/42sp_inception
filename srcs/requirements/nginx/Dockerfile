FROM alpine:3.23.0
COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY ./entrypoint.sh /runner/entrypoint.sh
RUN apk add nginx gettext-envsubst
RUN chmod +x /runner/entrypoint.sh
CMD ["/runner/entrypoint.sh"]
