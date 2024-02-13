FROM alpine:latest

LABEL maintainer="lex_admin <lex241080@gmail.com>" \
  name="Squid" description="Minimal Squid docker image based on Alpine Linux."

ARG UID=65534
ARG GID=65534
ENV UID=${UID}
ENV GID=${GID}

COPY ./entrypoint.sh /usr/local/bin

RUN chmod +x usr/local/bin/entrypoint.sh && \
  apk -U add --no-cache squid squid-lang-ru ca-certificates libressl tzdata shadow && \
  mv /etc/squid /usr/local/etc

VOLUME /etc/squid /var/log/squid /var/cache/squid

EXPOSE 3128/tcp

ENTRYPOINT ["entrypoint.sh"]

CMD [ "/usr/sbin/squid", "-NYC" ]
