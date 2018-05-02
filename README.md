# healthchecks.io docker container

# Files

Example files available at `config/examples` for their equivalents at `config/`.

filename | purpose | notes
---|---|---
`config/django/local_settings.py` | settings for the application | cf. https://github.com/healthchecks/healthchecks#configuration
`config/nginx/*.conf` | nginx configuration file | any name is fine, will be mounted at /etc/nginx/conf.d/ in the nginx container
`db.env` | env variables for the database container | cg `db.example.env`

# Volumes

name | purpose | notes
`static_files` | contains Django's generated static files | used to share it 
`db` | contains postgres' data | best backed up using postgres tools to ensure consistency rather than backing up the volume

# env variables

The service is configured with environment varialbes via `.env` files. The `*.example.env` files can be used as templates, the filenames match the services' names in `docker-compose.yml`

file | name | purpose | notes
---|---|---|---
`db.env` | `POSTGRESS_DB` | database name to be created when first starting the `db` container
`db.env` | `POSTGRES_PASSWORD` | password for the postgres database
`hc.env` | `SU_EMAIL` | superuser email address | first user created when launching the app
`hc.env` | `SU_PASSWORD` | superuser password
`hc.env` | `SU_USERNAME` | superuser name


# Usage

`docker-compose up` and then access via `http://localhost:<port configured in nginx>/admin`. Use the superuser's credential defined in `hc.env`.
