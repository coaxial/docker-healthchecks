FROM python:3

# apt is extremely slow in this container, we want this cached the most
RUN apt update &&\
  apt-get install postgresql-client netcat --no-install-recommends -y &&\
  rm -rf /var/lib/apt/lists/*

ARG GUNICORN_VERSION=19.8
ARG HC_VERSION=1.0.4
ENV SRC_PATH=/usr/src
ENV APP_PATH=$SRC_PATH/app
ENV PYTHONPATH=${APP_PATH}

# install s6-overlay
ARG S6_OVERLAY_VERSION=1.21.4.0
ARG S6_OVERLAY_ARCH=x86
ENV S6_LOGGING_SCRIPT=T

ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-$S6_OVERLAY_ARCH.tar.gz /tmp

RUN tar xzf /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz -C / &&\
rm /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz

RUN pip install --no-cache-dir gunicorn==$GUNICORN_VERSION

ADD https://github.com/healthchecks/healthchecks/archive/v$HC_VERSION.tar.gz /tmp
RUN tar xzf /tmp/v$HC_VERSION.tar.gz -C $SRC_PATH &&\
  rm /tmp/v$HC_VERSION.tar.gz &&\
  mv $SRC_PATH/healthchecks-$HC_VERSION $APP_PATH

RUN pip install --no-cache -r $APP_PATH/requirements.txt

COPY root/ /

VOLUME $APP_PATH
EXPOSE 8000

# necessary to get the output from Python's stdout.write instantly
ENV PYTHONUNBUFFERED=1
ENTRYPOINT ["/init"]
