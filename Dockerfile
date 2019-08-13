# Original: https://github.com/pypiserver/pypiserver/blob/master/Dockerfile
FROM python:3.6-alpine

ADD ./entrypoint.sh /entrypoint.sh

RUN apk update \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && echo "Asia/Taipei" >  /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/* \
    && adduser -S -u 9898 pypiserver \
    && addgroup -S -g 9898 pypiserver \
    && pip install --upgrade --no-cache-dir pip \
    && pip install --no-cache-dir passlib pypiserver==1.2.4 \
    && cd / \
    && rm -rf /code \
    && mkdir -p /data/packages

VOLUME /data/packages

WORKDIR /data

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

