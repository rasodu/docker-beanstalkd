FROM alpine:3.3
MAINTAINER Adam Kusmierz <adam@kusmierz.be>

## Add Tini
RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini && rm -fr /var/cache/apk/*
ENTRYPOINT ["/usr/bin/tini", "--"]

ENV BEANSTALKD_VERSION="1.10"

RUN apk --update add --virtual build-dependencies \
  gcc \
  make \
  musl-dev \
  curl \
  && curl -sL https://github.com/kr/beanstalkd/archive/v$BEANSTALKD_VERSION.tar.gz | tar xvz -C /tmp \
  && cd /tmp/beanstalkd-$BEANSTALKD_VERSION \
  && sed -i "s|#include <sys/fcntl.h>|#include <fcntl.h>|g" sd-daemon.c \
  && make \
  && cp beanstalkd /usr/bin \
  && apk del build-dependencies \
  && rm -rf /tmp/* \
  && rm -rf /var/cache/apk/*

## Expose the port
EXPOSE 11300

CMD ["beanstalkd", "-p", "11300", "-u", "nobody"]
