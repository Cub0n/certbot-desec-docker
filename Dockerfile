ARG  FROM_IMAGE=certbot/certbot:amd64-v2.2.0
#Base
FROM ${FROM_IMAGE}

# Install the DNS plugin
RUN pip install certbot-dns-desec
