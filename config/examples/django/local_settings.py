SITE_ROOT = "http://localhost"
SITE_NAME = "test hc"
DEFAULT_FROM_EMAIL = "healthchecks@example.com"

EMAIL_HOST = "example.com"
EMAIL_PORT = 587
EMAIL_HOST_USER = "healthchecks"
EMAIL_HOST_PASSWORD = "supersecure"
EMAIL_USE_TLS = True

ALLOWED_HOSTS = ['app']
DEBUG = False
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format' : "[%(asctime)s] %(levelname)s [%(name)s:%(lineno)s] %(message)s",
            'datefmt' : "%d/%b/%Y %H:%M:%S"
        },
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'django': {
            'handlers':['console'],
            'propagate': True,
            'level': 'INFO',
        },
        'hc': {
            'handlers': ['console'],
            'level': 'INFO',
        },
    }
}
