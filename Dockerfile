FROM python:3

ENV APP_PATH=/usr/src/app
ENV PYTHONPATH=${APP_PATH}

RUN pip install --no-cache-dir gunicorn==19.8

RUN mkdir ${APP_PATH}
ADD ./app/requirements.txt $APP_PATH
RUN pip install --no-cache -r ${APP_PATH}/requirements.txt
ADD ./app $APP_PATH

# RUN git clone https://github.com/healthchecks/healthchecks.git ${APP_PATH}

# RUN pip install --no-cache-dir -r ${APP_PATH}/requirements.txt && pip install --no-cache-dir gunicorn==19.8

# COPY ./config/django/local_settings.py ${APP_PATH}/hc/local_settings.py
# RUN ${APP_PATH}/manage.py migrate &&\
#   echo "from django.contrib.auth.models import User; User.objects.filter(email='admin@example.com').delete(); User.objects.create_superuser('admin', 'admin@example.com', 'nimda')" | python ${APP_PATH}/manage.py shell &&\
#   ${APP_PATH}/manage.py compress &&\
#   ${APP_PATH}/manage.py collectstatic --no-input

VOLUME ${APP_PATH}
VOLUME /scripts
EXPOSE 8000

# CMD ["gunicorn", "hc.wsgi", "--bind", "0.0.0.0:8000", "--workers", "3"]
# CMD ["/scripts/start-hc.sh"]
ENTRYPOINT ["/init"]
