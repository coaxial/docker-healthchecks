#!/usr/bin/with-contenv sh
# shellcheck shell=sh

# if the superuser exists in the db, that means that migrations have all been
# run and the app is ready
export PGPASSFILE=/root/.pgpass
echo "*:*:*:*:${PG_PASSWORD}" > /root/.pgpass
chmod 600 /root/.pgpass
until psql -h db -U postgres -d hc -t -w -c "select count(*) from auth_user where email='${SU_EMAIL}';" | grep 1; do
  echo 'migrations not yet completed, will retry'
  sleep 5
done
rm -rf /root/.pgpass
unset PGPASSFILE
unset PG_PASSWORD

echo 'migrations completed'
