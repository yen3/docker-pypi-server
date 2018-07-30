# Original: https://github.com/pypiserver/pypiserver/blob/master/Dockerfile
FROM python:3.6-alpine

ADD ./entrypoint.sh /entrypoint.sh

RUN adduser -S -u 9898 pypiserver && \
    addgroup -S -g 9898 pypiserver && \
    pip install --upgrade --no-cache-dir pip && \
    pip install --no-cache-dir passlib pypiserver==1.2.2 && \
    cd / && \
    rm -rf /code && \
    mkdir -p /data/packages

VOLUME /data/packages

WORKDIR /data

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

