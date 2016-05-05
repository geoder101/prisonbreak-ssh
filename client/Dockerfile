FROM alpine:edge
MAINTAINER George Dernikos <geoder101@gmail.com>

WORKDIR /root

RUN apk update && \
    apk add tini \
            openssh-client && \
    rm /var/cache/apk/*

EXPOSE 1080

COPY bin/prisonbreak-tunnel /usr/local/bin/
COPY bin/prisonbreak-genkeys /usr/local/bin/

ENTRYPOINT ["tini", "--"]
CMD ["prisonbreak-tunnel"]