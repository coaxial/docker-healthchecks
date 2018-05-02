#!/usr/bin/with-contenv sh
# shellcheck shell=sh
set -e

${APP_PATH}/manage.py migrate
echo "from django.contrib.auth.models import User; User.objects.create_superuser('${SU_USERNAME}', '${SU_EMAIL}', '${SU_PASSWORD}')if not User.objects.filter(username='${SU_USERNAME}').exists() else None" | python ${APP_PATH}/manage.py shell
${APP_PATH}/manage.py compress
${APP_PATH}/manage.py collectstatic --no-input
