#!/usr/bin/with-contenv sh
# shellsheck shell=sh

cp /usr/src/config/local_settings.py ${APP_PATH}/hc/local_settings.py
chown nobody ${APP_PATH}/hc/local_settings.py
