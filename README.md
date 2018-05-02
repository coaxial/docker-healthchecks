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

# Usage

`docker-compose up` and then access via `http://localhost:<port configured in nginx>/admin`. The default user is `admin@example.com` and the default password is `nimda`. Both can be changed once logged in.
