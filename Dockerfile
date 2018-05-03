FROM python:3

ENV APP_PATH=/usr/src/app
ENV PYTHONPATH=${APP_PATH}
ARG GUNICORN_VERSION=19.8

# install s6-overlay
ARG S6_OVERLAY_VERSION=1.21.4.0
ARG S6_OVERLAY_ARCH=x86
ENV S6_LOGGING_SCRIPT ""

ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-$S6_OVERLAY_ARCH.tar.gz /tmp

RUN tar xzf /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz -C / &&\
rm /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz

RUN pip install --no-cache-dir gunicorn==$GUNICORN_VERSION

RUN mkdir $APP_PATH
ADD ./app/requirements.txt $APP_PATH
RUN pip install --no-cache -r $APP_PATH/requirements.txt
ADD ./app $APP_PATH

COPY root/ /

VOLUME $APP_PATH
EXPOSE 8000

ENTRYPOINT ["/init"]
