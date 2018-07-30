#!/bin/sh

mkdir -p /data/packages
chown -R pypiserver:pypiserver /data/packages
# Set the setgid bit so anything added here gets associated with the
# pypiserver group
chmod g+s /data/packages

su pypiserver
pypi-server -p 8080 $@ packages
