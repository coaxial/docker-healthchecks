#!/usr/bin/with-contenv bash
# shellcheck shell=bash

# wait for postgres to be ready
# while [ "$(nc -z db 5432)" == "1" ]
until nc -z db 5432; do
  echo 'postgres not ready, will retry'
  sleep 1
done

echo 'postgres is ready'
