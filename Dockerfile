# Original: https://github.com/pypiserver/pypiserver/blob/master/Dockerfile
FROM alpine:3.10

ADD ./entrypoint.sh /entrypoint.sh

RUN apk update \
    && apk add --virtual .build-dependencies tzdata \
    && cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && echo "Asia/Taipei" >  /etc/timezone \
    && apk del .build-dependencies \
    && apk add python3 \
    && adduser -S -u 9898 pypiserver \
    && addgroup -S -g 9898 pypiserver \
    && pip3 install --no-cache-dir passlib pypiserver==1.3.0 \
    && mkdir -p /data/packages

VOLUME /data/packages

WORKDIR /data

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

