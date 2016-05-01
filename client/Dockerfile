FROM alpine:3.3
MAINTAINER George Dernikos <geoder101@gmail.com>

WORKDIR /root

RUN apk update && \
    apk add openssh-client && \
    rm /var/cache/apk/*

EXPOSE 1080

COPY bin/prisonbreak-tunnel.sh /usr/local/bin/
COPY bin/prisonbreak-genkeys.sh /usr/local/bin/

CMD ["prisonbreak-tunnel.sh"]