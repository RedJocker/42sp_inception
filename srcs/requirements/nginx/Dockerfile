FROM alpine:3.23.0
COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY ./entrypoint.sh /runner/entrypoint.sh
COPY ./healthcheck.sh /runner/healthcheck.sh
RUN apk add nginx gettext-envsubst
RUN chmod +x /runner/entrypoint.sh /runner/healthcheck.sh
CMD ["/runner/entrypoint.sh"]
