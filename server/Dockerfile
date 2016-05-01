FROM alpine:3.3
MAINTAINER George Dernikos <geoder101@gmail.com>

RUN apk update && \
    apk add socat && \
    rm /var/cache/apk/*

EXPOSE 8022

CMD socat -d -d TCP-LISTEN:8022,fork TCP:0.0.0.0:22
