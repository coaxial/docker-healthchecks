# healthchecks.io docker container

# Files

Example files available in their respective locations with the `.example` extension.

filename | purpose | notes
---|---|---
`hc/app/config/local_settings.py` | settings for the application | cf. https://github.com/healthchecks/healthchecks#configuration
`nginx/config/hc.conf` | nginx configuration file | must be named `hc.conf`, will be mounted at /etc/nginx/conf.d/ in the nginx container
`{hc,db}/{hc,db}.env` | env variables for the app and database containers | cf. `*.env.example`

# Volumes

name | purpose | notes
`static_files` | contains Django's generated static files | used to share it 
`db` | contains postgres' data | best backed up using postgres tools to ensure consistency rather than backing up the volume

# env variables

The service is configured with environment varialbes via `.env` files. The `*.env.example` files can be used as templates, the filenames match the services' names in `docker-compose.yml`

file | name | purpose | notes
---|---|---|---
`db/db.env` | `POSTGRESS_DB` | database name to be created when first starting the `db` container
`db/db.env` | `POSTGRES_PASSWORD` | password for the postgres database
`hc/hc.env` | `SU_EMAIL` | superuser email address | first user created when launching the app
`hc/hc.env` | `SU_PASSWORD` | superuser password
`hc/hc.env` | `SU_USERNAME` | superuser name
`hc/hc.env` | `PG_PASSWORD` | postgresql password


# Usage

`docker-compose up` and then access via `http://localhost:6863/admin`. Use the superuser's credential defined in `hc.env`.
