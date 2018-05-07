FROM python:3-alpine3.7

RUN apk --no-cache add borgbackup openssh-client postgresql-client sed

ARG BORGMATIC_VERSION=1.1.15
RUN pip3 install borgmatic==$BORGMATIC_VERSION

ARG S6_OVERLAY_VERSION=1.21.4.0
ARG S6_OVERLAY_ARCH=x86
ENV S6_LOGGING_SCRIPT "T"

ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-$S6_OVERLAY_ARCH.tar.gz /tmp

RUN tar xzf /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz -C / &&\
  rm /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz

RUN mkdir /pgdump &&\
  touch /root/passphrase

COPY root/ /

VOLUME /root/.ssh

ADD https://api.github.com/repos/chneukirchen/snooze/tarball/master /tmp
ARG SNOOZE_DEPS="make gcc musl-dev"
RUN mkdir /tmp/snooze &&\
  tar xzf /tmp/master -C /tmp/snooze --strip 1 &&\
  cd /tmp/snooze &&\
  apk --no-cache add $SNOOZE_DEPS &&\
  make install &&\
  rm -rf /tmp/snooze &&\
  rm -rf /tmp/master &&\
  apk --no-cache del $SNOOZE_DEPS

ENTRYPOINT ["/init"]
