ARG  FROM_IMAGE=certbot/certbot:latest
#Base
FROM ${FROM_IMAGE}

# Install the DNS plugin
RUN pip install certbot-dns-desec
