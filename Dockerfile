ARG  FROM_IMAGE=certbot/certbot
#Base
FROM ${FROM_IMAGE}

# Install the DNS plugin
RUN pip install certbot-dns-desec
