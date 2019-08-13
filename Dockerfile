# Original: https://github.com/pypiserver/pypiserver/blob/master/Dockerfile
FROM python:3.7-alpine

ADD ./entrypoint.sh /entrypoint.sh

RUN apk update \
    && apk add --virtual .build-dependencies tzdata \
    && cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && echo "Asia/Taipei" >  /etc/timezone \
    && apk del .build-dependencies \
    && adduser -S -u 9898 pypiserver \
    && addgroup -S -g 9898 pypiserver \
    && pip install --upgrade --no-cache-dir pip \
    && pip install --no-cache-dir passlib pypiserver==1.3.0 \
    && mkdir -p /data/packages

VOLUME /data/packages

WORKDIR /data

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

