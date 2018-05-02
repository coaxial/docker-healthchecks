#!/bin/sh
CORES_COUNT=$(grep -c ^processor /proc/cpuinfo)
# as per the gunicron docs
WORKERS_COUNT=$((CORES_COUNT + 1))

# pip install --no-cache-dir -r "${APP_PATH}/requirements.txt" &&\

cp /usr/src/config/local_settings.py "${APP_PATH}"/hc/ &&\

"${APP_PATH}/manage.py migrate" &&\
  echo "from django.contrib.auth.models import User; User.objects.filter(email='${SU_EMAIL}').delete(); User.objects.create_superuser('${SU_NAME}', '${SU_EMAIL}', '${SU_PASSWORD}')" | python ${APP_PATH}/manage.py shell &&\
  "${APP_PATH}/manage.py" compress &&\
  "${APP_PATH}/manage.py" collectstatic --no-input &&\

gunicorn hc.wsgi --bind 0.0.0.0:8000 --workers $WORKERS_COUNT
