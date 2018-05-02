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

COPY root/ /

RUN pip install --no-cache-dir gunicorn==$GUNICORN_VERSION

RUN mkdir $APP_PATH
ADD ./app/requirements.txt $APP_PATH
RUN pip install --no-cache -r $APP_PATH/requirements.txt
ADD ./app $APP_PATH

# RUN git clone https://github.com/healthchecks/healthchecks.git ${APP_PATH}

# RUN pip install --no-cache-dir -r ${APP_PATH}/requirements.txt && pip install --no-cache-dir gunicorn==19.8

# COPY ./config/django/local_settings.py ${APP_PATH}/hc/local_settings.py
# RUN ${APP_PATH}/manage.py migrate &&\
#   echo "from django.contrib.auth.models import User; User.objects.filter(email='admin@example.com').delete(); User.objects.create_superuser('admin', 'admin@example.com', 'nimda')" | python ${APP_PATH}/manage.py shell &&\
#   ${APP_PATH}/manage.py compress &&\
#   ${APP_PATH}/manage.py collectstatic --no-input

VOLUME $APP_PATH
EXPOSE 8000

# CMD ["gunicorn", "hc.wsgi", "--bind", "0.0.0.0:8000", "--workers", "3"]
# CMD ["/scripts/start-hc.sh"]
ENTRYPOINT ["/init"]
