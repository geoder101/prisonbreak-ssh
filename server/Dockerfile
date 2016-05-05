FROM alpine:edge
MAINTAINER George Dernikos <geoder101@gmail.com>

WORKDIR /root

RUN apk update && \
    apk add tini \
            socat && \
    rm /var/cache/apk/*

EXPOSE 8022

ENTRYPOINT ["tini", "--"]
CMD ["socat", "-d", "-d", "TCP-LISTEN:8022,fork", "TCP:0.0.0.0:22"]
